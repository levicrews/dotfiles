"""Render a proposed categorical palette on ffloyd.space's light background."""
from pathlib import Path
import json

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

OUT = Path(__file__).resolve().parent
BACKGROUND = "#EDE8D9"
INK = "#164C67"
BODY = "#25606F"
COLORS = [
    ("Golden yellow", "#CB8A28", "Original highlight"),
    ("Jade green", "#008464", "Original highlight"),
    ("Blue", "#427EAF", "New companion"),
    ("Terracotta", "#C05B43", "New companion"),
    ("Violet", "#7864A0", "New companion"),
    ("Rose", "#B4567C", "New companion"),
    ("Olive", "#788238", "New companion"),
    ("Deep blue", "#164C67", "Original heading color"),
]


def render():
    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 9.7), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(970, 0))
    ax.set_axis_off()

    def text(x, y, value, size=12, color=INK, **kwargs):
        ax.text(x, y, value, fontsize=size, color=color, va="top", **kwargs)

    text(65, 45, "WARM CREAM / CATEGORICAL", 11, weight="bold")
    text(65, 79, "Yellow + green, extended", 29, weight="bold")
    text(65, 132, "Eight-color starting palette  ·  Background #EDE8D9", 13, BODY)

    for i, (name, color, origin) in enumerate(COLORS):
        row, col = divmod(i, 4)
        x, y = 65 + 322 * col, 198 + 262 * row
        ax.add_patch(FancyBboxPatch((x, y), 302, 145,
                                   boxstyle="round,pad=0,rounding_size=8",
                                   facecolor=color, edgecolor="none"))
        text(x, y + 160, name, 15, weight="bold")
        text(x, y + 188, color, 12, family="DejaVu Sans Mono")
        text(x, y + 213, origin, 10, BODY)

    ax.plot([65, 1333], [730, 730], color="#9EB29B", linewidth=.8)
    text(65, 756, "SMALL MARKS ON CREAM", 10, weight="bold")
    for i, (_, color, _) in enumerate(COLORS):
        x = 90 + i * 161
        ax.plot([x, x + 90], [815, 815], color=color, linewidth=3,
                solid_capstyle="round")
        ax.scatter([x + 45], [815], s=110, color=color, zorder=3)
        text(x + 45, 844, f"{i + 1:02}", 11, ha="center")

    text(65, 916, "Original yellow and green retained; companion hues proposed for this background.", 10, BODY)
    fig.savefig(OUT / "ffloyd_categorical_swatch.png", dpi=160, facecolor=BACKGROUND)
    fig.savefig(OUT / "ffloyd_categorical_swatch.svg", facecolor=BACKGROUND)
    plt.close(fig)
    data = {
        "name": "Warm cream categorical — first proposal",
        "background": BACKGROUND,
        "colors": [{"name": name, "hex": color, "origin": origin}
                   for name, color, origin in COLORS],
        "source": "https://ffloyd.space/about",
        "note": "Companion colors are proposed additions, not extracted site colors."
    }
    (OUT / "ffloyd_categorical_palette.json").write_text(json.dumps(data, indent=2) + "\n")


if __name__ == "__main__":
    render()
