# dotfiles

Dotfiles, managed using `GNU stow` packages.  Packages are defined in top-level directories.

Allows overriding all or parts of `stow` packages for different contexts; you may have a context-specific dotfile (git config for work vs home, for example) that you want to override the default.
In order to accomplish this, `make` targets are defined for each context that will use `GNU stow` to symlink them into the top-level stow packages.  This uses the stow feature `--adopt` to override an existing file.  Essentially, it is replacing the file on disk with a synmlink to the override file, but don't worry - this is a git repository so you will not lose the origiunal file.  Instead, you will see  messages like this to appear in git-status indicating that the file wa schanged to a symlink:

    typechange: python/.pypirc

If you see these, *do not stage them*.  There is a way to prevent git from allowing you to stage these, but I dont think its necessary to implement.  If you stow, and then unstow, a package that contained an override, you will see that its been deleted in git; *do not stage this*:

    deleted:    python/.pypirc

Instead, just instage the deletion:

    git checkout -- python/.pypirc

Ships with a few contexts (osx, linux) with corresponding `make` targets.  Also supports custom contexts, using `make` includes; define an .mk file that contains your private targets and they will be made available.  .mk files are already .gitignored, but you shoyuld add your context directories to .gitignore as well in case there is private info in them.
