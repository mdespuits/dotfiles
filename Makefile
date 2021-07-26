LOGFILE=/tmp/dotfiles.log

default: run
help:
	@echo 'Management commands for dotfiles:'
	@echo
	@echo 'Usage:'
# @echo '    make chezmoi-init       Initialize chezmoi.'
# @echo '    make chezmoi-apply      Apply chezmoi files (runs all scripts).'
# @echo '    make post-chezmoi       Run post chezmoi scripts.'
	@echo '    make install-homebrew   Install Homebrew.'
# @echo '    make install-chezmoi    Install chezmoi.'
	@echo '    make install-asdf       Install asdf and plugins.'
	@echo '    make install-nvm        Install nvm.'
	@echo '    make install-bw         Install Bitwarden CLI.'
# @echo '    make install-deps       Install system dependencies.'
# @echo '    make ensure-dirs        Creates required directories.'
# @echo '    make install-riscv      Install RISC-V toolchain and dependencies.'
# @echo '    make install-osx-app    Install MacOS applications (requires mas).'
	@echo
	@echo '    make run                Ensure deps and apply chezmoi.'
	@echo '    make all                Run all.'
	@echo
	@echo '    Logs are stored in      $(LOGFILE)'
	@echo
	@echo '    Author                  Matthew Wells (github.com/mdespuits)'

install-homebrew:
	bash ./scripts/install_homebrew.sh | tee -a $(LOGFILE)

install-asdf:
	bash ./scripts/install_asdf.sh | tee -a $(LOGFILE)

install-nvm:
	bash ./scripts/install_nvm.sh | tee -a $(LOGFILE)

install-bw:
	$(MAKE) install-homebrew
	bash ./scripts/install_bitwarden.sh | tee -a $(LOGFILE)

install-gpg-keys:
	$(MAKE) install-bw
	bash ./scripts/install_gpg_keys.sh | tee -a $(LOGFILE)

all:
	$(MAKE) install-homebrew
	$(MAKE) install-bw

run: all
