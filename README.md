# Selbirin Engine

_Selbirin Engine_ is a collection of tools and libraries which enable the
creation of online, networked, text-based worlds in the spirit of old MUDs
and MUCKs.

Both client and server software is implemented entirely in Ruby. This allows
game developers and worldbuilders to create rich, interactive worlds with
scripts written in Ruby.


## Installation

We provide a Gemfile so that you can use Bundler to install dependencies. 

Note that Selbirin Engine's core server functionality is implemented
entirely with code available in Ruby's standard library. External
dependencies are required only for extra features. If you want access to all
features, then you should install all dependencies like this:

    $ make bundle-install

But you can customize the installation. This `make` command line accepts the
following arguments:

- `WITHOUT_CURSES=yes`, to disable the installing Curses (needed to run the
  Curses client).

- `WITHOUT_TESTS=yes`, to disable installing libraries which support running
  unit tests.

Dependencies are saved in a directory called `./vendor`.



## FAQ

**This is a game?** -- No, it's essentially game _engine._

**What does "Selbirin" mean?** -- It's a reference to _The Once and Future
Nerd_.


[![forthebadge](https://forthebadge.com/images/badges/built-by-codebabes.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
