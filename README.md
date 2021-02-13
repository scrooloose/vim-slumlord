Oh shit! Lock up your daughters it's ...

```
███████╗██╗     ██╗   ██╗███╗   ███╗██╗      ██████╗ ██████╗ ██████╗ 
██╔════╝██║     ██║   ██║████╗ ████║██║     ██╔═══██╗██╔══██╗██╔══██╗
███████╗██║     ██║   ██║██╔████╔██║██║     ██║   ██║██████╔╝██║  ██║
╚════██║██║     ██║   ██║██║╚██╔╝██║██║     ██║   ██║██╔══██╗██║  ██║
███████║███████╗╚██████╔╝██║ ╚═╝ ██║███████╗╚██████╔╝██║  ██║██████╔╝
╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
```

Introduction
============

Slumlord is built atop the wang-hardeningly awesome [plantuml](http://plantuml.com).
It gives you a "live preview" of your UML diagrams when you save.

![Demo](https://github.com/scrooloose/vim-slumlord/raw/master/_assets/demo.gif)


Installation
============

First you need Java installed.

Then, install this plugin with your favourite vim plugin manager.

For [vundle](https://github.com/VundleVim/Vundle.vim), just stick this in your
vimrc and smoke it:

```
Plugin 'scrooloose/vim-slumlord'
```

Then run `:Vundle install`

I also recommend installing the
[plantuml-syntax](https://github.com/aklt/plantuml-syntax) plugin as Slumlord
uses this for its syntax file.

```
Plugin 'aklt/plantuml-syntax'
```

Usage
=====

Edit a `.uml` file and enter some plantuml code. When you save it, a preview
will be forcefully inserted/updated at the top of your file!

Note: I have only used this for sequence diagrams - the ASCII output of
plantuml seems to be less than stellar for other diagram types.

Advanced usage
==============

* Separate window
* Swap the layout to vertical with `Ctrl+w H` or type `:wincmd H`

TIP: if the file extension was not recognized by default use `:set ft=plantuml` to enable the plugin.

```vim
" default path for the plantuml debian package
let g:slumlord_plantuml_jar_path = "/usr/share/plantuml/plantuml.jar"

" some common configurations
let g:slumlord_plantuml_include_path = "~/.config/plantuml/include/"

" use another buffer for preview
let g:slumlord_separate_win = 1

" enable utf symbols (default)
let g:slumlord_asciiart_utf = 1
```

![Demo alt](https://github.com/geraldolsribeiro/vim-slumlord/raw/master/_assets/demo-alt.gif)
