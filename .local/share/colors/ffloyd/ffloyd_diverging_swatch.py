"""Render a diverging companion on the warm cream background."""
from pathlib import Path
import json

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch
import numpy as np

from ffloyd_sequential_swatch import srgb, as_hex, luminance

OUT = Path(__file__).resolve().parent
BACKGROUND = "#EDE8D9"
INK = "#164C67"
BODY = "#25606F"
# Mirrored OKLCH lightness values give both sides comparable visual weight.
STOPS = np.array([
    [.3945, .090, 35],
    [.5300, .130, 38],
    [.6700, .115, 50],
    [.8150, .065, 72],
    [.9550, .016, 90],
    [.8150, .040, 188],
    [.6700, .070, 202],
    [.5300, .085, 219],
    [.3945, .071, 234.5],
])
NAMES = ["Oxide", "Rust", "Clay", "Sand", "Cream", "Mist", "Seafoam", "Teal", "Deep blue"]


def render():
    colors = [as_hex(srgb(stop)) for stop in STOPS]
    lab = np.column_stack((STOPS[:, 0],
                           STOPS[:, 1]*np.cos(np.deg2rad(STOPS[:, 2])),
                           STOPS[:, 1]*np.sin(np.deg2rad(STOPS[:, 2]))))
    samples = []
    for position in np.linspace(0, 8, 513):
        lightness, a, b = [np.interp(position, np.arange(9), lab[:, j]) for j in range(3)]
        samples.append(srgb([lightness, np.hypot(a, b), np.rad2deg(np.arctan2(b, a)) % 360]))
    samples = np.array(samples)
    discrete = np.array([[int(color[i:i+2], 16)/255 for i in (1, 3, 5)] for color in colors])
    for values, midpoint in [(luminance(discrete), 4), (luminance(samples), 256)]:
        assert np.all(np.diff(values[:midpoint+1]) > 0)
        assert np.all(np.diff(values[midpoint:]) < 0)
    assert np.allclose(STOPS[:4, 0], STOPS[5:, 0][::-1])

    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 8.1), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(810, 0))
    ax.set_axis_off()

    def text(x, y, value, size=12, color=INK, **kwargs):
        ax.text(x, y, value, fontsize=size, color=color, va="top", **kwargs)

    text(65, 45, "WARM CREAM / DIVERGING", 11, weight="bold")
    text(65, 79, "Terracotta / cream / teal-blue", 29, weight="bold")
    text(65, 132, "Nine balanced steps  ·  Pale center, stronger extremes  ·  Background #EDE8D9", 13, BODY)

    for i, (name, color) in enumerate(zip(NAMES, colors)):
        x = 65 + i*142
        text(x, 180, "0" if i == 4 else f"{i-4:+d}".replace("-", "−"), 10, BODY)
        ax.add_patch(FancyBboxPatch((x, 207), 132, 180,
                                   boxstyle="round,pad=0,rounding_size=7",
                                   facecolor=color, edgecolor="none"))
        text(x, 404, name, 12, weight="bold")
        text(x, 434, color, 10.5, family="DejaVu Sans Mono")

    text(65, 500, "CONTINUOUS SCALE", 10, weight="bold")
    ax.imshow(samples[np.newaxis, :, :], extent=(65, 1333, 586, 540), aspect="auto")
    ax.plot([699, 699], [587, 597], color=BODY, linewidth=.8)
    text(65, 606, "Below reference", 11)
    text(699, 606, "Reference / zero", 11, ha="center")
    text(1333, 606, "Above reference", 11, ha="right")

    ax.plot([65, 1333], [657, 657], color="#9EB29B", linewidth=.8)
    text(65, 685, "CATEGORICAL ANCHORS", 10, weight="bold")
    for x, name, color in [(400, "Terracotta", "#C05B43"),
                           (730, "Green", "#008464"),
                           (1060, "Deep blue", INK)]:
        ax.scatter([x], [706], s=280, color=color)
        text(x+25, 685, name, 12, weight="bold")
        text(x+25, 711, color, 10, family="DejaVu Sans Mono")
    text(65, 769, "Use around a meaningful midpoint, such as zero change or deviation from a target.", 10, BODY)

    for extension in ["png", "svg"]:
        fig.savefig(OUT/f"ffloyd_diverging_swatch.{extension}", dpi=160, facecolor=BACKGROUND)
    plt.close(fig)
    payload = {
        "name": "Warm cream diverging — terracotta to cream to teal-blue",
        "background": BACKGROUND,
        "direction": "below reference to above reference",
        "center_index": 4,
        "colors": [{"name": name, "hex": color, "oklch": stop.tolist(), "position": i-4}
                   for i, (name, color, stop) in enumerate(zip(NAMES, colors, STOPS))],
        "interpolation": "Piecewise linear OKLab; reduce chroma if outside sRGB gamut",
        "validation": "Mirrored OKLCH lightness; relative luminance increases strictly toward the midpoint from either end in nine rounded sRGB colors and 513 gradient samples",
        "note": "Proposed companion palette, with the original deep blue endpoint. Center represents the reference, not missing data."
    }
    (OUT/"ffloyd_diverging_palette.json").write_text(json.dumps(payload, indent=2)+"\n")
    print("Colors:", ", ".join(colors))
    print("Verified mirrored lightness and monotonic luminance on both sides of the midpoint.")


if __name__ == "__main__":
    render()
