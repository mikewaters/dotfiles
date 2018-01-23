
.PHONY: osx macbook

STOWOPTS ?=  # pass "-D" to revert stowed dotfiles for a given make target
OSX_PACKAGES = shell git

# allow user to specify out of band makefiles (something.mk)
EXTRA_INCLUDES:=$(wildcard *.mk)
ifneq ($(strip $(EXTRA_INCLUDES)),)
	  contents :=  $(shell echo including extra rules $(EXTRA_INCLUDES))
	    include $(EXTRA_INCLUDES)
	endif

# for each osx-specific package override, symlink the files
# contained in the package (using stow) into the main
# package directory.
osx:
	@cd osx && $(foreach p, $(OSX_PACKAGES), \
		stow $(STOWOPTS) -t ../$p $p; \
	)

