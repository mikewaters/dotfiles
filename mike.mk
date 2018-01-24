.PHONY: dt

dt: osx
	@cd contexts/dt && $(foreach p, "python", \
		stow $(STOWOPTS) --adopt -t $(MAKEDIR)/$p $p; \
	)
