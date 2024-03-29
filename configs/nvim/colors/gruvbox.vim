
" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name="gruvbox"

if !(has("termguicolors") && &termguicolors) && !has("gui_running") && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists("g:gruvbox_bold")
  let g:gruvbox_bold=1
endif
if !exists("g:gruvbox_italic")
  if has("gui_running") || $TERM_ITALICS == "true"
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists("g:gruvbox_undercurl")
  let g:gruvbox_undercurl=1
endif
if !exists("g:gruvbox_underline")
  let g:gruvbox_underline=1
endif
if !exists("g:gruvbox_inverse")
  let g:gruvbox_inverse=1
endif

if !exists("g:gruvbox_guisp_fallback") || index(["fg", "bg"], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback="NONE"
endif

if !exists("g:gruvbox_improved_strings")
  let g:gruvbox_improved_strings=0
endif

if !exists("g:gruvbox_improved_warnings")
  let g:gruvbox_improved_warnings=0
endif

if !exists("g:gruvbox_termcolors")
  let g:gruvbox_termcolors=256
endif

if !exists("g:gruvbox_invert_indent_guides")
  let g:gruvbox_invert_indent_guides=0
endif

if exists("g:gruvbox_contrast")
  echo "g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead"
endif

if !exists("g:gruvbox_contrast_dark")
  let g:gruvbox_contrast_dark="medium"
endif

if !exists("g:gruvbox_contrast_light")
  let g:gruvbox_contrast_light="medium"
endif

let s:is_dark=(&background == "dark")

" }}}
" Palette Utility Functions: {{{

function! s:Color(name, default, ...)
  " color already set, validate option
  if has_key(s:gb, a:name)
    let l:color = s:gb[a:name]

    if type(l:color) == type("")
      " gui color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][0] = l:color
      return 1
    elseif type(l:color) == type(0)
      " terminal color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][1] = l:color
      return 1
    elseif type(l:color) == type([])
          \ && len(l:color) == 2
          \ && type(l:color[0]) == type("")
          \ && type(l:color[1]) == type(0)
      " gui and terminal color
      return 1
    else
      " invalid value
      echo a:name "is invalid, usage: let g:gruvbox_colors.color = (["#ffffff", 255]|"#ffffff"|255)"
      return 0
    endif

  endif

  " set default option
  let s:gb[a:name] = a:default
  return 1
endfunction

" }}}
" Palette: {{{

" get the global gruvbox palette options, if any
let g:gruvbox_colors = get(g:, "gruvbox_colors", {})
" initialize the script palette
let s:gb = copy(g:gruvbox_colors)
let g:current_gruvbox_colors = s:gb

" set palette default colors
call s:Color("dark0",       ["#171615", 235]) 
call s:Color("dark1",       ["#323030", 237])
call s:Color("dark2",       ["#504945", 239])     " 80-73-69
call s:Color("dark3",       ["#665c54", 241])     " 102-92-84
call s:Color("dark4",       ["#7c6f64", 243])     " 124-111-100
call s:Color("dark4_256",   ["#7c6f64", 243])     " 124-111-100
call s:Color("dark5",       ["#222120", 123])
call s:Color("dark6",       ["#131211", 123])

call s:Color("gray_245",    ["#928374", 245])     " 146-131-116
call s:Color("gray_244",    ["#928374", 244])     " 146-131-116

call s:Color("light0_hard", ["#f9f5d7", 230])     " 249-245-215
call s:Color("light0",      ["#fbf1c7", 229])     " 253-244-193
call s:Color("light0_soft", ["#f2e5bc", 228])     " 242-229-188
call s:Color("light1",      ["#ebdbb2", 223])     " 235-219-178
call s:Color("light2",      ["#d5c4a1", 250])     " 213-196-161
call s:Color("light3",      ["#bdae93", 248])     " 189-174-147
call s:Color("light4",      ["#a89984", 246])     " 168-153-132
call s:Color("light4_256",  ["#a89984", 246])     " 168-153-132

call s:Color("bright_red",     ["#fb4934", 167])     " 251-73-52
call s:Color("bright_green",   ["#b8bb26", 142])     " 184-187-38
call s:Color("bright_yellow",  ["#fabd2f", 214])     " 250-189-47
call s:Color("bright_blue",    ["#83a598", 109])     " 131-165-152
call s:Color("bright_purple",  ["#d3869b", 175])     " 211-134-155
call s:Color("bright_aqua",    ["#8ec07c", 108])     " 142-192-124
call s:Color("bright_orange",  ["#fe8019", 208])     " 254-128-25

call s:Color("neutral_red",    ["#cc241d", 124])     " 204-36-29
call s:Color("neutral_green",  ["#98971a", 106])     " 152-151-26
call s:Color("neutral_yellow", ["#d79921", 172])     " 215-153-33
call s:Color("neutral_blue",   ["#458588", 66])      " 69-133-136
call s:Color("neutral_purple", ["#b16286", 132])     " 177-98-134
call s:Color("neutral_aqua",   ["#689d6a", 72])      " 104-157-106
call s:Color("neutral_orange", ["#d65d0e", 166])     " 214-93-14

call s:Color("faded_red",      ["#9d0006", 88])      " 157-0-6
call s:Color("faded_green",    ["#79740e", 100])     " 121-116-14
call s:Color("faded_yellow",   ["#b57614", 136])     " 181-118-20
call s:Color("faded_blue",     ["#076678", 24])      " 7-102-120
call s:Color("faded_purple",   ["#8f3f71", 96])      " 143-63-113
call s:Color("faded_aqua",     ["#427b58", 65])      " 66-123-88
call s:Color("faded_orange",   ["#af3a03", 130])     " 175-58-3

call s:Color("comment_green",  ["#4d6f2a", 123])

call s:Color("none", ["NONE","NONE"])
call s:Color("NONE", ["NONE","NONE"])
call s:Color("None", ["NONE","NONE"])

" }}}
" Setup Emphasis: {{{

let s:bold = "bold,"
if g:gruvbox_bold == 0
  let s:bold = ""
endif

let s:italic = "italic,"
if g:gruvbox_italic == 0
  let s:italic = ""
endif

let s:underline = "underline,"
if g:gruvbox_underline == 0
  let s:underline = ""
endif

let s:undercurl = "undercurl,"
if g:gruvbox_undercurl == 0
  let s:undercurl = ""
endif

let s:inverse = "inverse,"
if g:gruvbox_inverse == 0
  let s:inverse = ""
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ["bg", "bg"]
let s:vim_fg = ["fg", "fg"]
let s:none = ["NONE", "NONE"]

let s:bg0  = s:gb.dark0
let s:bg1  = s:gb.dark1
let s:bg2  = s:gb.dark2
let s:bg3  = s:gb.dark3
let s:bg4  = s:gb.dark4
let s:bg5  = s:gb.dark5
let s:bg6  = s:gb.dark6

let s:gray = s:gb.gray_245

let s:fg0 = s:gb.light0
let s:fg1 = s:gb.light1
let s:fg2 = s:gb.light2
let s:fg3 = s:gb.light3
let s:fg4 = s:gb.light4

let s:fg4_256 = s:gb.light4_256

let s:red    = s:gb.bright_red
let s:green  = s:gb.bright_green
let s:yellow = s:gb.bright_yellow
let s:blue   = s:gb.bright_blue
let s:purple = s:gb.bright_purple
let s:aqua   = s:gb.bright_aqua
let s:orange = s:gb.bright_orange

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
call s:Color("bg0", s:bg0)
call s:Color("bg1", s:bg1)
call s:Color("bg2", s:bg2)
call s:Color("bg3", s:bg3)
call s:Color("bg4", s:bg4)

call s:Color("gray", s:gray)

call s:Color("fg0", s:fg0)
call s:Color("fg1", s:fg1)
call s:Color("fg2", s:fg2)
call s:Color("fg3", s:fg3)
call s:Color("fg4", s:fg4)

call s:Color("fg4_256", s:fg4_256)

call s:Color("red",    s:red)
call s:Color("green",  s:green)
call s:Color("yellow", s:yellow)
call s:Color("blue",   s:blue)
call s:Color("purple", s:purple)
call s:Color("aqua",   s:aqua)
call s:Color("orange", s:orange)

" }}}
" Setup Terminal Colors For Neovim: {{{

if has("nvim")
  let g:terminal_color_0 = s:gb.bg0[0]
  let g:terminal_color_8 = s:gb.gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:gb.red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:gb.green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:gb.yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gb.blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:gb.purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:gb.aqua[0]

  let g:terminal_color_7 = s:gb.fg4[0]
  let g:terminal_color_15 = s:gb.fg1[0]
endif

" }}}

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:gb.orange
if exists("g:gruvbox_hls_cursor")
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:hls_highlight = s:gb.yellow
if exists("g:gruvbox_hls_highlight")
  let s:hls_highlight = get(s:gb, g:gruvbox_hls_highlight)
endif

let s:number_column = s:none
if exists("g:gruvbox_number_column")
  let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:gb.dark5
if exists("g:gruvbox_sign_column")
  let s:sign_column = get(s:gb, g:gruvbox_sign_column)
endif

let s:color_column = s:gb.bg1
if exists("g:gruvbox_color_column")
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:gb.bg0
if exists("g:gruvbox_vert_split")
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ""
if exists("g:gruvbox_invert_signs")
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists("g:gruvbox_invert_selection")
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ""
  endif
endif

let s:invert_tabline = ""
if exists("g:gruvbox_invert_tabline")
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:tabline_sel = s:gb.green
if exists("g:gruvbox_tabline_sel")
  let s:tabline_sel = get(s:gb, g:gruvbox_tabline_sel)
endif

let s:italicize_comments = s:italic
if exists("g:gruvbox_italicize_comments")
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ""
  endif
endif

let s:italicize_strings = ""
if exists("g:gruvbox_italicize_strings")
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

let s:italicize_operators = ""
if exists("g:gruvbox_italicize_operators")
  if g:gruvbox_italicize_operators == 1
    let s:italicize_operators = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = "NONE,"
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != "NONE"
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == "bg"
      let emstr .= "inverse,"
    endif
  endif

  let histring = [ "hi", a:group,
        \ "guifg=" . fg[0], "ctermfg=" . fg[1],
        \ "guibg=" . bg[0], "ctermbg=" . bg[1],
        \ "gui=" . emstr[:-2], "cterm=" . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, "guisp=" . a:3[0])
  endif

  execute join(histring, " ")
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL("GruvboxFg0", s:gb.fg0)
call s:HL("GruvboxFg1", s:gb.fg1)
call s:HL("GruvboxFg2", s:gb.fg2)
call s:HL("GruvboxFg3", s:gb.fg3)
call s:HL("GruvboxFg4", s:gb.fg4)
call s:HL("GruvboxGray", s:gb.gray)
call s:HL("GruvboxBg0", s:gb.bg0)
call s:HL("GruvboxBg1", s:gb.bg1)
call s:HL("GruvboxBg2", s:gb.bg2)
call s:HL("GruvboxBg3", s:gb.bg3)
call s:HL("GruvboxBg4", s:gb.bg4)

call s:HL("GruvboxRed", s:gb.red)
call s:HL("GruvboxRedBold", s:gb.red, s:none, s:bold)
call s:HL("GruvboxGreen", s:gb.green)
call s:HL("GruvboxGreenBold", s:gb.green, s:none, s:bold)
call s:HL("GruvboxYellow", s:gb.yellow)
call s:HL("GruvboxYellowBold", s:gb.yellow, s:none, s:bold)
call s:HL("GruvboxBlue", s:gb.blue)
call s:HL("GruvboxBlueBold", s:gb.blue, s:none, s:bold)
call s:HL("GruvboxPurple", s:gb.purple)
call s:HL("GruvboxPurpleBold", s:gb.purple, s:none, s:bold)
call s:HL("GruvboxAqua", s:gb.aqua)
call s:HL("GruvboxAquaBold", s:gb.aqua, s:none, s:bold)
call s:HL("GruvboxOrange", s:gb.orange)
call s:HL("GruvboxOrangeBold", s:gb.orange, s:none, s:bold)

call s:HL("GruvboxRedSign", s:gb.red, s:sign_column, s:invert_signs)
call s:HL("GruvboxGreenSign", s:gb.green, s:sign_column, s:invert_signs)
call s:HL("GruvboxYellowSign", s:gb.yellow, s:sign_column, s:invert_signs)
call s:HL("GruvboxBlueSign", s:gb.blue, s:sign_column, s:invert_signs)
call s:HL("GruvboxPurpleSign", s:gb.purple, s:sign_column, s:invert_signs)
call s:HL("GruvboxAquaSign", s:gb.aqua, s:sign_column, s:invert_signs)
call s:HL("GruvboxOrangeSign", s:gb.orange, s:sign_column, s:invert_signs)

call s:HL("GruvboxRedUnderline", s:none, s:none, s:undercurl, s:gb.red)
call s:HL("GruvboxGreenUnderline", s:none, s:none, s:undercurl, s:gb.green)
call s:HL("GruvboxYellowUnderline", s:none, s:none, s:undercurl, s:gb.yellow)
call s:HL("GruvboxBlueUnderline", s:none, s:none, s:undercurl, s:gb.blue)
call s:HL("GruvboxPurpleUnderline", s:none, s:none, s:undercurl, s:gb.purple)
call s:HL("GruvboxAquaUnderline", s:none, s:none, s:undercurl, s:gb.aqua)
call s:HL("GruvboxOrangeUnderline", s:none, s:none, s:undercurl, s:gb.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL("Normal", s:gb.fg1, s:gb.bg0)

set background=dark

" Screen line that the cursor is
call s:HL("CursorLine",   s:none, s:gb.bg1) 
" Screen column that the cursor is
hi! link CursorColumn CursorLine

" Tab pages line filler
call s:HL("TabLineFill", s:gb.bg4, s:gb.bg1, s:invert_tabline)
" Active tab page label
call s:HL("TabLineSel", s:tabline_sel, s:gb.bg1, s:invert_tabline)
" Not active tab page label
call s:HL("TabLine", s:bg4, s:bg2, s:invert_tabline)

" Match paired bracket under the cursor
call s:HL("MatchParen", s:none, s:gb.bg2, s:bold)

" Highlighted screen columns
call s:HL("ColorColumn", s:none, s:bg1)

" Concealed element: \lambda → λ
call s:HL("Conceal", s:gb.blue, s:none)

" Line number of CursorLine
call s:HL("CursorLineNr", s:gb.yellow, s:gb.bg1)

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxFg4

call s:HL("Visual", s:gb.bg2, s:gb.fg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL("Search", s:hls_highlight, s:gb.bg0, s:inverse)
call s:HL("IncSearch", s:hls_cursor, s:gb.bg0, s:inverse)

call s:HL("QuickFixLine", s:gb.bg0, s:gb.yellow, s:bold)

call s:HL("Underlined", s:gb.blue, s:none, s:underline)

call s:HL("StatusLine",   s:gb.bg2, s:gb.fg1, s:inverse)
call s:HL("StatusLineNC", s:gb.bg1, s:gb.fg4, s:inverse)

" The column separating vertically split windows
call s:HL("VertSplit", s:gb.bg2, s:vert_split)

" Current match in wildmenu completion
call s:HL("WildMenu", s:gb.blue, s:gb.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreen

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL("ErrorMsg",   s:gb.bg0, s:gb.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
call s:HL("ModeMsg", s:bg0, s:none)
" "Press enter" prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL("LineNr", s:gb.bg4, s:number_column)

" Column where signs are displayed
call s:HL("SignColumn", s:none, s:sign_column)

" Line used for closed folds
call s:HL("Folded", s:gb.gray, s:gb.bg1, s:italic)
" Column where folds are displayed
call s:HL("FoldColumn", s:gb.gray, s:gb.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL("Cursor", s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
  call s:HL("Special", s:gb.orange, s:gb.bg1, s:italicize_strings)
endif

call s:HL("Comment", s:gb.comment_green, s:none, s:italicize_comments)
call s:HL("Todo", s:vim_fg, s:none, s:bold . s:italic)
call s:HL("Error", s:gb.red, s:none, s:bold)

" Generic statement
hi! link Statement GruvboxRed
" if, then, else, endif, switch, etc.
hi! link Conditional GruvboxRed
" for, do, while, etc.
hi! link Repeat GruvboxRed
" case, default, etc.
hi! link Label GruvboxRed
" try, catch, throw
hi! link Exception GruvboxRed
" sizeof, "+", "*", etc.
call s:HL("Operator",  s:gb.orange, s:none, s:italicize_operators)
" Any other keyword
hi! link Keyword GruvboxRed

" Variable name
hi! link Identifier GruvboxBlue
" Function name
hi! link Function GruvboxGreen

" Generic preprocessor
hi! link PreProc GruvboxAqua
" Preprocessor #include
hi! link Include GruvboxRed
" Preprocessor #define
hi! link Define GruvboxAqua
" Same as Define
hi! link Macro GruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

" Generic constant
hi! link Constant GruvboxPurple
" Character constant: "c", "/n"
hi! link Character GruvboxPurple
" String constant: "this is a string"
call s:HL("String",  s:gb.green, s:none, s:italicize_strings)

" Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
" Number constant: 234, 0xff
hi! link Number GruvboxPurple
" Floating point constant: 2.3e10
hi! link Float GruvboxPurple

" Generic type
hi! link Type GruvboxYellow
" static, register, volatile, etc
hi! link StorageClass GruvboxOrange
" struct, union, enum, etc.
hi! link Structure GruvboxBlue
" typedef
hi! link Typedef GruvboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL("Pmenu", s:gb.fg1, s:bg5)
  " Popup menu: selected item
  call s:HL("PmenuSel", s:gb.bg2, s:gb.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL("PmenuSbar", s:none, s:gb.bg2)
  " Popup menu: scrollbar thumb
  call s:HL("PmenuThumb", s:none, s:gb.bg4)
endif

" }}}
" Diffs: {{{

call s:HL("DiffDelete", s:gb.red, s:gb.bg0, s:inverse)
call s:HL("DiffAdd",    s:gb.green, s:gb.bg0, s:inverse)
"call s:HL("DiffChange", s:gb.bg0, s:gb.blue)
"call s:HL("DiffText",   s:gb.bg0, s:gb.yellow)

" Alternative setting
call s:HL("DiffChange", s:gb.aqua, s:gb.bg0, s:inverse)
call s:HL("DiffText",   s:gb.yellow, s:gb.bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    hi! link SpellCap GruvboxBlueUnderline
  else
    call s:HL("SpellCap",   s:gb.green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  hi! link SpellBad GruvboxRedUnderline
  " Wrong spelling for selected region
  hi! link SpellLocal GruvboxAquaUnderline
  " Rare word
  hi! link SpellRare GruvboxPurpleUnderline
endif

" }}}
" LSP: {{{

if has("nvim")
  hi! link DiagnosticError GruvboxRed
  hi! link DiagnosticSignError GruvboxRedSign
  hi! link DiagnosticUnderlineError GruvboxRedUnderline

  hi! link DiagnosticWarn GruvboxYellow
  hi! link DiagnosticSignWarn GruvboxYellowSign
  hi! link DiagnosticUnderlineWarn GruvboxYellowUnderline

  hi! link DiagnosticInfo GruvboxBlue
  hi! link DiagnosticSignInfo GruvboxBlueSign
  hi! link DiagnosticUnderlineInfo GruvboxBlueUnderline

  hi! link DiagnosticHint GruvboxAqua
  hi! link DiagnosticSignHint GruvboxAquaSign
  hi! link DiagnosticUnderlineHint GruvboxAquaUnderline

  hi! link LspReferenceText GruvboxYellowBold
  hi! link LspReferenceRead GruvboxYellowBold
  hi! link LspReferenceWrite GruvboxOrangeBold

  hi! link LspCodeLens GruvboxGray
endif

" }}}
" Treesitter: {{{

if has("nvim")
  " Highlight TSKeywordOperator as keywords
  " https://github.com/nvim-treesitter/nvim-treesitter/issues/447
  hi! link TSKeywordOperator GruvboxRed
endif

" }}}

" Plugin specific -------------------------------------------------------------
" Vim Multiple Cursors: {{{
call s:HL("multiple_cursors_cursor", s:none, s:none, s:inverse)
call s:HL("multiple_cursors_visual", s:none, s:gb.bg2)
" }}}
" Telescope.nvim: {{{
hi! link TelescopeNormal GruvboxFg1
hi! link TelescopeSelection GruvboxOrange
hi! link TelescopeSlectionCaret GruvboxRed
hi! link TelescopeMultiSelection GruvboxGray
hi! link TelescopeBorder GruvboxOrange
hi! link TelescopePromptBorder GruvboxAqua
hi! link TelescopeResultsBorder GruvboxPurpleBold
hi! link TelescopePreviewBorder GruvboxYellow
hi! link TelescopeMatching GruvboxBlue
hi! link TelescopePromptPrefix GruvboxRed
hi! link TelescopePrompt TelescopeNormal
" }}}
" nvim-cmp: {{{
hi! link CmpItemAbbr GruvboxFg0
hi! link CmpItemAbbrDeprecated GruvboxFg1
hi! link CmpItemAbbrMatch GruvboxAquaBold
hi! link CmpItemAbbrMatchFuzzy GruvboxOrangeUnderline
hi! link CmpItemMenu GruvboxFg1
hi! link CmpItemKindText GruvboxOrange
hi! link CmpItemKindMethod GruvboxBlue
hi! link CmpItemKindFunction GruvboxBlue
hi! link CmpItemKindConstructor GruvboxYellow
hi! link CmpItemKindField GruvboxBlue
hi! link CmpItemKindClass GruvboxYellow
hi! link CmpItemKindInterface GruvboxYellow
hi! link CmpItemKindModule GruvboxBlue
hi! link CmpItemKindProperty GruvboxBlue
hi! link CmpItemKindValue GruvboxOrange
hi! link CmpItemKindEnum GruvboxYellow
hi! link CmpItemKindKeyword GruvboxPurple
hi! link CmpItemKindSnippet GruvboxGreen
hi! link CmpItemKindFile GruvboxBlue
hi! link CmpItemKindEnumMember GruvBoxAqua
hi! link CmpItemKindConstant GruvboxOrange
hi! link CmpItemKindStruct GruvboxYellow
hi! link CmpItemKindTypeParameter GruvboxYellow
" }}}
" FTerm {{{
" TODO
call s:HL("Terminal", s:fg1, s:bg0)
call s:HL("FloatBorder", s:gb.red, s:gb.bg0)
" }}}
" NvimTree {{{
call s:HL("nvimtreeStatusbar", s:bg5, s:bg5)
call s:HL("NvimTreeNormal", s:fg3, s:bg6)
" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{
hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue
" }}}
" Html: {{{
hi! link htmlTag GruvboxAquaBold
hi! link htmlEndTag GruvboxAquaBold

hi! link htmlTagName GruvboxBlue
hi! link htmlArg GruvboxOrange

hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxBlue

call s:HL("htmlLink", s:gb.fg4, s:none, s:underline)

hi! link htmlSpecialChar GruvboxRed

call s:HL("htmlBold", s:vim_fg, s:vim_bg, s:bold)
call s:HL("htmlBoldUnderline", s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL("htmlBoldItalic", s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL("htmlBoldUnderlineItalic", s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL("htmlUnderline", s:vim_fg, s:vim_bg, s:underline)
call s:HL("htmlUnderlineItalic", s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL("htmlItalic", s:vim_fg, s:vim_bg, s:italic)
" }}}
" Xml: {{{
hi! link xmlTag GruvboxAquaBold
hi! link xmlEndTag GruvboxAquaBold
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword GruvboxAquaBold

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxPurple
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple

hi! link xmlAttrib GruvboxOrange
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxRed
hi! link xmlEntityPunct GruvboxRed
" }}}
" Vim: {{{
call s:HL("vimCommentTitle", s:gb.fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3
" }}}
" C: {{{
hi! link cOperator GruvboxPurple
hi! link cppOperator GruvboxPurple
hi! link cStructure GruvboxOrange
" }}}
" Python: {{{
hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxAqua
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxBlue
hi! link pythonImport GruvboxBlue
hi! link pythonRun GruvboxBlue
hi! link pythonCoding GruvboxBlue
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxPurple
hi! link pythonBoolean GruvboxPurple
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxGreenBold
" }}}
" CSS: {{{
hi! link cssBraces GruvboxBlue
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxBlue
hi! link cssSelectorOp GruvboxBlue
hi! link cssSelectorOp2 GruvboxBlue
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1

hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua
" }}}
" JavaScript: {{{
hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxAqua
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptParens GruvboxFg3
" }}}
" TypeScript: {{{
hi! link typescriptReserved GruvboxAqua
hi! link typescriptLabel GruvboxAqua
hi! link typescriptFuncKeyword GruvboxAqua
hi! link typescriptIdentifier GruvboxOrange
hi! link typescriptBraces GruvboxFg1
hi! link typescriptEndColons GruvboxFg1
hi! link typescriptDOMObjects GruvboxFg1
hi! link typescriptAjaxMethods GruvboxFg1
hi! link typescriptLogicSymbols GruvboxFg1
hi! link typescriptDocSeeTag Comment
hi! link typescriptDocParam Comment
hi! link typescriptDocTags vimCommentTitle
hi! link typescriptGlobalObjects GruvboxFg1
hi! link typescriptParens GruvboxFg3
hi! link typescriptOpSymbols GruvboxFg3
hi! link typescriptHtmlElemProperties GruvboxFg1
hi! link typescriptNull GruvboxPurple
hi! link typescriptInterpolationDelimiter GruvboxAqua
" }}}
" Ruby: {{{
hi! link rubyStringDelimiter GruvboxGreen
hi! link rubyInterpolationDelimiter GruvboxAqua
hi! link rubyDefinedOperator rubyKeyword
" }}}
" Lua: {{{
hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange
" }}}
" Java: {{{
hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange

hi! link javaVarArg GruvboxGreen
" }}}
" Markdown: {{{
call s:HL("markdownItalic", s:fg3, s:none, s:italic)
call s:HL("markdownBold", s:fg3, s:none, s:bold)
call s:HL("markdownBoldItalic", s:fg3, s:none, s:bold . s:italic)

hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxGreen

call s:HL("markdownLinkText", s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText
" }}}
" Haskell: {{{
hi! link haskellType GruvboxBlue
hi! link haskellIdentifier GruvboxAqua
hi! link haskellSeparator GruvboxFg4
hi! link haskellDelimiter GruvboxOrange
hi! link haskellOperators GruvboxPurple

hi! link haskellBacktick GruvboxOrange
hi! link haskellStatement GruvboxPurple
hi! link haskellConditional GruvboxPurple

hi! link haskellLet GruvboxRed
hi! link haskellDefault GruvboxRed
hi! link haskellWhere GruvboxRed
hi! link haskellBottom GruvboxRedBold
hi! link haskellImportKeywords GruvboxPurpleBold
hi! link haskellDeclKeyword GruvboxOrange
hi! link haskellDecl GruvboxOrange
hi! link haskellDeriving GruvboxPurple
hi! link haskellAssocType GruvboxAqua

hi! link haskellNumber GruvboxAqua
hi! link haskellPragma GruvboxRedBold

hi! link haskellTH GruvboxAquaBold
hi! link haskellForeignKeywords GruvboxGreen
hi! link haskellKeyword GruvboxRed
hi! link haskellFloat GruvboxAqua
hi! link haskellInfix GruvboxPurple
hi! link haskellQuote GruvboxGreenBold
hi! link haskellShebang GruvboxYellowBold
hi! link haskellLiquid GruvboxPurpleBold
hi! link haskellQuasiQuoted GruvboxBlueBold
hi! link haskellRecursiveDo GruvboxPurple
hi! link haskellQuotedType GruvboxRed
hi! link haskellPreProc GruvboxFg4
hi! link haskellTypeRoles GruvboxRedBold
hi! link haskellTypeForall GruvboxRed
hi! link haskellPatternKeyword GruvboxBlue
" }}}
" Json: {{{
hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1
" }}}
" Mail: {{{
" Override some defaults defined by mail.vim
" mail quoted text
hi! link mailQuoted1 GruvBoxAqua
hi! link mailQuoted2 GruvBoxPurple
hi! link mailQuoted3 GruvBoxYellow
hi! link mailQuoted4 GruvBoxGreen
hi! link mailQuoted5 GruvBoxRed
hi! link mailQuoted6 GruvBoxOrange

hi! link mailSignature Comment
" }}}
" C#: {{{
hi! link csBraces GruvboxFg1
hi! link csEndColon GruvboxFg1
hi! link csLogicSymbols GruvboxFg1
hi! link csParens GruvboxFg3
hi! link csOpSymbols GruvboxFg3
hi! link csInterpolationDelimiter GruvboxFg3
hi! link csInterpolationAlignDel GruvboxAquaBold
hi! link csInterpolationFormat GruvboxAqua
hi! link csInterpolationFormatDel GruvboxAquaBold
" }}}
" Rust {{{
hi! link rustSigil GruvboxOrange
hi! link rustEscape GruvboxAqua
hi! link rustStringContinuation GruvboxAqua
hi! link rustEnum GruvboxAqua
hi! link rustStructure GruvboxAqua
hi! link rustModPathSep GruvboxFg2
hi! link rustCommentLineDoc Comment
hi! link rustDefault GruvboxAqua
hi! link rustStorage GruvboxOrange
" }}}

" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL("Cursor", s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL("Cursor", s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
