EXECUTABLES = eddy-handler
POLICIES = dev.minios.eddy-handler.policy

BINDIR = usr/bin
POLKITACTIONSDIR = usr/share/polkit-1/actions
LOCALEDIR = usr/share/locale

PO_FILES = $(shell find locale -name "*.po" -maxdepth 1)
MO_FILES = $(patsubst %.po,%.mo,$(PO_FILES))

build: locale

locale: $(MO_FILES)

%.mo: %.po
	@echo "Generating mo file for $<"
	msgfmt -o $@ $<
	chmod 644 $@

clean:
	rm -rf $(MO_FILES)

install: build
	install -d $(DESTDIR)/$(BINDIR) \
				$(DESTDIR)/$(POLKITACTIONSDIR) \
				$(DESTDIR)/$(LOCALEDIR)

	cp $(EXECUTABLES) $(DESTDIR)/$(BINDIR)
	cp $(POLICIES) $(DESTDIR)/$(POLKITACTIONSDIR)

	for MO_FILE in $(MO_FILES); do \
		LOCALE=$$(basename $$MO_FILE .mo); \
		echo "Copying mo file $$MO_FILE to $(DESTDIR)/usr/share/locale/$$LOCALE/LC_MESSAGES/eddy-handler.mo"; \
		install -Dm644 "$$MO_FILE" "$(DESTDIR)/usr/share/locale/$$LOCALE/LC_MESSAGES/eddy-handler.mo"; \
	done
