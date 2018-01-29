
.PHONY: osx install

STOWOPTS ?= --adopt  # pass "-D" to revert stowed dotfiles for a given make target
OSX_PACKAGES = shell git bin
PACKAGES = bin git nvim powerline python shell ssh tmux 

# allow user to specify out of band makefiles (something.mk)
EXTRA_INCLUDES:=$(wildcard *.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
	  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
	    include $(EXTRA_INCLUDES)
	endif

# for each osx-specific package override, symlink the files
# contained in the package (using stow) into the main
# package directory.
MAKEDIR = $(shell pwd)
osx:
	@cd contexts/osx && $(foreach p, $(OSX_PACKAGES), \
		stow $(STOWOPTS) -t $(MAKEDIR)/$p $p; \
	)

all:
	@$(foreach p, $(PACKAGES), \
		stow $(STOWOPTS) $p; \
	)

# add a line to .stowrc to target user's ${HOME}
STOWRC = .stowrc
install:
	grep -q ^--target $(STOWRC) && perl -i -pe 's|^--target.*|--target=${HOME}|' $(STOWRC) || echo '--target=${HOME}' >> $(STOWRC)
