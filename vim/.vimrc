

" ---------- basic ----------
set nocompatible          " 使用 Vim 而非老式 vi 的行为
set history=500           " 命令历史条数
set autoread              " 文件在外部被修改时自动重新读取
set hidden                " 切换 buffer 时不强制先保存
set scrolloff=8           " 光标距离屏幕上下边缘至少保留 8 行
set laststatus=2          " 始终显示状态栏
set showcmd               " 右下角显示正在输入的命令（学习时很有帮助）
set mouse=a               " 允许鼠标（过渡期用，熟练后可以去掉）

" ---------- 语法与文件类型 ----------
syntax enable
filetype plugin indent on
set background=dark

" ---------- 行号 ----------
set number                " 显示当前行的绝对行号
set relativenumber        " 其余行显示相对行号，配合 5j / 3k 跳转
set cursorline            " 高亮当前行
try
    set cursorlineopt=number   " 只高亮行号，不高亮整行（较新版本支持）
catch /E518:/
endtry

" ---------- 搜索 ----------
set hlsearch              " 高亮所有匹配
set incsearch             " 边输入边跳转
set ignorecase            " 默认忽略大小写
set smartcase             " 输入了大写字母时自动区分大小写

" ---------- 缩进 ----------
set expandtab             " Tab 键插入空格
set tabstop=4
set shiftwidth=4
set autoindent

" ---------- 命令行补全 ----------
set wildmenu
set wildmode=longest:full,full

" ---------- 分屏 ----------
set splitbelow            " :split 新窗口出现在下方
set splitright            " :vsplit 新窗口出现在右侧

" ---------- 持久化撤销（关闭文件后重新打开仍可 u 撤销）----------
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
endif
set undodir=~/.vim/undo
set undofile

" ---------- 模式切换无延迟 ----------
set ttimeout
set ttimeoutlen=10

" ---------- Leader 键与少量安全映射 ----------
let mapleader = " "
" 空格 + Esc：清除搜索高亮
nnoremap <leader><Esc> :nohlsearch<CR>
" 可视模式下 > / < 缩进后保持选中，可以连续按
vnoremap > >gv
vnoremap < <gv

" =====================================================
" 以下是以后可以按需加入的内容（先别急着打开）
" =====================================================
" 1. fzf 模糊查找：先安装 fzf 和 fzf.vim 插件，再取消下面注释
"    nnoremap <leader><leader> :Files<CR>
"    nnoremap <leader>/ :RG<CR>
"    nnoremap <leader>sb :Buffers<CR>
"
set clipboard=unnamed,unnamedplus