"""Metromuted colour system; canonical Python/Matplotlib export."""

from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

BACKGROUND = "#FAFAFA"
WHITE = "#FFFFFF"
OFF_WHITE = "#F8F8F5"
LIGHT_GRAY = "#E4E7E8"
MID_GRAY = "#737B7E"
DARK_GRAY = "#263238"
INK = DARK_GRAY
BACKGROUNDS = {"white": WHITE, "metropolis": BACKGROUND, "off_white": OFF_WHITE, "figure": OFF_WHITE}

CATEGORICAL = ["#B71E2E", "#E68B28", "#E9A508", "#4B8EC2", "#14364C", "#227763"]
SEQUENTIAL = ["#E9A508", "#56A841", "#15866F", "#2C6671", "#3F4274", "#5B176C"]
DIVERGING = ["#C7352C", "#EA8F2F", "#FCD35E", "#A4D6E9", "#278EE8", "#2A36A0"]
PALETTES = {"categorical": CATEGORICAL, "sequential": SEQUENTIAL, "diverging": DIVERGING}

SYSTEM_NAME = "Metromuted"
SYSTEM_SLUG = "metromuted"

def as_mpl_cmap(name="sequential"):
    from matplotlib.colors import ListedColormap
    return ListedColormap(PALETTES[name], name=f"metromuted_{name}")

def render_preview(path=None):
    """Render swatches plus compact categorical, sequential, and diverging examples."""
    root = Path(path or __file__).resolve().parent
    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 10), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(1000, 0))
    ax.set_axis_off()
    ax.text(60, 42, "METROMUTED / MUTED PROFESSIONAL COLOUR SYSTEM", fontsize=11, color=INK, va="top", weight="bold")
    ax.text(60, 76, "Categorical, sequential, and diverging", fontsize=29, color=INK, va="top", weight="bold")
    ax.text(60, 126, f"Metropolis-compatible research palette  ·  Background {BACKGROUND}", fontsize=13, color=DARK_GRAY, va="top")
    sections = [("CATEGORICAL", CATEGORICAL, 180), ("SEQUENTIAL · LOW → HIGH", SEQUENTIAL, 385), ("DIVERGING · BELOW → ABOVE REFERENCE", DIVERGING, 590)]
    for title, colors, y in sections:
        ax.text(60, y, title, fontsize=10, color=INK, va="top", weight="bold")
        width = 1280 / len(colors)
        for i, color in enumerate(colors):
            x = 60 + i * width
            ax.add_patch(plt.Rectangle((x, y + 28), width - 5, 68, color=color, ec="none"))
            label = ("0" if i == len(colors)//2 else f"{i-len(colors)//2:+d}") if title.startswith("DIVERGING") else f"{i+1:02d}"
            ax.text(x, y + 104, label, fontsize=10, color=DARK_GRAY, va="top")
    chart = fig.add_axes([.06, .09, .34, .18], facecolor=BACKGROUND)
    chart.bar(np.arange(len(CATEGORICAL)), [7, 11, 5, 9, 13, 8], color=CATEGORICAL, width=.75)
    chart.set_ylim(0, 16); chart.set_xticks([]); chart.set_yticks([]); chart.spines[:].set_visible(False)
    for y, colors, label in [(810, SEQUENTIAL, "Sequential strip: magnitude"), (880, DIVERGING, "Diverging strip: signed deviation around zero")]:
        rgb = np.array([[int(color[i:i + 2], 16) / 255 for i in (1, 3, 5)] for color in colors])
        ax.imshow(rgb[None, :, :], extent=(690, 1330, y, y + 30), aspect="auto")
        ax.text(690, y + 38, label, fontsize=10, color=DARK_GRAY, va="top")
    for extension in ("png", "svg"):
        fig.savefig(root / f"metromuted_preview.{extension}", dpi=170, facecolor=BACKGROUND)
    plt.close(fig)

if __name__ == "__main__":
    render_preview()
