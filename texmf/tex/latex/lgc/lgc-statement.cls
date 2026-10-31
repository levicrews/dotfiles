\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lgc-statement}

% Pass normal article options through to the base class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,letterpaper]{article}

% FONTS
\RequirePackage{fontspec}
\RequirePackage[mathbf=sym]{unicode-math}
\IfFontExistsTF{XCharter}{\setmainfont{XCharter}}{\setmainfont{Latin Modern Roman}}
\IfFontExistsTF{XCharter Math}{\setmathfont{XCharter Math}}{\setmathfont{Latin Modern Math}}

% SHARED INFRASTRUCTURE
% lgc-base provides colors, links, graphics, tables, and citations.
% lgc-math owns the mathematical packages and custom commands.
\RequirePackage{lgc-base}
\RequirePackage{lgc-math}

%% PAGE FORMATTING
\RequirePackage[margin=1.35in]{geometry}
\RequirePackage{microtype}
\setlength{\headheight}{15pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.55em}

% PAGE HEADERS AND FOOTERS
\RequirePackage{fancyhdr}
\RequirePackage{bold-extra}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\bfseries\scshape Levi Crews}
\fancyhead[R]{\bfseries\scshape Personal Statement}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
