\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{flypcv}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[10pt]{article}

\makeatletter

% default font
\renewcommand{\familydefault}{\sfdefault}
% ------------------------------------------------------------------------------

% hyperlinks
% ------------------------------------------------------------------------------
\RequirePackage[colorlinks, urlcolor=blue, linkcolor=black]{hyperref}
% ------------------------------------------------------------------------------

% conditionals
% ------------------------------------------------------------------------------
\RequirePackage{xifthen}

% thisifthat - expand #1 if #2 is not empty
\newcommand{\thisifthat}[2]{%%
  \ifthenelse{\isempty{#2}}{}{#1}%%
}
% ------------------------------------------------------------------------------

% geometry, footer
% ------------------------------------------------------------------------------
% remove parindent, parskip
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

% set vertical lengths (space above said object)
\newlength{\secvspace}
\newlength{\headvspace}
\setlength{\secvspace}{0pt}
\setlength{\headvspace}{3.5pt}

% set margin, footer geometry
\RequirePackage{geometry}

\setlength{\footskip}{0.2in}
\geometry{margin=0.7in}

% configure footer
\RequirePackage{fancyhdr, lastpage}

\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancyhf{}
\fancyfoot[R]{\scriptsize \thepage\ \textit{of}\ \pageref{LastPage}}
\fancyfoot[L]{\itshape\scriptsize curriculum vitae}
% ------------------------------------------------------------------------------

% title
% ------------------------------------------------------------------------------
% supported header parameters
%   \author, \title, \location, \email, \phone
\author{Name}
\title{title}
\newcommand{\@location}{New York City, NY, USA}
\newcommand{\@email}{email@domain.com}
\newcommand{\@phone}{123/456-7890}
\newcommand{\location}[1]{\renewcommand{\@location}{#1}}
\newcommand{\contact}[1]{\renewcommand{\@contact}{#1}}
\newcommand{\email}[1]{\renewcommand{\@email}{#1}}
\newcommand{\phone}[1]{\renewcommand{\@phone}{#1}}

% title geometry
\newlength{\titleheight}
\setlength{\titleheight}{0.5in}

% use \maketitle to place the title within document
\renewcommand{\maketitle}{
  \begin{minipage}[t][\titleheight][c]{0.5\textwidth}
    \flushleft{{\Huge\bfseries
      \@author
    }}
    \vspace{-5pt}\flushleft{{\itshape
      \@title
    }}
  \end{minipage}
  \begin{minipage}[t][\titleheight][c]{0.5\textwidth}
    \flushright{
      \@location\\
      \href{mailto:\@email}{\@email} | \@phone
    }
  \end{minipage}
}
% ------------------------------------------------------------------------------

% section definition
% ------------------------------------------------------------------------------
\RequirePackage{titlesec}

% section geometry
\newlength{\sectionsep}
\setlength{\sectionsep}{8pt}

% format section
\titleformat{\section}
  {\vspace{\secvspace}\Large\bfseries\uppercase}
  {}
  {\sectionsep}
  {}[\titlerule]
% ------------------------------------------------------------------------------


% ------------------------------------------------------------------------------
% cv features
% ------------------------------------------------------------------------------

% the blurb
% ------------------------------------------------------------------------------
% blurb - a simple, ital par for brief descriptions below main items or as
% standalones

\newcommand{\blurb}[1]{\par{\itshape#1}}

% ------------------------------------------------------------------------------

% cvitem
% ------------------------------------------------------------------------------
% generic line item with item, delim, info, and metadata.

% default metaformat (given default since that column looks weird if not uniform)
\newcommand{\@defaultmetaformat}{\rmfamily}
\newcommand{\defaultmetaformat}[1]{\renewcommand{\@defaultmetaformat}{#1}}

% \cvitem{item}{info}{meta}{delim}{infopunct}
\newcommand{\cvitem}[5]{%%
  \par%%
  #1%%
  \thisifthat{#4}{#2}#2\thisifthat{#5}{#2}%%
  \thisifthat{\hfill}{#3}%%
  {\@defaultmetaformat#3}%%
}

% ------------------------------------------------------------------------------

% custom cvitem
% ------------------------------------------------------------------------------
% format a custom cvitem

% \newcvitem{name}{itemformat}{infoformat}{delim}{infopunct}{vspace}
\newcommand{\newcvitem}[6]{%%
  \expandafter\newcommand\csname#1\endcsname[3]{%%
    \vspace{#6}%%
    \cvitem{{#2##1}}{{#3##2}}{##3}%%
      {\thisifthat{#4}{##2}}{\thisifthat{#5}{##2}}%%
  }
}

% ------------------------------------------------------------------------------

% define cvitems
% ------------------------------------------------------------------------------

% headcvitem - for items that act as headers / major items
\newcvitem{headcvitem}{\bfseries}{}{ | }{}{\headvspace}

% detailcvitem - for detail items under headcvitems
\newcvitem{detailcvitem}{}{\itshape}{:\ }{}{0pt}

% collectcvitem - for a brief one-line list of items with emphasised header
\newcvitem{collectcvitem}{\bfseries}{}{\ }{}{\headvspace}

% blurbcvitem - cvitem with blurb in-line (not actually a true cvitem)
\newcommand{\blurbcvitem}[2]{%%
  \vspace{\headvspace}\par%%
  {\bfseries#1}\ {\small\itshape#2}%%
}

% referencecvitem
\newcvitem{referencecvitem}{\rmfamily}{\itshape}{,\ }{}{\headvspace}

% ------------------------------------------------------------------------------

\makeatother
