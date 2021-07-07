%%
%% This is file `easybook.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% easybook.dtx  (with options: `class')
%% Copyright (C) 2021 by Qu Yi <quee123@foxmail.com>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the CC-BY 4.0 License.
%% The latest version of this license is in
%%   https://creativecommons.org/licenses/by/4.0/legalcode
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\RequirePackage{l3keys2e}
\ProvidesExplClass{easybook}{2021/07/06}{1.26x}
  {Typeset Chinese theses or books}

\bool_set_false:N \l__eb_compile_draft_bool
\bool_set_false:N \l__eb_title_newline_bool
\bool_set_false:N \l__eb_font_noto_bool
\bool_set_true:N  \l__eb_page_twoside_bool
\bool_set_true:N  \l__eb_class_book_bool
\tl_new:N         \g__eb_config_tl
\clist_new:N      \g__eb_options_clist
\cs_new_protected:Npn \eb_put_ctexbook:n #1
  { \PassOptionsToClass{#1}{ctexbook} }

\keys_define:nn { easybook }
  {
    newline .code:n = \bool_set_true:N \l__eb_title_newline_bool,
    scheme .code:n  = \eb_put_ctexbook:n { scheme = #1 },
    enmode .meta:n  = { newline,scheme = plain },

    font .choices:nn        =
      { adobe,fandol,mac,windows,none }
      { \eb_put_ctexbook:n { fontset = \l_keys_choice_tl } },
    font/noto .code:n       =
      {
        \bool_set_true:N \l__eb_font_noto_bool
        \eb_put_ctexbook:n { fontset = none }
      },
    font/auto .code:n       = { },
    font/linux .code:n      = \eb_put_ctexbook:n { fontset = ubuntu },
    font .value_required:n  = true,
    font .initial:n         = auto,

    paper .choice:,
    paper .value_required:n = true,
    paper/unknown .code:n   = \PassOptionsToPackage{#1}{geometry},

    oneside .value_forbidden:n  = true,
    twoside .value_forbidden:n  = true,
    oneside .code:n             =
      {
        \bool_set_false:N \l__eb_page_twoside_bool
        \eb_put_ctexbook:n { oneside }
      },
    twoside .code:n             =
      {
        \bool_set_true:N \l__eb_page_twoside_bool
        \eb_put_ctexbook:n { twoside }
      },

    class .choice:,
    class .value_required:n = true,
    class/book .code:n      = { },
    class/article .code:n   =
      {
        \bool_set_false:N \l__eb_class_book_bool
        \keys_set:nn { easybook } { oneside }
      },
    book .meta:n            = { class = book },
    article .meta:n         = { class = article },

    config .tl_set:N      = \g__eb_config_tl,
    floatpage .bool_set:N = \l__eb_float_page_bool,
    floatpage .default:n  = true,
    unknown .code:n       =
      { \clist_gput_right:NV \g__eb_options_clist \CurrentOption }
  }

\ProcessKeysOptions{easybook}
\PassOptionsToPackage{no-math,quiet,CJKmath}{xeCJK}
\eb_put_ctexbook:n { \g__eb_options_clist }
\LoadClass[UTF8]{ctexbook}

\RequirePackage{easybase}
\ctex_at_end:n
  {
    \tl_if_empty:NF \g__eb_config_tl
      { \file_input:n { \g__eb_config_tl } }
  }

\sys_if_engine_xetex:TF
  {
    \cs_new_eq:NN \eb_set_family:nnn \xeCJK_set_family:nnn
    \cs_new_eq:NN \eb_switch_family:n \xeCJK_switch_family:n
  }
  {
    \cs_new_eq:NN \eb_set_family:nnn \ctex_ltj_set_family:nnn
    \cs_new_eq:NN \eb_switch_family:n \ctex_ltj_switch_family:n
  }
\cs_new_protected:Npn \eb_font_double_engine_set:n #1
  {
    \exp_args:Nc \RenewDocumentCommand {set#1font}{O{}mO{}}
      {\use:c { eb_set#1font:nn } {##2} {##1,##3}}
  }
\eb_clist_map_function:nN
  { main,sans,mono,CJKmain,CJKsans,CJKmono }
  \eb_font_double_engine_set:n

\cs_new_protected:Npn \eb_setmainfont:nn #1#2
  { \__fontspec_main_setmainfont:nn {#2} {#1} }
\cs_new_protected:Npn \eb_setsansfont:nn #1#2
  { \__fontspec_main_setsansfont:nn {#2} {#1} }
\cs_new_protected:Npn \eb_setmonofont:nn #1#2
  { \__fontspec_main_setmonofont:nn {#2} {#1} }
\cs_new_protected:Npn \eb_setCJKmainfont:nn #1#2
  { \eb_set_family:nnn { \CJKrmdefault } {#2} {#1} }
\cs_new_protected:Npn \eb_setCJKsansfont:nn #1#2
  { \eb_set_family:nnn { \CJKsfdefault } {#2} {#1} }
\cs_new_protected:Npn \eb_setCJKmonofont:nn #1#2
  { \eb_set_family:nnn { \CJKttdefault } {#2} {#1} }
\cs_new_protected:Npn \eb_set_zhfont_songti:nn #1#2
  { \eb_set_family:nnn { songti } {#2} {#1} }
\cs_new_protected:Npn \eb_set_zhfont_heiti:nn #1#2
  { \eb_set_family:nnn { heiti } {#2} {#1} }
\cs_new_protected:Npn \eb_set_zhfont_kaishu:nn #1#2
  { \eb_set_family:nnn { kaishu } {#2} {#1} }
\cs_new_protected:Npn \eb_set_zhfont_fangsong:nn #1#2
  { \eb_set_family:nnn { fangsong } {#2} {#1} }

\tl_const:Nn \eb_option_zhfont_tl
  { UprightFont = *,AutoFakeBold = 1.5,ItalicFont = * }
\cs_new_protected:Npx \eb_setCJKmainfont:n #1
  { \eb_setCJKmainfont:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_setCJKsansfont:n #1
  { \eb_setCJKsansfont:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_setCJKmonofont:n #1
  { \eb_setCJKmonofont:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_set_zhfont_songti:n #1
  { \eb_set_zhfont_songti:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_set_zhfont_heiti:n #1
  { \eb_set_zhfont_heiti:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_set_zhfont_kaishu:n #1
  { \eb_set_zhfont_kaishu:nn {#1} { \eb_option_zhfont_tl } }
\cs_new_protected:Npx \eb_set_zhfont_fangsong:n #1
  { \eb_set_zhfont_fangsong:nn {#1} { \eb_option_zhfont_tl } }

\bool_if:NT \l__eb_font_noto_bool
  {
    \eb_setmainfont:nn { NotoSerif }
      {
        Extension   = .ttf,
        UprightFont = *-Regular,
        BoldFont    = *-Bold,
        ItalicFont  = *-Italic
      }
    \eb_setsansfont:nn { NotoSans }
      {
        Extension   = .ttf,
        UprightFont = *-Regular,
        BoldFont    = *-Bold,
        ItalicFont  = *-Italic
      }
    \eb_setmonofont:nn { NotoSansMono }
      {
        Extension   = .ttf,
        UprightFont = *-Regular,
        BoldFont    = *-Bold
      }
    \eb_setCJKmainfont:nn { FZShuSong-Z01S }
      {
        UprightFont = *,
        BoldFont    = FZHei-B01S,
        ItalicFont  = FZKai-Z03S
      }
    \eb_setCJKsansfont:n { FZHei-B01S }
    \eb_setCJKmonofont:n { FZFangSong-Z02S }
    \eb_set_zhfont_songti:n { FZShuSong-Z01S }
    \eb_set_zhfont_heiti:n { FZHei-B01S }
    \eb_set_zhfont_kaishu:n { FZKai-Z03S }
    \eb_set_zhfont_fangsong:n { FZFangSong-Z02S }
    \cs_new_protected:Npn \songti { \eb_switch_family:n { songti } }
    \cs_new_protected:Npn \heiti { \eb_switch_family:n { heiti } }
    \cs_new_protected:Npn \kaishu { \eb_switch_family:n { kaishu } }
    \cs_new_protected:Npn \fangsong { \eb_switch_family:n { fangsong } }
  }

\ctex_set:n
  {
    secnumdepth     = 3,
    tocdepth        = \bool_if:NTF \l__eb_class_book_bool { 1 } { 2 },
    part            =
      {
        pagestyle   = empty,
        tocline     = \EBNumberLine{#1}#2,
        format      = \color{ctex@frame}\sffamily\Huge,
        aftername   =
          {
            \bool_if:NTF \l__eb_title_newline_bool
              { \par\nobreak }
              { \hspace{\ccwd} }
          }
      },
    chapter         =
      {
        % pagestyle   = fancy,
        format      =
          {
            \color{ctex@frame}\sffamily\LARGE
            \bool_if:NF \l__eb_title_newline_bool { \centering }
          },
        aftername   =
          {
            \bool_if:NTF \l__eb_title_newline_bool
              { \par\nobreak\vskip 1.5pc }
              { \hspace{\ccwd} }
          },
        beforeskip  = -1.5ex,
        afterskip   = 3ex,
        lotskip     = 0.8pc,
        lofskip     = 0.8pc
      },
    section         =
      {
        hang        = true,
        format      = \color{ctex@frame}\sffamily\Large,
        aftername   = \hspace{0.5\ccwd},
        beforeskip  = 1.5ex plus .2ex minus .1ex,
        afterskip   = 1.5ex plus .2ex minus .1ex
      },
    subsection      =
      {
        hang        = true,
        format      = \color{ctex@frame}\sffamily\large,
        aftername   = \hspace{0.5\ccwd},
        beforeskip  = 1.3ex plus .2ex minus .1ex,
        afterskip   = 1.3ex plus .2ex minus .1ex
      },
    subsubsection   =
      {
        hang        = true,
        format      = \color{ctex@frame}\sffamily,
        aftername   = \hspace{0.5\ccwd},
        beforeskip  = \parskip,
        afterskip   = \parskip
      }
  }

\bool_if:NF \l__eb_title_newline_bool
  {
    \ctex_set:n
      {
        part/hang     = true,
        chapter/hang  = true
      }
  }
\endinput
%%
%% End of file `easybook.cls'.
