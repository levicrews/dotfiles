"""Flexoki colour system, based on kepano/flexoki."""
from pathlib import Path
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap

SYSTEM_NAME = "Flexoki"
SYSTEM_SLUG = "flexoki"
BACKGROUND = "#FFFCF0"
INK = "#282726"
BASE = {
    "paper": "#FFFCF0", "base_50": "#F2F0E5", "base_100": "#E6E4D9",
    "base_200": "#CECDC3", "base_300": "#B7B5AC", "base_400": "#9F9D96",
    "base_500": "#878580", "base_600": "#6F6E69", "base_700": "#575653",
    "base_800": "#403E3C", "base_850": "#343331", "base_900": "#282726",
    "base_950": "#1C1B1A", "black": "#100F0F",
}
ACCENTS = {
    "red_400": "#D14D41", "red_600": "#AF3029", "orange_400": "#DA702C", "orange_600": "#BC5215",
    "yellow_400": "#D0A215", "yellow_600": "#AD8301", "green_400": "#879A39", "green_600": "#66800B",
    "cyan_400": "#3AA99F", "cyan_600": "#24837B", "blue_400": "#4385BE", "blue_600": "#205EA6",
    "purple_400": "#8B7EC8", "purple_600": "#5E409D", "magenta_400": "#CE5D97", "magenta_600": "#A02F6F",
}
CATEGORICAL = [ACCENTS[k] for k in ("red_600", "orange_600", "yellow_600", "green_600", "cyan_600", "blue_600", "purple_600", "magenta_600")]
SEQUENTIAL = ["#F6E2A0", "#B6BA62", "#7F993D", "#408B65", "#22758B", "#1E5697", "#163B66"]
DIVERGING = ["#942822", "#C03E35", "#DA702C", "#F9AE77", "#E6E4D9", "#92BFDB", "#4385BE", "#3171B2", "#163B66"]
PALETTES = {"categorical": CATEGORICAL, "sequential": SEQUENTIAL, "diverging": DIVERGING}

def as_mpl_cmap(name="sequential"):
    return ListedColormap(PALETTES[name], name=f"flexoki_{name}")

def _rgb(color):
    return np.array([int(color[i:i + 2], 16) / 255 for i in (1, 3, 5)])

def render_preview(path=None):
    root = Path(path or __file__).resolve().parent
    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 10), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(1000, 0)); ax.set_axis_off()
    text = lambda x, y, s, size=11, color=INK, **kw: ax.text(x, y, s, fontsize=size, color=color, va="top", **kw)
    text(60, 42, "FLEXOKI / INKY COLOUR SYSTEM", 11, weight="bold")
    text(60, 76, "Categorical, sequential, and diverging", 29, weight="bold")
    text(60, 126, "Official Flexoki paper, base, and accent colors adapted for data graphics", 13, "#575653")
    sections = [("CATEGORICAL", CATEGORICAL, 180), ("SEQUENTIAL · LOW → HIGH", SEQUENTIAL, 385), ("DIVERGING · BELOW → ABOVE REFERENCE", DIVERGING, 590)]
    for title, colors, y in sections:
        text(60, y, title, 10, weight="bold")
        width = 1280 / len(colors)
        for i, color in enumerate(colors):
            x = 60 + i * width
            ax.add_patch(plt.Rectangle((x, y + 28), width - 5, 68, color=color, ec="none"))
            label = ("0" if i == len(colors)//2 else f"{i-len(colors)//2:+d}") if title.startswith("DIVERGING") else f"{i+1:02d}"
            text(x, y + 104, label, 10, "#575653")
    chart = fig.add_axes([.06, .09, .34, .18], facecolor=BACKGROUND)
    chart.bar(np.arange(8), [7, 11, 5, 9, 13, 8, 10, 6], color=CATEGORICAL, width=.75)
    chart.set_ylim(0, 16); chart.set_xticks([]); chart.set_yticks([]); chart.spines[:].set_visible(False)
    for y, colors, label in [(810, SEQUENTIAL, "Sequential strip: magnitude"), (880, DIVERGING, "Diverging strip: signed deviation around zero")]:
        ax.imshow(np.array([_rgb(c) for c in colors])[None, :, :], extent=(690, 1330, y, y + 30), aspect="auto")
        text(690, y + 38, label, 10, "#575653")
    for ext in ("png", "svg"):
        fig.savefig(root / f"flexoki_preview.{ext}", dpi=170, facecolor=BACKGROUND)
    plt.close(fig)

if __name__ == "__main__":
    render_preview()
