\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lgc-paper}

% Pass normal article options through to the base class. The draft option is
% also forwarded to graphicx so \documentclass[draft]{lgc-paper} suppresses
% graphics inclusion during quick draft builds.
\DeclareOption{draft}{%
  \PassOptionsToClass{draft}{article}%
  \PassOptionsToPackage{draft}{graphicx}%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,letterpaper]{article}

% FONTS
% Papers use the XCharter text and math families.
\RequirePackage{fontspec}
\RequirePackage{mathtools}
\RequirePackage[mathbf=sym]{unicode-math}
\IfFontExistsTF{XCharter}{\setmainfont{XCharter}}{\PackageWarning{lgc-paper}{XCharter not found; using Latin Modern Roman fallback}\setmainfont{Latin Modern Roman}}
\IfFontExistsTF{XCharter Math}{\setmathfont{XCharter Math}}{\PackageWarning{lgc-paper}{XCharter Math not found; using Latin Modern Math fallback}\setmathfont{Latin Modern Math}}

% SHARED INFRASTRUCTURE
% lgc-base provides colors, links, graphics, tables, and citations.
% lgc-math owns the mathematical packages and custom commands.
\RequirePackage{lgc-base}
\RequirePackage{lgc-math}

% PAGE AND TEXT FORMATTING
\RequirePackage{geometry}       % [margin=1.35in]
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{titling}        % control over the typesetting of \maketitle
\RequirePackage[nodayofweek]{datetime}
\RequirePackage{multicol}
\RequirePackage{tcolorbox}
\RequirePackage{pdfpages}
\RequirePackage{enumitem}
\RequirePackage{paralist}       % list environments that...
                                % (a) can be used within paragraphs,
                                % (b) take care of enumeration, and
                                % (c) have items that can be referenced
\RequirePackage{dirtytalk}      % convenient quotation commands
\RequirePackage{threeparttable} % tables with notes, [flushleft]

% LINE LENGTH
% Three lowercase alphabets per line at the selected 11pt body font
% following the advice in Butterick (2013) /Practical Typography/
\newlength{\alphabetwidth}
\newlength{\minimumtextwidth}
\newlength{\alphabetbuffer}
\setlength{\alphabetbuffer}{0.25em}
\newcommand{\lgcsetalphabetwidth}{%
  \settowidth{\alphabetwidth}{%
    abcdefghijklmnopqrstuvwxyz%
    abcdefghijklmnopqrstuvwxyz%
    abcdefghijklmnopqrstuvwxyz%
  }%
  \setlength{\minimumtextwidth}{%
    \dimexpr\alphabetwidth+\alphabetbuffer\relax
  }%
  \newgeometry{textwidth=\minimumtextwidth,hcentering}%
}
\AtBeginDocument{\lgcsetalphabetwidth}

% Break URLs at hyphens: https://tex.stackexchange.com/a/254734/116532
\makeatletter
\g@addto@macro{\UrlBreaks}{\do\/\do\-}
\makeatother

% Turn on French spacing for more compact typesetting.
\frenchspacing

% DOCUMENT DEFAULTS
\linespread{1.1}
\setlength{\droptitle}{-1in}    % package: titling
\setlength{\parindent}{23pt}    % package: setspace
\setlist[description]{leftmargin=\parindent,labelindent=\parindent} % package: enumitem
\titleformat{\paragraph}[runin]{\normalsize\itshape}{}{}{}[---\ ]
\titlespacing*{\paragraph}{0pt}{0.5\baselineskip}{0pt}

% REFERENCES, APPENDICES, AND TABLE OF CONTENTS
\RequirePackage{appendix}
\RequirePackage{etoc}
\renewcommand{\sectionautorefname}{Section}
    \newlength\tocrulewidth
    \setlength{\tocrulewidth}{1pt}
    \etocsettocstyle{\rule{\linewidth}{\tocrulewidth}\vskip0.5\baselineskip}{\rule{\linewidth}{\tocrulewidth}}

% FIGURES, TABLES, AND PLOTS
\RequirePackage[
  font=footnotesize,
  labelfont=bf,
  labelsep=space,
  justification=raggedright,
  singlelinecheck=false
]{caption}
\DeclareCaptionLabelSeparator{periodem}{.\hspace{1em}}
\captionsetup[table]{position=top}
\renewcommand{\tablename}{\textsc{table}}
\renewcommand{\figurename}{\textsc{figure}}
\RequirePackage{subcaption}
\captionsetup{labelsep=periodem}
\RequirePackage{placeins}           % Package that prevents repositioning tables

% Neutral notes that can be migrated to journal-specific note environments.
\newenvironment{lgcfigurenotes}[1][Notes]{%
  \par\smallskip\begin{minipage}{\linewidth}\footnotesize
  \textit{#1.}~\ignorespaces
}{%
  \par\end{minipage}\par
}
\newenvironment{lgctablenotes}[1][Notes]{%
  \par\smallskip\begin{minipage}{\linewidth}\footnotesize
  \textit{#1.}~\ignorespaces
}{%
  \par\end{minipage}\par
}

\RequirePackage{tikz}
\RequirePackage{pgfplots}           % Package for creating plots from formulas
% TikZ and pgfplots settings: https://www.overleaf.com/learn/latex/Pgfplots_package
    \pgfplotsset{compat=1.9}        % ensure backwards compatibility
    \usetikzlibrary{external}       % speed up compilation
    \usepgfplotslibrary{external}
    \tikzexternalize[prefix=input/,optimize command away=\includepdf]

% SOURCE CODE AND ALGORITHMS
\RequirePackage{listings}
\RequirePackage{verbatim}                       % Package with \begin{comment} environment
\RequirePackage[rightnl,tworuled]{algorithm2e}  % [linesnumbered]
