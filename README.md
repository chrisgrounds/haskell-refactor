# Haskell Refactor

A lightweight vim plugin that helps you refactor Haskell code.

![Demo](https://github.com/chris-bacon/haskell-refactor/raw/master/demo.gif "Demo")

## Installation

With `Plug` add,

```vim
Plug 'chris-bacon/haskell-refactor'
```

to your vimrc.

Alternatively, you can clone this repo.

## Usage

### Commands

Select the code you wish to refactor in visual mode. You can then use the following commands:

```vim
:ExtractHaskellFunction <name> <params>
:ExtractHaskellType <name>
```

All options are optional. Every command will default to a prompt if no args are provided, so you do not need to provide any arguments. This also means you can use the following mappings.

### Mappings

You following are examples of mappings you could create for each command:

```vim
vnoremap <leader>ef :ExtractHaskellFunction<cr>
vnoremap <leader>et :ExtractHaskellType<cr>
```

## Contributing

_Please feel free to raise any issues or PRs._

### Tests

There are some tests to ensure regressions are not added.

You will need to have [vader](https://github.com/junegunn/vader.vim) installed. Then you will be able to run `Vader .vader` and hopefully see the following output:

![Tests Image](https://github.com/chris-bacon/haskell-refactor/raw/master/vader-tests.png "Vader Tests")
