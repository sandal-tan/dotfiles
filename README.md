# dotfiles

These are my dotfiles and other environment things that I wanted to standardize.

This project will be my third (maybe fourth) iteration on my dotfiles collection. This go around, I am hoping to improve
both repeatability and documentation of my environment so I can continue to manage one environment instead of
monkey-patching it together as it is currently, and has always been for me.


To bootstrap a new environment:
    
    curl -L --silent https://git.io/JvO8d | bash

## `init.sh`

Bootstrap script for new hosts. Begins new machine setup.

Currently supported OSes

- `macOS`

By default, the installation command:

    curl --silent https://git.io/JvO8d | bash

will download the latest from  `master`, however, the variable `REF` can be defined and the branch will be downloaded
instead, such as:

    curl --silent https://git.io/JvO8d | REF=init bash

## Notes

I would like to look into the following:

- [direnv](https://direnv.net/) for making sensitive environments
- [revolver](https://github.com/molovo/revolver) for pretty printing
- [ansi](https://github.com/fidian/ansi)
- [lj](https://github.com/molovo/lumberjack)
- [ondir](https://github.com/alecthomas/ondir)
- Python based messaging tool to interface with xanthia, fzf for history, and login info notifications
- TMUX and AWS hosting remote sessions
- TMUX-based IDE commands. A way to edit python, tie that editor to an instance of ipython that is tied to the code,
  and a visual way to see and run pytests for relevant pieces of code.
- TODO tracking. Make that pattern useable for tasks.
- Add a post-init section to move some initial configuration out of the way of fish

## Development

A test server is provided to provide an ability to test the curl-based interactions without relying on external
infrastructure.

To start the server:

    $ ./run_test_server.sh

This will start a simple web-server to server the project directory. By default, the development server runs on port
`8000`. In order for `init.sh` to be used in testing mode the environment in which it is running must have
`BOOTSTRAP_MODE` set to `test`, which tells the script to download from the test server.

Example:

    $ curl --silent localhost:8000/init.sh | BOOTSTRAP_MODE=test bash
