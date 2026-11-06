"""Warm Cream color system. Matches ffloyd_colors.tex and the approved swatches.

Categorical: swatch order. Sequential: low to high. Diverging: negative to zero to positive.
Load with: import ffloyd_palette as ff
Example: ax.plot(x, y, color=ff.ff_green)
Example: ax.set_facecolor(ff.ff_background)
"""

from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

SYSTEM_NAME = "Warm Cream"

ff_background = "#EDE8D9"
ff_text = "#25606F"
ff_heading = "#164C67"
ff_link = "#164C67"
ff_ink = "#142C55"
ff_border = "#9EB29B"
ff_separator = "#739888"
ff_bullet = "#56867E"
ff_yellow = "#CB8A28"
ff_green = "#008464"
ff_blue = "#427EAF"
ff_terracotta = "#C05B43"
ff_violet = "#7864A0"
ff_rose = "#B4567C"
ff_olive = "#788238"
ff_deep_blue = "#164C67"
ff_cat_1 = "#CB8A28"
ff_cat_2 = "#008464"
ff_cat_3 = "#427EAF"
ff_cat_4 = "#C05B43"
ff_cat_5 = "#7864A0"
ff_cat_6 = "#B4567C"
ff_cat_7 = "#788238"
ff_cat_8 = "#164C67"
ff_seq_1 = "#EBD495"
ff_seq_2 = "#C2C16F"
ff_seq_3 = "#86B26E"
ff_seq_4 = "#3E9F77"
ff_seq_5 = "#1C847C"
ff_seq_6 = "#0F6779"
ff_seq_7 = "#164C67"
ff_div_neg_4 = "#6E3223"
ff_div_neg_3 = "#A94C2E"
ff_div_neg_2 = "#CD7F51"
ff_div_neg_1 = "#DDBC95"
ff_div_zero = "#F4F0E4"
ff_div_pos_1 = "#A6CBC7"
ff_div_pos_2 = "#5EA2A8"
ff_div_pos_3 = "#21778D"
ff_div_pos_4 = "#164C67"

COLORS = {
    "ff_background": ff_background,
    "ff_text": ff_text,
    "ff_heading": ff_heading,
    "ff_link": ff_link,
    "ff_ink": ff_ink,
    "ff_border": ff_border,
    "ff_separator": ff_separator,
    "ff_bullet": ff_bullet,
    "ff_yellow": ff_yellow,
    "ff_green": ff_green,
    "ff_blue": ff_blue,
    "ff_terracotta": ff_terracotta,
    "ff_violet": ff_violet,
    "ff_rose": ff_rose,
    "ff_olive": ff_olive,
    "ff_deep_blue": ff_deep_blue,
    "ff_cat_1": ff_cat_1,
    "ff_cat_2": ff_cat_2,
    "ff_cat_3": ff_cat_3,
    "ff_cat_4": ff_cat_4,
    "ff_cat_5": ff_cat_5,
    "ff_cat_6": ff_cat_6,
    "ff_cat_7": ff_cat_7,
    "ff_cat_8": ff_cat_8,
    "ff_seq_1": ff_seq_1,
    "ff_seq_2": ff_seq_2,
    "ff_seq_3": ff_seq_3,
    "ff_seq_4": ff_seq_4,
    "ff_seq_5": ff_seq_5,
    "ff_seq_6": ff_seq_6,
    "ff_seq_7": ff_seq_7,
    "ff_div_neg_4": ff_div_neg_4,
    "ff_div_neg_3": ff_div_neg_3,
    "ff_div_neg_2": ff_div_neg_2,
    "ff_div_neg_1": ff_div_neg_1,
    "ff_div_zero": ff_div_zero,
    "ff_div_pos_1": ff_div_pos_1,
    "ff_div_pos_2": ff_div_pos_2,
    "ff_div_pos_3": ff_div_pos_3,
    "ff_div_pos_4": ff_div_pos_4,
}

CATEGORICAL = [ff_cat_1, ff_cat_2, ff_cat_3, ff_cat_4, ff_cat_5, ff_cat_6, ff_cat_7, ff_cat_8]
SEQUENTIAL = [ff_seq_1, ff_seq_2, ff_seq_3, ff_seq_4, ff_seq_5, ff_seq_6, ff_seq_7]
DIVERGING = [ff_div_neg_4, ff_div_neg_3, ff_div_neg_2, ff_div_neg_1, ff_div_zero, ff_div_pos_1, ff_div_pos_2, ff_div_pos_3, ff_div_pos_4]

PALETTES = {
    "categorical": CATEGORICAL,
    "sequential": SEQUENTIAL,
    "diverging": DIVERGING,
}

def as_mpl_cmap(name="sequential"):
    """Return a discrete Matplotlib colormap, preserving the exact swatch colors.

    Requires matplotlib only when called. For signed data, center the color
    normalization at the reference value; the diverging midpoint is index 4.
    """
    from matplotlib.colors import ListedColormap
    return ListedColormap(PALETTES[name], name=f"ffloyd_{name}")

def render_preview(path=None):
    """Render swatches plus compact categorical, sequential, and diverging examples."""
    root = Path(path or __file__).resolve().parent
    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 10), facecolor=ff_background)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(1000, 0))
    ax.set_axis_off()
    ax.text(60, 42, "FFLOYD / WARM CREAM COLOUR SYSTEM", fontsize=11, color=ff_heading, va="top", weight="bold")
    ax.text(60, 76, "Categorical, sequential, and diverging", fontsize=29, color=ff_heading, va="top", weight="bold")
    ax.text(60, 126, f"Warm cream system for papers, slides, and data graphics  ·  Background {ff_background}", fontsize=13, color=ff_text, va="top")
    sections = [("CATEGORICAL", CATEGORICAL, 180), ("SEQUENTIAL · LOW → HIGH", SEQUENTIAL, 385), ("DIVERGING · BELOW → ABOVE REFERENCE", DIVERGING, 590)]
    for title, colors, y in sections:
        ax.text(60, y, title, fontsize=10, color=ff_heading, va="top", weight="bold")
        width = 1280 / len(colors)
        for i, color in enumerate(colors):
            x = 60 + i * width
            ax.add_patch(plt.Rectangle((x, y + 28), width - 5, 68, color=color, ec="none"))
            label = ("0" if i == len(colors)//2 else f"{i-len(colors)//2:+d}") if title.startswith("DIVERGING") else f"{i+1:02d}"
            ax.text(x, y + 104, label, fontsize=10, color=ff_text, va="top")
    chart = fig.add_axes([.06, .09, .34, .18], facecolor=ff_background)
    chart.bar(np.arange(len(CATEGORICAL)), [7, 11, 5, 9, 13, 8, 10, 6], color=CATEGORICAL, width=.75)
    chart.set_ylim(0, 16); chart.set_xticks([]); chart.set_yticks([]); chart.spines[:].set_visible(False)
    for y, colors, label in [(810, SEQUENTIAL, "Sequential strip: magnitude"), (880, DIVERGING, "Diverging strip: signed deviation around zero")]:
        rgb = np.array([[int(color[i:i + 2], 16) / 255 for i in (1, 3, 5)] for color in colors])
        ax.imshow(rgb[None, :, :], extent=(690, 1330, y, y + 30), aspect="auto")
        ax.text(690, y + 38, label, fontsize=10, color=ff_text, va="top")
    for extension in ("png", "svg"):
        fig.savefig(root / f"ffloyd_preview.{extension}", dpi=170, facecolor=ff_background)
    plt.close(fig)

if __name__ == "__main__":
    render_preview()
