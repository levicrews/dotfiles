"""Create a gold–green–blue sequential companion to the categorical palette."""
from pathlib import Path
import json

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch
import numpy as np

OUT = Path(__file__).resolve().parent
BACKGROUND = "#EDE8D9"
INK = "#164C67"
BODY = "#25606F"
# Equal OKLCH lightness steps; chroma stays within the sRGB gamut.
STOPS = np.array([
    [.8745, .085, 90],
    [.7945, .105, 108],
    [.7145, .105, 135],
    [.6345, .110, 163],
    [.5545, .090, 187],
    [.4745, .080, 216],
    [.3945, .071, 234.5],
])
NAMES = ["Pale gold", "Citron", "Leaf", "Jade", "Teal", "Ocean", "Deep blue"]


def linear_rgb(lch):
    lightness, chroma, hue = lch
    a, b = chroma * np.cos(np.deg2rad(hue)), chroma * np.sin(np.deg2rad(hue))
    l = (lightness + .3963377774*a + .2158037573*b)**3
    m = (lightness - .1055613458*a - .0638541728*b)**3
    s = (lightness - .0894841775*a - 1.291485548*b)**3
    return np.array([4.0767416621*l - 3.3077115913*m + .2309699292*s,
                     -1.2684380046*l + 2.6097574011*m - .3413193965*s,
                     -.0041960863*l - .7034186147*m + 1.707614701*s])


def srgb(lch):
    mapped = np.array(lch, dtype=float)
    rgb = linear_rgb(mapped)
    while rgb.min() < 0 or rgb.max() > 1:
        mapped[1] *= .995
        rgb = linear_rgb(mapped)
    return np.where(rgb <= .0031308, rgb * 12.92, 1.055 * rgb**(1/2.4) - .055)


def as_hex(rgb):
    return "#" + "".join(f"{round(float(c)*255):02X}" for c in rgb)


def luminance(rgb):
    linear = np.where(rgb <= .04045, rgb/12.92, ((rgb+.055)/1.055)**2.4)
    return linear @ np.array([.2126, .7152, .0722])


def render():
    colors = [as_hex(srgb(stop)) for stop in STOPS]
    t = np.linspace(0, 6, 512)
    samples = np.array([srgb([np.interp(v, np.arange(7), STOPS[:,j])
                             for j in range(3)]) for v in t])
    discrete = np.array([[int(color[i:i+2], 16)/255 for i in (1, 3, 5)]
                         for color in colors])
    # Check the exported colors and the full gradient for luminance reversals.
    assert np.all(np.diff(luminance(discrete)) < 0)
    assert np.all(np.diff(luminance(samples)) < 0)

    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 8.1), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0,1400), ylim=(810,0))
    ax.set_axis_off()

    def text(x,y,value,size=12,color=INK,**kwargs):
        ax.text(x,y,value,fontsize=size,color=color,va="top",**kwargs)

    text(65,45,"WARM CREAM / SEQUENTIAL",11,weight="bold")
    text(65,79,"Gold to green to deep blue",29,weight="bold")
    text(65,132,"Seven ordered steps  ·  Light to dark = low to high  ·  Background #EDE8D9",13,BODY)

    for i,(name,color) in enumerate(zip(NAMES,colors)):
        x=65+i*183
        ax.add_patch(FancyBboxPatch((x,207),170,180,
                                   boxstyle="round,pad=0,rounding_size=7",
                                   facecolor=color,edgecolor="none"))
        text(x,180,f"0{i+1}",10,BODY)
        text(x,404,name,13,weight="bold")
        text(x,434,color,11,family="DejaVu Sans Mono")

    text(65,500,"CONTINUOUS SCALE",10,weight="bold")
    ax.imshow(samples[np.newaxis,:,:],extent=(65,1333,586,540),aspect="auto")
    text(65,602,"Low",11)
    text(1333,602,"High",11,ha="right")

    ax.plot([65,1333],[653,653],color="#9EB29B",linewidth=.8)
    text(65,681,"CATEGORICAL ANCHORS",10,weight="bold")
    for x,name,color in [(400,"Yellow", "#CB8A28"),(730,"Green", "#008464"),(1060,"Deep blue",INK)]:
        ax.scatter([x],[702],s=280,color=color)
        text(x+25,681,name,12,weight="bold")
        text(x+25,707,color,10,family="DejaVu Sans Mono")
    text(65,765,"A proposed companion: lighter warm tones, green middle values, and the original deep blue endpoint.",10,BODY)

    for extension in ["png","svg"]:
        fig.savefig(OUT/f"ffloyd_sequential_swatch.{extension}",dpi=160,facecolor=BACKGROUND)
    plt.close(fig)
    payload={
        "name":"Warm cream sequential — gold to green to deep blue",
        "background":BACKGROUND,
        "direction":"low to high",
        "colors":[{"name":name,"hex":color,"oklch":stop.tolist()}
                  for name,color,stop in zip(NAMES,colors,STOPS)],
        "interpolation":"Piecewise linear OKLCH; reduce chroma if outside sRGB gamut",
        "validation":"Relative luminance strictly decreases in all seven rounded sRGB colors and 512 gradient samples",
        "note":"Proposed companion palette; original site heading color at the dark endpoint."
    }
    (OUT/"ffloyd_sequential_palette.json").write_text(json.dumps(payload,indent=2)+"\n")
    print("Colors:",", ".join(colors))
    print("Verified decreasing relative luminance for discrete colors and continuous gradient.")


if __name__ == "__main__":
    render()
