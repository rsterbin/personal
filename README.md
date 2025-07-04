personal
========

Various stuff I need on dev zones: bash setup, vim setup, subversion config,
etc.  The check script is because I tend to keep the repo elsewhere and copy
changes into the actual files.

## Other steps for a new mac workstation (for development)

These should happen ahead of running `./init.sh`. It can be rerun if necessary, but it's a smoother experience with all this done in advance.

* [Create a new ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* [Add it to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
* [Make sure it works](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
* Clone this repo
* Clone the private shortcuts repo to `~/git/iterm2-my-shortcuts`
* [Install Homebrew](https://brew.sh/)
* [Install iTerm2](https://iterm2.com/downloads.html) and configure as listed in the next section
* Change the default shell to bash (`chsh`, then double check iterm2 and terminal app)
* Install pyenv: `brew install pyenv`

## Custom iTerm2 settings

The standard settings are mostly fine, but there's a few tweaks I like to make.

* Profiles:
  * Color tab:
    * Uncheck separate colors for light and dark mode
    * Use the "Dark Background" color preset
    * Cursor Boost to 10
    * Change the ANSI colors for blue to `616cdc` for dark and `9296ef` for light
  * Text tab:
    * Font Monaco Regular, 16
  * Window tab:
    * Trasparency 10
  * Terminal tab:
    * Check unlimited scrollback
    * Check silence bell
  * Keys tab:
    * Change bindings for next/previous tabs and their move tab versions to use control instead of command

