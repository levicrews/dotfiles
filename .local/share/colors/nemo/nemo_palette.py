"""Nemo colour system: broad, accessible palettes based on supplied swatches."""
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap

SYSTEM_NAME = "Nemo"
SYSTEM_SLUG = "nemo"
BACKGROUND = "#FBFAF7"
INK = "#112A3C"
BACKGROUNDS = {"page": BACKGROUND, "figure": BACKGROUND, "slide": BACKGROUND}

SOURCE = {
    "blue": "#6182B5", "darkblue": "#112A3C", "red": "#AF3127",
    "orange": "#D99C37", "green": "#90A954", "palegreen": "#C5B868",
    "yellow": "#FAC764", "brokenwhite": "#DAC0A6", "brokengrey": "#C4C2D1",
}

CATEGORICAL = ["#6182B5", "#AF3127", "#90A954", "#D99C37", "#112A3C", "#3E7C73", "#756889", "#C5B868"]
SEQUENTIAL = ["#FAC764", "#9EAD56", "#619165", "#3E757A", "#335677", "#1F3E56", "#112A3C"]
DIVERGING = ["#8D211D", "#AF3127", "#C86D3C", "#DAC0A6", "#F4F1EA", "#C4C2D1", "#91A4BE", "#6182B5", "#112A3C"]
PALETTES = {"categorical": CATEGORICAL, "sequential": SEQUENTIAL, "diverging": DIVERGING}


def _rgb(hex_color):
    return np.array([int(hex_color[i:i + 2], 16) / 255 for i in (1, 3, 5)])


def relative_luminance(hex_color):
    rgb = _rgb(hex_color)
    linear = np.where(rgb <= .04045, rgb / 12.92, ((rgb + .055) / 1.055) ** 2.4)
    return float(linear @ np.array([.2126, .7152, .0722]))


def contrast_ratio(first, second):
    a, b = sorted((relative_luminance(first), relative_luminance(second)), reverse=True)
    return (a + .05) / (b + .05)


def as_mpl_cmap(name="sequential"):
    return ListedColormap(PALETTES[name], name=f"nemo_{name}")


def _text(ax, x, y, value, size=11, color=INK, **kwargs):
    ax.text(x, y, value, fontsize=size, color=color, va="top", **kwargs)


def render_preview(path=None):
    """Render swatches plus compact categorical, sequential, and diverging examples."""
    out = Path(path or __file__).resolve().parent / "nemo_preview.png"
    plt.rcParams.update({"font.family": "DejaVu Sans", "svg.fonttype": "none"})
    fig = plt.figure(figsize=(14, 10), facecolor=BACKGROUND)
    ax = fig.add_axes([0, 0, 1, 1], xlim=(0, 1400), ylim=(1000, 0))
    ax.set_axis_off()
    _text(ax, 60, 42, "NEMO / UNIFIED COLOUR SYSTEM", 11, weight="bold")
    _text(ax, 60, 76, "Categorical, sequential, and diverging", 29, weight="bold")
    _text(ax, 60, 126, "Nemo Fournier source colours, extended for broad and accessible data graphics", 13, "#3E6489")
    sections = [("CATEGORICAL", CATEGORICAL, 180), ("SEQUENTIAL · LOW → HIGH", SEQUENTIAL, 385), ("DIVERGING · BELOW → ABOVE REFERENCE", DIVERGING, 590)]
    for title, colors, y in sections:
        _text(ax, 60, y, title, 10, weight="bold")
        width = 1280 / len(colors)
        for i, color in enumerate(colors):
            x = 60 + i * width
            ax.add_patch(plt.Rectangle((x, y + 28), width - 5, 68, color=color, ec="none"))
            if title.startswith("DIVERGING"):
                label = "0" if i == 4 else f"{i - 4:+d}"
            else:
                label = f"{i + 1:02d}"
            _text(ax, x, y + 104, label, 10, "#3E6489")
    chart = fig.add_axes([.06, .09, .34, .18], facecolor=BACKGROUND)
    chart.bar(np.arange(8), [7, 11, 5, 9, 13, 8, 10, 6], color=CATEGORICAL, width=.75)
    chart.set_ylim(0, 16); chart.set_xticks([]); chart.set_yticks([])
    chart.spines[['top', 'right', 'left', 'bottom']].set_visible(False)
    chart.tick_params(colors="#3E6489", labelsize=9)
    _text(ax, 60, 935, "Categorical bars: unrelated groups", 10, "#3E6489")
    for y, colors, label in [(810, SEQUENTIAL, "Sequential strip: magnitude"), (880, DIVERGING, "Diverging strip: signed deviation around zero")]:
        ax.imshow(np.array([_rgb(color) for color in colors])[None, :, :], extent=(690, 1330, y, y + 30), aspect="auto")
        _text(ax, 690, y + 38, label, 10, "#3E6489")
    fig.savefig(out, dpi=170, facecolor=BACKGROUND)
    fig.savefig(out.with_suffix(".svg"), facecolor=BACKGROUND)
    plt.close(fig)
    return out


if __name__ == "__main__":
    assert all(contrast_ratio(c, BACKGROUND) >= 3 for c in [CATEGORICAL[0], CATEGORICAL[1], CATEGORICAL[4], CATEGORICAL[5], CATEGORICAL[6]])
    assert all(relative_luminance(a) > relative_luminance(b) for a, b in zip(SEQUENTIAL, SEQUENTIAL[1:]))
    assert all(relative_luminance(a) < relative_luminance(b) for a, b in zip(DIVERGING[:4], DIVERGING[1:5]))
    assert all(relative_luminance(a) > relative_luminance(b) for a, b in zip(DIVERGING[4:], DIVERGING[5:]))
    render_preview()
    print("Nemo preview rendered.")
