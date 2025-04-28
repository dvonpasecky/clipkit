INSTALL_DIR := $(HOME)/bin
VERSION := $(shell cat VERSION)
SCRIPTS := clipcopy clipappend clippaste cliprun clipclear clipedit cliphelp

install:
	mkdir -p $(INSTALL_DIR)
	for script in $(SCRIPTS); do \
	    sed "s/@VERSION@/$(VERSION)/g" scripts/$$script.sh > $(INSTALL_DIR)/$$script; \
	    chmod +x $(INSTALL_DIR)/$$script; \
	done
	# Also install clipkit as an alias for cliphelp
	cp $(INSTALL_DIR)/cliphelp $(INSTALL_DIR)/clipkit
	chmod +x $(INSTALL_DIR)/clipkit
	@echo "Installed clipkit alias."

uninstall:
	for script in $(SCRIPTS); do \
	    rm -f $(INSTALL_DIR)/$$script; \
	done
	rm -f $(INSTALL_DIR)/clipkit
	@echo "Removed clipkit scripts."

.PHONY: install uninstall
