VENDOR_DIR=	$(CURDIR)/vendor

ifdef WITHOUT_CURSES
without_curses_arg=	--without curses
else
without_curses_arg=	# defined
endif

ifdef WITHOUT_TESTS
without_tests_arg=	--without tests
else
without_tests_arg=	# defined
endif


.PHONY: help
help:
	@echo Available targets:
	@echo - rdoc
	@echo - bundle-install
	@echo - unit-tests

.PHONY: rdoc
rdoc:
	rdoc --root=$(CURDIR) --all		\
		-t XXXFIXME			\
		-x "test/*"			\
		-x "example/*"			\
		-x "$(notdir $(VENDOR_DIR))/*"	\
		-x "Gemfile*"			\
		-x "Makefile"			\
		-m README.md			\
		-o rdoc

.PHONY: bundle-install
bundle-install:
	bundle install $(without_curses_arg) $(without_tests_arg) --path $(CURDIR)/vendor

.PHONY: unit-tests
unit-tests:
	bundle exec bacon tests/*.rb
