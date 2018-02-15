
.PHONY: osx install

STOWOPTS ?= # pass "-D" to revert stowed dotfiles for a given make target
OSX_PACKAGES = shell git bin vscode
PACKAGES = bin git nvim powerline python shell ssh tmux alacritty vscode

# allow user to specify out of band makefiles (something.mk)
EXTRA_INCLUDES:=$(wildcard *.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
	  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
	    include $(EXTRA_INCLUDES)
	endif

# for each osx-specific package override, symlink the files
# contained in the package (using stow) into the main
# package directory.  We essentially `-f` here, using --adopt,
# which will force the change even if the file exists (which is
# the whole point of overriding).  We don't --adopt anywhere else;
# in this repo we have control, but in the user's home directory
# it would risk deleting files that they need.
MAKEDIR = $(shell pwd)
osx:
	@cd contexts/osx && $(foreach p, $(OSX_PACKAGES), \
		stow $(STOWOPTS) --adopt -t $(MAKEDIR)/$p $p; \
	)

all:
	@$(foreach p, $(PACKAGES), \
		stow $(STOWOPTS) $p; \
	)

# add a line to .stowrc to target user's ${HOME}
STOWRC = .stowrc
install:
	grep -q ^--target $(STOWRC) && perl -i -pe 's|^--target.*|--target=${HOME}|' $(STOWRC) || echo '--target=${HOME}' >> $(STOWRC)
