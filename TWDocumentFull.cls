\ProvidesClass{TWDocumentFull}[2024/10/22 Custom Reports]

% OPTIONS
\newif\ifhidedate
\hidedatefalse

% Declare Options
\DeclareOption{hidedate}{\hidedatetrue}

\ProcessOptions\relax

% BASE CLASS
\LoadClass[a4paper,11pt]{article}

% GENERAL PACKAGES
\usepackage{etoolbox, titlesec}
\usepackage{tabularx}
\usepackage{hyperref}
\usepackage{booktabs}
\usepackage{caption}

% GRAPHICS
\RequirePackage{graphicx}
\graphicspath{{static/img}}
\newcommand{\@mainlogo}{logo.png}

% PAGE MARGINS
\RequirePackage[top=4.75cm,        bottom=2.5cm,
                left=2cm,        right=2cm,
                headheight=4.25cm, headsep=5mm,
                footskip=2.5ex]{geometry}

% COLORS
\RequirePackage[table]{xcolor}
\definecolor{twgray}{RGB/cmyk}{235,235,230/0,0,0,.1}
\definecolor{twblue}{HTML}{35A8F6}
\colorlet{twlightblue}{twblue!20}

\newcommand{\tightlist}{
    \setlength{\itemsep}{0pt}  % Remove vertical space between items
    \setlength{\parskip}{0pt}  % Remove space between paragraphs
}

% CUSTOM FONTS
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{textcomp}
\usepackage{lmodern}
\usepackage{slantsc}
\usepackage{relsize}
\usepackage{enumitem}
\usepackage{tabularray}
\usepackage{framed}
\usepackage{listings}
\usepackage{float}

\usepackage{newunicodechar}
\newunicodechar{≤}{\ensuremath{\leq}}
\newunicodechar{≥}{\ensuremath{\geq}}
\newunicodechar{−}{\ensuremath{-}}

\setlength{\parindent}{0pt}

\renewcommand*\familydefault{\sfdefault}
\usefont{T1}{lmss}{m}{n}\selectfont
\DeclareFontShape{T1}{lmss}{m}{sc}{<->ssub*lmss/m/n}{}

\newcommand{\@labeltext}[1]{\textbf{\scriptsize #1}}
\newcommand{\@LabelText}[1]{\MakeUppercase{\@labeltext{#1}}}
\newcommand{\LabelText}[1]{\@LabelText{#1}}

\newcommand{\@LabelValue}[1]{\scriptsize #1}
\newcommand{\LabelValue}[1]{\@LabelValue{#1}}

% SEPARATOR
\newcommand{\@separator}{%
    % To make sure we have spacing on both sides, make an invisible rule, 2X tall
    \rule{0ex}{2ex}%
    % Place the dashed rule 1X high
    \textcolor{twgray}{\rule[1ex]{\textwidth}{0.25pt}}%
}

% FOOTER
\RequirePackage{fancyhdr,lastpage}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}% clear all header and footer fields

\lhead{\renewcommand{\baselinestretch}{0}%
        \makebox[0pt][l]{\raisebox{4.85mm}{\includegraphics[height=3.62cm]{\@mainlogo}}}%
       }

\newcommand*\PlainPageRef[1]{%
    \pageref*{#1}%
}

\cfoot{%
  \color{gray}
  \@separator\newline
  \hspace*{\tabcolsep}
  \begin{minipage}[c]{0.5\textwidth}
    TechWave - \@title/\@version
  \end{minipage}%
  \hfill
  \thepage\ of \pageref{LastPage}
  \hspace*{\tabcolsep}\newline
  \@separator
}

% PARTECIPANTS
\RequirePackage{xparse}
\newcommand{\@participantstable}{}
\NewDocumentCommand \participant { O{present} m }{
    \g@addto@macro \@participantstable {
        \multicolumn{2}{l}{#2}
          & \ifstrequal{#1}{present}    {$\bullet$}{}
          & \ifstrequal{#1}{absent}     {$\bullet$}{}\\
    }
}

% TASKLIST
\RequirePackage{tabularx,ltxtable}
\newcommand{\@tasktable}{}
\newcommand{\tasklist}{%
  \subsection*{Attività Assegnate}%
  \vspace{-\baselineskip}
  \begin{longtable}{rp{0.55\textwidth}p{0.2\textwidth}l}
    \multicolumn{4}{@{}c@{}}{\@separator}\\*
    \@LabelText{\#} & \@LabelText{Task} &
    \@LabelText{Responsabile} & \@LabelText{Data}\\*
    \multicolumn{4}{@{}c@{}}{\@separator}
    \@tasktable\\*
  \end{longtable}
}
\newcounter{crtask}
\newcommand{\task}[3]{%
    \g@addto@macro \@tasktable {%
      \\
      \refstepcounter{crtask}\thecrtask & #1 & #2 & #3 \\*
      \multicolumn{4}{@{}c@{}}{\@separator}%
    }%
}

% REDATTORI
% Initialize an empty list for editors
\newcommand{\editorlist}{}
\newcommand{\firsteditor}{true} % A flag to check if it's the first editor

% Define the \editor command to add a new editor to the list
\newcommand{\editor}[1]{%
    \ifthenelse{\equal{\firsteditor}{true}} % Check if it's the first editor
        {\edef\editorlist{#1} \renewcommand{\firsteditor}{false}} % Set editor without comma
        {\edef\editorlist{\editorlist, #1}} % Append with a comma
}

% VERIFICATORI
% Initialize an empty list for editors
\newcommand{\reviewerlist}{}
\newcommand{\firstreviewer}{true} % A flag to check if it's the first editor

% Define the \editor command to add a new editor to the list
\newcommand{\reviewer}[1]{%
    \ifthenelse{\equal{\firstreviewer}{true}} % Check if it's the first editor
        {\edef\reviewerlist{#1} \renewcommand{\firstreviewer}{false}} % Set editor without comma
        {\edef\reviewerlist{\reviewerlist, #1}} % Append with a comma
}

% CLASSIFICAZIONE
\def\@classification{}
\newcommand{\classification}[1]{\def\@classification{#1}}
\newcommand{\getclassification}{\@classification}

% DURATA
\def\@duration{}
\newcommand{\duration}[1]{\def\@duration{#1}}
\newcommand{\getduration}{\@duration}

% VERSIONE
\def\@version{}
\newcommand{\version}[1]{\def\@version{#1}}
\newcommand{\getversion}{\@version}

% FRONTMATTER
\usepackage[italian]{datetime2}
\RequirePackage{colortbl,tabularx,setspace,rotating,ltxtable}

\newcommand{\frontmatter}{%

    \newgeometry{left=3.5cm, right=3.5cm}%

    \begin{titlepage}
        \begin{center}

            \raisebox{1cm}{\includegraphics[height=3cm]{logo_unipd.png}}
            \hspace{0.5cm} % Space between images, adjust as needed
            \raisebox{0cm}{\includegraphics[height=5cm]{\@mainlogo}}%

            % \includegraphics[height=5cm]{\@mainlogo}
            % \includegraphics[height=3cm]{logo_unipd.png}
            \vspace{1cm}
            \small\textcolor{darkgray}{techwave.unipd@gmail.com} \\
            \vspace{0.5cm}
            \huge\textbf \@title
            \ifhidedate
                {}
            \else
                \Large \@date \\
            \fi
        \end{center}

        \vspace{2cm}

        \noindent Dettagli documento: \\

        \ifthenelse{\equal{\editorlist}{}}{}{\noindent\parbox{\textwidth}{\@labeltext{Redatto da:} \@LabelValue{\editorlist}}}
        \ifthenelse{\equal{\reviewerlist}{}}{}{\noindent\parbox{\textwidth}{\@labeltext{Revisionato da:} \@LabelValue{\reviewerlist}}}
        \ifx\@duration\empty
        \else
            \noindent\parbox{\textwidth}{\@labeltext{Durata riunione:} \@LabelValue{\@duration}}
        \fi
        \noindent\parbox{\textwidth}
        {\@labeltext{Classificazione:} \@LabelValue{\@classification}}
        \noindent\parbox{\textwidth}{\@labeltext{Versione:} \@LabelValue{\@version}}

    \end{titlepage}

    \restoregeometry
}

\newcommand{\frontmatterLessDetail}{%

    \newgeometry{left=3.5cm, right=3.5cm}%

    \begin{titlepage}
        \begin{center}

            \raisebox{1cm}{\includegraphics[height=3cm]{logo_unipd.png}}
            \hspace{0.5cm} % Space between images, adjust as needed
            \raisebox{0cm}{\includegraphics[height=5cm]{\@mainlogo}}%

            % \includegraphics[height=5cm]{\@mainlogo}
            % \includegraphics[height=3cm]{logo_unipd.png}
            \vspace{1cm}
            \small\textcolor{darkgray}{techwave.unipd@gmail.com} \\
            \vspace{0.5cm}
            \huge\textbf \@title
            \ifhidedate
                {}
            \else
                \Large \@date \\
            \fi
        \end{center}

        \vspace{2cm}

        \noindent Dettagli documento: \\

        \noindent\parbox{\textwidth}{\@labeltext{Redatto da:} \@LabelValue{\editorlist}}
        \noindent\parbox{\textwidth}{\@labeltext{Revisionato da:} \@LabelValue{\reviewerlist}}
        {\@labeltext{Classificazione:} \@LabelValue{\@classification}}
        \noindent\parbox{\textwidth}{\@labeltext{Versione:} \@LabelValue{\@version}}

    \end{titlepage}

    \restoregeometry
}

% PARTECIPANTS
\usepackage{colortbl}
\newcommand{\showPartecipants}{%

    \rowcolors{4}{}{twlightblue}%
    \begin{longtable}{p{0.4\textwidth}p{0.4\textwidth}ccc}
        \rowcolor{white}
        \parbox{\linewidth}{{\@LabelText{Redatto da}}\\\editorlist}
        & \parbox{\linewidth}{{\@LabelText{Revisionato da}}\\\reviewerlist}
        & \raisebox{-1.5cm}{\begin{sideways}%
            \parbox{2cm}{\centering\@LabelText{Presente}}%
            \end{sideways}}
        & \raisebox{-1.5cm}{\begin{sideways}%
            \parbox{2cm}{\centering\@LabelText{Assente}}%
            \end{sideways}}\\
        \rowcolor{white} \multicolumn{5}{@{}c@{}}{\@separator}\\
        \rowcolor{white} \@LabelText{Partecipanti} \vspace{0.5em}\\
        \endfirsthead
        \rowcolor{white} &
        & \raisebox{-1.5cm}{\begin{sideways}%
            \parbox{2cm}{\raggedright\@LabelText{Presente}}%
        \end{sideways}}
        & \raisebox{-1.5cm}{\begin{sideways}%
            \parbox{2cm}{\raggedright\@LabelText{Assente}}%
        \end{sideways}}\\
        \rowcolor{white} \multicolumn{5}{@{}c@{}}{\@separator}\\
        \rowcolor{white} \@LabelText{Partecipanti}\\
        \endhead
        \@participantstable
    \end{longtable}
    \rowcolors{1}{}{} % Back to normal

    \noindent\@separator

    \noindent

}

% SIGNATURE SPACE
\newcommand{\signature}[1]{%
    \vfill
    \begin{flushright}
        \textit{#1}
        \vspace{0.5cm} \\
        \noindent\rule{5cm}{0.4pt} % Adjust width and thickness of the line
    \end{flushright}
}

% Images

\newcommand{\floatimage}[5]{
  \begin{wrapfigure}{#1}{#2\textwidth}
    \centering
    \includegraphics[width=0.9\linewidth #5]{#3}
    \captionof{figure}{#4}
    \label{fig:wrapfig}
  \end{wrapfigure}
}

\newcommand{\floatleft}[4]{
  \floatimage{l}{#1}{#2}{#3}{#4}
}

\newcommand{\floatright}[4]{
  \floatimage{r}{#1}{#2}{#3}{#4}
}

\newcommand{\itemimage}[6]{
  % #1 item text
  % #2 l / r : left or right position of the image
  % #3 size of the image
  % #4 image
  % #5 caption
  % #6 text
  \vspace{-1.7em}
  \parbox[t]{\dimexpr\textwidth-\leftmargin}{%
    \item[#1]
    \begin{wrapfigure}{#2}{#3\textwidth}
        \vspace{-12pt}
        \includegraphics[width=\linewidth]{#4}
        \vspace{-29pt}\caption{#5}\vspace{-30pt}
    \end{wrapfigure}
    \setlength{\parskip}{0.8em}
    #6
  }
}

\renewcommand{\tableofcontents}{%
  \cleardoublepage
  \@starttoc{toc}
  \newpage
}

\newcommand{\fullpageLoF}{
    \clearpage  % Start a new page
    \addcontentsline{toc}{section}{List of Figures}  % Add to TOC (optional)
    \listoffigures  % Print the list of figures
    \newpage  % Ensure a page break after the LoF
}

\RequirePackage{tabularray}
\UseTblrLibrary{varwidth}

\SetTblrInner{
    vlines,
    hlines,
}
% Example of limiting the dimension of a column
\NewTblrEnviron{mytable}
\SetTblrInner[mytable]{
    vlines,
    hlines,
    rowsep=6pt,
    colsep=12pt,
}

\newcommand{\passthrough}[1]{#1}

\lstset{
    basicstyle=\ttfamily,
    numbers=left,
    numberstyle=\footnotesize,
    stepnumber=2,
    numbersep=5pt,
    backgroundcolor=\color{black!10},
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2,
    captionpos=b,
    breaklines=true,
    breakatwhitespace=true,
    breakautoindent=true,
    linewidth=\textwidth
}
