\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lsbook}[2018/04/06 v1.0.6, by ZHANG Chennan chennanzhang@gmail.com with contributions from the Chinese LaTeX QQ Discussion Group 91940767]
\def\LS@classtoload{book}
\newif\ifLS@green
\newif\ifLS@orange
\newif\ifLS@violet
\newif\ifLS@customfont
\DeclareOption{green}{\LS@greentrue\LS@orangefalse\LS@violetfalse}
\DeclareOption{orange}{\LS@greenfalse\LS@orangetrue\LS@violetfalse}
\DeclareOption{violet}{\LS@greenfalse\LS@orangefalse\LS@violettrue}
\DeclareOption{customfont}{\LS@customfonttrue}
\DeclareOption{systemfont}{\LS@customfontfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\LS@classtoload}}
\ExecuteOptions{green,systemfont}
\ProcessOptions
\LoadClass{\LS@classtoload}
%--------------------------------------------------------------------------------
% 要求必须使用 xelatex 进行编译
%--------------------------------------------------------------------------------
\RequirePackage{ifxetex}
\RequireXeTeX
%--------------------------------------------------------------------------------
% 中文格式
%--------------------------------------------------------------------------------
\RequirePackage[heading=true]{ctex}
%--------------------------------------------------------------------------------
% xeCJK设置中文样式
%--------------------------------------------------------------------------------
\xeCJKsetup{CJKecglue={\hskip 0.10em plus 0.05em minus 0.05em},CheckSingle=true}
%--------------------------------------------------------------------------------
% tikz 及 tcolorbox 应用
%--------------------------------------------------------------------------------
\RequirePackage{tcolorbox}
\tcbuselibrary{skins,breakable}
\usetikzlibrary{patterns}
%--------------------------------------------------------------------------------
% ean13isbn 宏包支持，输出isbn条形码。
%--------------------------------------------------------------------------------
\RequirePackage{ean13isbn}
\newcommand{\drawbarcode}[1]{\EANisbn[SC5a,ISBN=#1]}
%--------------------------------------------------------------------------------
% 字体设置 由选项customfont与systemfont决定
% 感谢林莲枝前辈的帮助
%--------------------------------------------------------------------------------
\ifLS@customfont
\typeout{你已启用 customfont 选项，请确保操作系统已安装需要的字库。}
%--------------------------------------------------------------------------------
% CJK字体设置 需要思源宋体、思源黑体、文泉驿微米黑、造字工坊的刻宋、郎宋、黄金时代
%--------------------------------------------------------------------------------
\setCJKmainfont[BoldFont={Noto Serif CJK SC Bold},ItalicFont={AR PL UKai HK}]{Noto Serif CJK SC ExtraLight}
\setCJKsansfont[BoldFont={Noto Sans S Chinese Medium}]{Noto Sans S Chinese DemiLight}
\setCJKmonofont{WenQuanYi Micro Hei Mono Light}
\setCJKfamilyfont{zhkesong}{MF KeSong (Noncommercial)}
\newcommand{\KeSong}{\CJKfamily{zhkesong}}
\setCJKfamilyfont{zhhjsd}{MF TheGoldenEra (Noncommercial)}
\newcommand{\hjsd}{\CJKfamily{zhhjsd}}
\setCJKfamilyfont{zhlangsong}{MF LangSong (Noncommercial)}
\newcommand{\langsong}{\CJKfamily{zhlangsong}}
%--------------------------------------------------------------------------------
% 西文特殊字体设置 默认使用刻宋、郎宋、黄金时代的英文字体
%--------------------------------------------------------------------------------
%\newfontfamily\SourceCodePro[Mapping=tex-text]{Source Code Pro}
\newfontfamily\KeSongf[Mapping=tex-text]{MF KeSong (Noncommercial)}
\newfontfamily\hjsdf[Mapping=tex-text]{MF TheGoldenEra (Noncommercial)}
\newfontfamily\langsongf[Mapping=tex-text]{MF LangSong (Noncommercial)}
\else
% \ClassWarning{lsbook}{你已启用 systemfont 选项，只能用系统自带的宋、黑、楷、仿。}
\typeout{你已默认/启用 systemfont 选项，只能用系统自带的宋、黑、楷、仿。}
\newcommand{\KeSong}{\songti}
\newcommand{\hjsd}{\songti}
\newcommand{\langsong}{\songti}
\newcommand{\KeSongf}{\rmfamily}
\newcommand{\hjsdf}{\rmfamily}
\newcommand{\langsongf}{\rmfamily}
\fi
%--------------------------------------------------------------------------------
% 色彩定义
%--------------------------------------------------------------------------------
\ifLS@green
\definecolor{cvprimary}{HTML}{92D14F}
\definecolor{cvsecondary}{HTML}{D8E4BE}
\definecolor{cvtext}{HTML}{92909B}
\else
\fi
\ifLS@orange
\definecolor{cvprimary}{RGB}{230,140,20}
\definecolor{cvsecondary}{RGB}{248,216,174}
\definecolor{cvtext}{RGB}{100,100,100}
\else
\fi
\ifLS@violet
\definecolor{cvprimary}{RGB}{178,10,142}
\definecolor{cvsecondary}{RGB}{209,181,217}
\definecolor{cvtext}{RGB}{100,100,100}
\else
\fi
%--------------------------------------------------------------------------------
% 章节格式设置
%--------------------------------------------------------------------------------
\ctexset {
    chapter      = {
                      beforeskip   = 0pt,
                      fixskip      = true,
                      format       = \huge\bfseries,
					  name         = {,},
                      nameformat   = \mbox{}\hfill\chapternamebox,
                      number       = \arabic{chapter},
					  numberformat = \fontencoding{OT1}\fontfamily{cmss}\fontsize{60pt}{72pt}\selectfont,
                      aftername    = \par\medskip,
                      titleformat  = \chaptertitlebox,
                      aftertitle   = \par\smallskip
}}
\newtcbox{mynamebox}{on line,colback=cvsecondary,arc=0pt,boxrule=0pt,toprule=2pt,rightrule=5mm,
colframe=cvprimary,coltext=cvtext}
\newcommand\chapternamebox[1]{%
\mynamebox{#1}}
\newtcolorbox{mytitlebox}{colback=cvsecondary,arc=0pt,coltext=cvtext,
colframe=cvprimary,boxrule=0pt,bottomrule=2pt,toprule=0pt,leftrule=5mm}
\newcommand\chaptertitlebox[1]{%
\begin{mytitlebox}#1\end{mytitlebox}}
%--------------------------------------------------------------------------------
% 书籍要素的定义
%--------------------------------------------------------------------------------
%---- 丛书系列名称 ------
\newcommand{\BookSeries}[1]{\def\LS@BookSeries{#1}}
%---- 书名与作者由原\title定义 ------
\def\@title{一本名字起得太TM的长了的书}
\def\@author{张三}
%---- 副标题自己定义，可设可不设 ------
\newcommand{\subtitle}[1]{\def\LS@subtitle{#1}}
%---- 书籍简介 可设可不设------
\newcommand{\BookIntroduction}[1]{\def\LS@BookIntroduction{#1}}
%---- 书籍版本 ------
\newcommand{\edition}[1]{\def\LS@edition{#1}}
%---- 出版社 ------
\newcommand{\Publisher}[1]{\def\LS@Publisher{#1}}
\def\LS@Publisher{\LaTeX Studio 出版社}
%---- 献词 ------
\newcommand\DedicatedTo[1]{\def\LS@DedicatedTo{#1}}
%---- 责任编辑 ------
\newcommand{\Editor}[1]{\def\LS@editor{#1}}
\def\LS@editor{责编}
%---- 封面设计 ------
\newcommand{\Designer}[1]{\def\LS@designer{#1}}
\def\LS@designer{张晨南}
%---- 定价 ------
\newcommand{\Price}[1]{\def\LS@price{#1}}
\def\LS@price{358.00} %谨以此怀念我大学的宿舍号码
\newcommand{\isbn}[1]{\def\LS@isbn{#1}}
\def\LS@isbn{978-7-302-11622-6}
%--------------------------------------------------------------------------------
%  罗马数字定义
%     \ROMAN{<数字>} 大写罗马数字
%--------------------------------------------------------------------------------
\newcommand{\ROMAN}[1]{\expandafter\@slowromancap\romannumeral #1@}
%--------------------------------------------------------------------------------
% 封面设计 \maketitle
%--------------------------------------------------------------------------------
\def\maketitle{%
\begin{titlepage}
\thispagestyle{empty}
\begin{tikzpicture}[remember picture,overlay]
    %----- 竖条幅
	\fill[cvprimary] (current page.north west) rectangle ([xshift=5cm]current page.south west);
    %----- 横条幅
    \fill[cvsecondary] ([yshift=-5cm]current page.north west) rectangle ([yshift=-10cm]current page.north east);
    %----- 丛书名称
	\@ifundefined{TJ@BookSeries}{}{%
	\node[above right] at ([xshift=5.5cm,yshift=-4.5cm]current page.north west){\LARGE\hjsd\hjsdf\LS@BookSeries};}
	%----- 书名与副标题
    \node[cvtext,right,text width=17cm,inner sep=0.3cm] at ([xshift=1cm,yshift=-7cm]current page.north west) {\fontsize{40pt}{48pt}\selectfont\langsong\langsongf\@title};
	\@ifundefined{TJ@subtitle}{\relax}{\node[cvtext,above left] at ([xshift=-1cm,yshift=-9.5cm]current page.north east) {\huge\sffamily ------~\LS@subtitle};}
    %----- 右下角的版本号
	\@ifundefined{TJ@edition}{}{%
    \fill[cvprimary]([xshift=-2.5cm]current page.south east)-- ++(-5,0)-- ++(7.5,7.5)-- ++(0,-5)--cycle;
	\node [white] at([xshift=-2.8cm,yshift=2.8cm]current page.south east)[rotate=45]{\bfseries\sffamily\LARGE 第\zhnumber{\LS@edition}版};
    \node [white] at([xshift=-2.2cm,yshift=2.2cm]current page.south east)[rotate=45]{\bfseries\LARGE Edition \ROMAN{\LS@edition}};
	\draw[white,thick] ([xshift=-4cm,yshift=1cm]current page.south east)--([xshift=-1cm,yshift=4cm]current page.south east);
	\path[fill=blue!75!white,draw=blue,double=white!85!blue,
          preaction={opacity=0.6,fill=blue!75!white},
          line width=0.1mm,double distance=0.2mm,
          pattern=fivepointed stars,pattern color=white!75!blue]
        ([xshift=-3cm]current page.south east)-- ++(-0.5,0) -- ++(3.5,3.5) -- ++(0,-0.5) -- cycle;
    \path[fill=blue!75!white,draw=blue,double=white!85!blue,
          preaction={opacity=0.6,fill=blue!75!white},
          line width=0.1mm,double distance=0.2mm,
          pattern=fivepointed stars,pattern color=white!75!blue]
        ([xshift=-6.5cm]current page.south east)-- ++(-0.5,0) -- ++(7,7) -- ++(0,-0.5) -- cycle;}
	\node[right] at ([xshift=5.5cm,yshift=2.5cm]current page.south west){\LARGE\KeSong\KeSongf\LS@Publisher};
    %----- 简介与作者
	\@ifundefined{TJ@BookIntroduction}%
	{\node[inner sep=0pt,below right,white] (image) at ([xshift=5cm,yshift=-12cm]current page.north west){%
	\rule{8cm}{3cm}};
	\draw[white,line width=1mm](image.east)-- ++(5,0) node[above left,text=black]{\LARGE\itshape\makebox[3em][s]{\LARGE\itshape\@author}\hspace{0.5em}著};}%
    {\node[inner sep=0pt,below right] (image) at ([xshift=5cm,yshift=-12cm]current page.north west){%
	\begin{tcolorbox}[sharp corners=west,text width =8cm,colframe=cvtext,leftrule=0pt,arc =10pt,toprule=3mm,bottomrule=3mm]
	\large\LS@BookIntroduction
	\end{tcolorbox}};
	\draw[cvtext,line width=1mm](image.east)-- ++(5,0) node[above left,text=black]{\LARGE\itshape\makebox[3em][s]{\LARGE\itshape\@author}\hspace{0.5em}著};}
\end{tikzpicture}
\end{titlepage}
\if@twoside
\newpage\thispagestyle{empty}\mbox{}
\else\fi
%----- 避免多次使用，执行一次后就更改定义。
\global\let\maketitle\relax
}
%--------------------------------------------------------------------------------
% 封底设计 \makebackcover
%--------------------------------------------------------------------------------
\def\makebackcover{%
\clearpage
%----- 若为双面排版，确保封底在偶数页。
\if@twoside
    \ifodd\c@page
	\fi
\fi
\thispagestyle{empty}
%------ 封底图形
\begin{tikzpicture}[remember picture,overlay]
%------ 竖条纹
\fill[cvprimary] (current page.north east) rectangle ([xshift=-6cm]current page.south east);
\fill[cvprimary] ([xshift=-6.2cm]current page.north east) rectangle ([xshift=-6.35cm]current page.south east);
\fill[cvprimary] ([xshift=-6.45cm]current page.north east) rectangle ([xshift=-6.55cm]current page.south east);
\fill[cvprimary] ([xshift=-6.65cm]current page.north east) rectangle ([xshift=-6.7cm]current page.south east);
%------ 横条纹
\fill[cvsecondary] ([yshift=-5cm]current page.north west) rectangle ([yshift=-10cm]current page.north east);
%------ 编辑与封面设计
\node[right] at ([xshift=1cm,yshift=-4cm]current page.north west) {\large\itshape 封面设计：\makebox[3em][s]{\large\itshape\LS@designer}};
\node[right] at ([xshift=1cm,yshift=-4.5cm]current page.north west) {\large\itshape 责任编辑：\makebox[3em][s]{\large\itshape\LS@editor}};
%------ ISBN条码及定价
\node at ([xshift=-3.3cm,yshift=5cm]current page.south east){\expandafter\drawbarcode\expandafter{\LS@isbn}};%978-80-7340-097-2
\node at ([xshift=-3.3cm,yshift=2.8cm]current page.south east){\sffamily\Large 定价：\LS@price 元};
\end{tikzpicture}
%----- 避免多次使用，执行一次后就更改定义。
\global\let\makebackcover\relax
}
%--------------------------------------------------------------------------------
% 扉页设计 \makeflypage
%--------------------------------------------------------------------------------
\RequirePackage{printlen}
\uselengthunit{mm}
\def\makeflypage{%
\begin{titlepage}
\thispagestyle{empty}
\vspace*{\stretch{1}}
\begin{center}
{\huge\bfseries\@title}\\
\vspace{2cm}
{\itshape\LARGE\makebox[3em][s]{\itshape\LARGE\@author}\hspace{0.5em}著}
\end{center}
\vspace{\stretch{1}}
\newpage\thispagestyle{empty}
\@ifundefined{TJ@DedicatedTo}{\mbox{}}{\Large\textbf{献给}：\LS@DedicatedTo}
\vfill
\begin{center}
{\large\sffamily \@title}\\
{\itshape\normalsize \makebox[3em][s]{\itshape\@author}\hspace{0.5em}著}\\[5pt]
\makebox[2cm][s]{* * *}\\[10pt]
{\Large\KeSong\KeSongf\LS@Publisher}\\[-2pt]
{\normalsize\texttt{http://www.latexstudio.net}}\\[-5pt]
{\footnotesize 开本：\rndprintlength{\paperwidth}$\times$\rndprintlength{\paperheight} \hspace{0.5em} 字数：有功夫您帮我数一下}\\[0pt]
\@ifundefined{TJ@edition}{}{{\small \the\year 年\the\month 月 第 \LS@edition\ 版 第 1 次印刷}\\[-5pt]}
{\small 印数：001--100 册 \hspace{0.5em} 定价：\LS@price 元}\\[5pt]
\hrule
\vskip5pt
{\small 本书如有缺页、倒页、脱页，请自行处理一下}
\end{center}
\end{titlepage}
}
%--------------------------------------------------------------------------------
%  后面代码除了\endinput 都可以不要。我懒得删掉了。
%--------------------------------------------------------------------------------
% 浮动图表规则放松，如果不明白是什么意思，不要改动这里的数值。
%--------------------------------------------------------------------------------
\setcounter{topnumber}{4}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{10}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.70}
\renewcommand{\floatpagefraction}{0.66}
%--------------------------------------------------------------------------------
% 重定义cleardobulepage，双面打印将空白页页眉页脚全去掉。
%--------------------------------------------------------------------------------
\renewcommand{\cleardoublepage}{
    \clearpage
    \if@twoside
	    \ifodd
          \c@page
        \else
			\if@openright
				\thispagestyle{empty}
				\mbox{}
				\newpage
				\if@twocolumn
					\mbox{}\newpage
				\fi
			\fi
		\fi
	\fi
}
%--------------------------------------------------------------------------------


%--------------------------------------------------------------------------------
% 几个可有可无的 tcolorbox 设置
%--------------------------------------------------------------------------------
\RequirePackage{amssymb,fontawesome}
\definecolor{MyLightGray}{HTML}{EEEEEE}
\definecolor{MyDarkGray}{HTML}{333333}
\definecolor{DarkText}{HTML}{111111}
\definecolor{AppleRed}{RGB}{255,95,86}
\definecolor{AppleYellow}{RGB}{255,189,46}
\definecolor{AppleGreen}{RGB}{39,201,63}

\tcbset{skin=enhanced,
  apple/.style={%
    center title,
    toptitle=1ex,
    overlay = {\node[inner sep=0pt,anchor=north west,yshift=-9pt,xshift=11pt] at (frame.north west)
      {\textcolor{AppleRed}{\faCircle} \textcolor{AppleYellow}{\faCircle} \textcolor{AppleGreen}{\faCircle}};},
    fonttitle=\sffamily\bfseries,
    fontupper=\small\sffamily,
    fontlower=\small\sffamily
  },
  appledark/.style={apple,
    colback=MyDarkGray,colbacktitle=MyDarkGray,colframe=MyDarkGray,coltitle=MyLightGray,coltext=MyLightGray
  },
  applelight/.style={apple,
    colback=MyLightGray,colbacktitle=MyLightGray,colframe=MyLightGray,coltitle=DarkText
  },
  %
  win10/.style={%
    toptitle=1ex,
    sharp corners,
    fonttitle=\sffamily\bfseries,
    fontupper=\small\sffamily,
    fontlower=\small\sffamily,
  },
  win10light/.style={win10,
    colback=MyLightGray,colbacktitle=MyLightGray,colframe=MyLightGray,coltitle=DarkText,
    overlay = {\node[inner sep=0pt,anchor=north east,yshift=-9pt,xshift=-11pt,text=DarkText] at (frame.north east)
      {\rule{0.8em}{0.6pt}\quad$\square$\quad{\Large$\times$}};}
  },
  win10dark/.style={win10,
    colback=MyDarkGray,colbacktitle=MyDarkGray,colframe=MyDarkGray,coltitle=MyLightGray,coltext=MyLightGray,
    overlay = {\node[inner sep=0pt,anchor=north east,yshift=-9pt,xshift=-11pt,text=MyLightGray] at (frame.north east)
      {\rule{0.8em}{0.6pt}\quad$\square$\quad{\Large$\times$}};}
  }
}

\endinput
启用
