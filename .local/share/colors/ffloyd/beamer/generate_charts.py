"""Generate three reproducible, synthetic charts using the local LaTeX palette.

Run: python3 generate_charts.py
Requires NumPy and Matplotlib. Outputs vector PDFs and PNG previews in figures/.
"""
from pathlib import Path
import csv
import argparse
import re
import subprocess

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib import font_manager
from matplotlib.colors import BoundaryNorm, ListedColormap, to_rgb
import numpy as np

ROOT = Path(__file__).resolve().parent
FIGURES = ROOT / "figures"
COLORS = {name: "#" + value for name, value in re.findall(
    r"\\definecolor\{([^}]+)\}\{HTML\}\{([A-F0-9]{6})\}",
    (ROOT / "ffloyd_colors.tex").read_text())}
CAT = [COLORS["ff_" + name] for name in
       ["yellow", "green", "blue", "terracotta", "violet", "rose", "olive", "deep_blue"]]
SEQ = [COLORS[f"ff_seq_{i}"] for i in range(1, 8)]
DIV = ([COLORS[f"ff_div_neg_{i}"] for i in range(4, 0, -1)] +
       [COLORS["ff_div_zero"]] + [COLORS[f"ff_div_pos_{i}"] for i in range(1, 5)])
BG, TEXT, INK = (COLORS[k] for k in ["ff_background", "ff_text", "ff_heading"])


def setup():
    FIGURES.mkdir(parents=True, exist_ok=True)
    family = "DejaVu Sans"
    for filename in ["FiraSans-Regular.otf", "FiraSans-Medium.otf"]:
        try:
            path = subprocess.check_output(["kpsewhich", filename], text=True).strip()
            if path:
                font_manager.fontManager.addfont(path)
                family = "Fira Sans"
        except (FileNotFoundError, subprocess.CalledProcessError):
            pass
    plt.rcParams.update({
        "font.family": family, "font.size": 17, "text.color": TEXT,
        "axes.labelcolor": TEXT, "xtick.color": TEXT, "ytick.color": TEXT,
        "axes.edgecolor": COLORS["ff_border"], "figure.facecolor": BG,
        "axes.facecolor": BG, "savefig.facecolor": BG, "pdf.fonttype": 42,
        "axes.spines.top": False, "axes.spines.right": False,
    })


def save(fig, name):
    fig.savefig(FIGURES / f"{name}.pdf", facecolor=BG)
    fig.savefig(FIGURES / f"{name}.png", facecolor=BG, dpi=160)
    plt.close(fig)


def categorical():
    modes = ["Bus", "Metro", "Walk", "Cycle", "Tram", "Rail", "Ferry", "Shuttle"]
    values = [24, 21, 16, 13, 9, 8, 5, 4]
    assert sum(values) == 100
    fig, ax = plt.subplots(figsize=(11.8, 4.1))
    fig.subplots_adjust(left=.14, right=.96, bottom=.19, top=.98)
    y = np.arange(8)
    ax.barh(y, values, color=CAT, height=.68, zorder=3)
    ax.set_yticks(y, modes)
    ax.invert_yaxis()
    ax.set_xlim(0, 28)
    ax.set_xticks([0, 5, 10, 15, 20, 25], ["0", "5", "10", "15", "20", "25%"])
    ax.set_xlabel("Share of trips", labelpad=8)
    ax.tick_params(axis="both", length=0)
    ax.spines[["left", "bottom"]].set_visible(False)
    ax.xaxis.grid(True, color=COLORS["ff_border"], linewidth=.6, alpha=.55)
    for i, v in enumerate(values):
        ax.text(v+.4, i, f"{v}%", va="center", fontsize=16, color=INK)
    with (FIGURES / "categorical.csv").open("w") as out:
        writer = csv.writer(out); writer.writerow(["mode", "share_percent"])
        writer.writerows(zip(modes, values))
    save(fig, "categorical")


def sequential():
    rng = np.random.default_rng(42)
    weeks = np.arange(10)
    values = np.clip(12 + weeks[None, :]*6 + np.arange(7)[:, None]*4
                     + rng.normal(0, 5, (7, 10)), 0, 100).round().astype(int)
    fig, ax = plt.subplots(figsize=(11.8, 4.1))
    fig.subplots_adjust(left=.14, right=.98, bottom=.29, top=.94)
    norm = BoundaryNorm(np.linspace(0, 100, 8), 7, clip=True)
    assert len(np.unique(norm(values))) == 7
    mesh = ax.pcolormesh(np.arange(11), np.arange(8), values, cmap=ListedColormap(SEQ),
                         norm=norm, edgecolors=BG, linewidth=2, antialiased=True)
    ax.set_yticks(np.arange(7)+.5, [f"District {c}" for c in "ABCDEFG"])
    ax.set_xticks(np.arange(10)+.5, [str(i) for i in range(1, 11)])
    ax.set_xlabel("Week", labelpad=5)
    ax.invert_yaxis()
    ax.tick_params(length=0, labelsize=15)
    for spine in ax.spines.values(): spine.set_visible(False)
    cax = fig.add_axes([.30, .08, .57, .04])
    cb = fig.colorbar(mesh, cax=cax, orientation="horizontal", ticks=[0, 25, 50, 75, 100])
    cb.outline.set_visible(False)
    cb.ax.tick_params(length=0, labelsize=13)
    with (FIGURES / "sequential.csv").open("w") as out:
        writer = csv.writer(out); writer.writerow(["district", "week", "availability_index"])
        writer.writerows((c, j+1, int(values[i,j])) for i,c in enumerate("ABCDEFG") for j in range(10))
    save(fig, "sequential")


def diverging():
    areas = ["North", "Harbor", "Old town", "East", "Central", "West", "University", "South", "Riverside"]
    values = np.array([-11.2, -8.6, -5.4, -2.7, 0.2, 3.1, 6.5, 8.8, 12.4])
    norm = BoundaryNorm(np.arange(-13.5, 14, 3), 9)
    assert np.array_equal(norm(values), np.arange(9))
    fig, ax = plt.subplots(figsize=(11.8, 4.1))
    fig.subplots_adjust(left=.18, right=.96, bottom=.19, top=.98)
    y = np.arange(9)
    ax.barh(y, values, color=DIV, height=.65, zorder=3)
    # A small outlined mark keeps the near-zero cream value visible.
    ax.scatter([values[4]], [4], s=48, color=DIV[4], edgecolors=INK, linewidth=.65, zorder=4)
    ax.axvline(0, color=INK, linewidth=1, zorder=2)
    ax.set_yticks(y, areas)
    ax.invert_yaxis()
    ax.set_xlim(-15, 16)
    ax.set_xticks([-12, -6, 0, 6, 12], ["-12", "-6", "0", "+6", "+12"])
    ax.set_xlabel("Change in satisfaction (percentage points)", labelpad=8)
    ax.tick_params(length=0, labelsize=15)
    ax.xaxis.grid(True, color=COLORS["ff_border"], linewidth=.6, alpha=.5)
    ax.spines[["left", "bottom"]].set_visible(False)
    for i, v in enumerate(values):
        ax.text(v + (.5 if v >= 0 else -.5), i, f"{v:+.1f}",
                va="center", ha="left" if v >= 0 else "right", fontsize=15, color=INK)
    with (FIGURES / "diverging.csv").open("w") as out:
        writer = csv.writer(out); writer.writerow(["area", "change_percentage_points"])
        writer.writerows(zip(areas, values))
    save(fig, "diverging")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--background", choices=["cream", "white", "softcream", "both", "all"], default="cream")
    args = parser.parse_args()
    variants = ["cream", "white"] if args.background == "both" else [args.background]
    if args.background == "all":
        variants = ["cream", "softcream", "white"]
    backgrounds = {"cream": COLORS["ff_background"], "white": "#FAFAFA", "softcream": "#F4F1EA"}
    for variant in variants:
        BG = backgrounds[variant]
        FIGURES = ROOT / "figures" if variant == "cream" else ROOT / "figures" / variant
        setup()
        categorical()
        sequential()
        diverging()
        print(f"Generated {variant} charts and their synthetic CSV data.")
