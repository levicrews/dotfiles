\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lgc-slides}

\newif\iflgc@notes
\newif\iflgc@showonlynotes
\newif\iflgc@twoscreen
\DeclareOption{notes}{\lgc@notestrue}
\DeclareOption{showonlynotes}{\lgc@showonlynotestrue}
\DeclareOption{twoscreen}{\lgc@twoscreentrue}
\DeclareOption{background=cream}{\PassOptionsToPackage{background=cream}{lgc-metropolis}}
\DeclareOption{background=softcream}{\PassOptionsToPackage{background=softcream}{lgc-metropolis}}
\DeclareOption{background=white}{\PassOptionsToPackage{background=white}{lgc-metropolis}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[10pt,aspectratio=169]{beamer}

% FONTS
% Papers use the Fira text and math families.
\RequirePackage{fontspec}
\RequirePackage[mathbf=sym]{unicode-math}
\IfFontExistsTF{Fira Sans}{\setsansfont{Fira Sans}}{\PackageWarning{lgc-slides}{Fira Sans not found; using Latin Modern Sans fallback}\setsansfont{Latin Modern Sans}}
\IfFontExistsTF{Fira Math}{\setmathfont{Fira Math}}{\PackageWarning{lgc-slides}{Fira Math not found; using Latin Modern Math fallback}\setmathfont{Latin Modern Math}}

% SHARED INFRASTRUCTURE
% lgc-base provides colors, links, graphics, tables, and citations.
% lgc-math owns the mathematical packages and custom commands.
\RequirePackage{lgc-base}
\RequirePackage{lgc-math}
\RequirePackage{lgc-metropolis}
\RequirePackage{lgc-eqnannotate}

% OPTIONAL PRESENTER NOTES
\iflgc@notes
  \RequirePackage{pgfpages}
  \iflgc@showonlynotes
    \setbeameroption{show only notes}
  \else\iflgc@twoscreen
    \setbeameroption{show notes on second screen=right}
  \else
    \setbeameroption{show notes}
  \fi\fi
\fi
