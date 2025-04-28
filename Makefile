INSTALL_DIR := $(HOME)/bin
VERSION := $(shell cat VERSION)
SCRIPTS := clipcopy clipappend clippaste cliprun clipclear clipedit cliphelp

install:
	mkdir -p $(INSTALL_DIR)
	for script in $(SCRIPTS); do \
	    sed "s/@VERSION@/$(VERSION)/g" scripts/$$script.sh > $(INSTALL_DIR)/$$script; \
	    chmod +x $(INSTALL_DIR)/$$script; \
	done
	@echo "Installed clipkit scripts to $(INSTALL_DIR)"


uninstall:
	for script in $(SCRIPTS); do \
	    rm -f $(INSTALL_DIR)/$$script; \
	done
	@echo "Removed clipkit scripts from $(INSTALL_DIR)"

.PHONY: install uninstall
