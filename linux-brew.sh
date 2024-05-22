#!/usr/bin/env bash

sudo apt install build-essential

# Install brew if not installed
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -d /opt/homebrew/bin ]
then 
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [ -d /home/linuxbrew/.linuxbrew/bin ]
then 
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew install zsh

# Install oh-my-zsh
if [ ! -d ${ZSH:-~/.oh-my-zsh} ]
then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]
then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions ]
then
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi

# Install command-line tools using Homebrew.
brew install fnt
fnt install fonts-firacode
# brew tap homebrew/cask-fonts
# brew install --cask font-fira-code
# brew install --cask font-3270-nerd-font font-caskaydia-cove-nerd-font font-fira-code-nerd-font font-hurmit-nerd-font font-heavy-data-nerd-font

# # Make sure we’re using the latest Homebrew.
# brew update

# # Upgrade any already-installed formulae.
# brew upgrade

# # Save Homebrew’s installed location.
# BREW_PREFIX=$(brew --prefix)

# brew tap homebrew/cask

# # Install GNU core utilities (those that come with macOS are outdated).
# # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# brew install coreutils
# ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
# Don’t forget to add `$(brew --prefix gnu-sed)/libexec/gnu-sed` to `$PATH`.
brew install gnu-sed
# Install a modern version of Bash.
brew install bash
brew install bash-completion@2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# # Install `wget` with IRI support.
# # brew install wget --with-iri
# brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# # Install more recent versions of some macOS tools.
# brew install vim
# brew install grep
# brew install openssh
# brew install screen
# # brew install php
# # brew install gmp

# # # Install font tools.
# # brew tap bramstein/webfonttools
# # brew install sfnt2woff
# # brew install sfnt2woff-zopfli
# # brew install woff2

# # # Install some CTF tools; see https://github.com/ctfs/write-ups.
# # brew install aircrack-ng
# # brew install bfg
# # brew install binutils
# # brew install binwalk
# # brew install cifer
# # brew install dex2jar
# # brew install dns2tcp
# # brew install fcrackzip
# # brew install foremost
# # brew install hashpump
# # brew install hydra
# # brew install john
# # brew install knock
# # brew install netpbm
# # brew install nmap
# # brew install pngcheck
# # brew install socat
# # brew install sqlmap
# # brew install tcpflow
# # brew install tcpreplay
# # brew install tcptrace
# # brew install ucspi-tcp # `tcpserver` etc.
# # brew install xpdf
# # brew install xz

# # # Install other useful binaries.
# # brew install ack
# # #brew install exiv2
brew install git
brew install git-lfs
# # brew install gs
# # brew install imagemagick --with-webp
# # brew install lua
# # brew install lynx
# # brew install p7zip
# # brew install pigz
# # brew install pv
# # brew install rename
# # brew install rlwrap
# # brew install ssh-copy-id
# # brew install tree
# # brew install vbindiff
# # brew install zopfli

# Install command line apps.
brew install starship
brew install gh
brew install go
brew install k9s
# brew install k3d
brew install nvm
brew install jq
brew install openjdk
# sudo ln -sfn $(brew --prefix openjdk)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
# brew install openjdk@11
# sudo ln -sfn $(brew --prefix openjdk@11)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
# brew install openjdk@17
# sudo ln -sfn $(brew --prefix openjdk@17)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
brew install python@3.11
brew install python@3.12


brew install gradle
brew install gradle-completion

# brew install google-cloud-sdk
brew install azure-cli

# # Install hyperkit and minikube
# #brew install hyperkit
# #brew install minikube

# Install Docker CLI
brew install kubectl
# brew install docker
# brew install docker-credential-helper
# brew install docker-compose
# brew install colima
brew install helm
# brew install terraformer aztfexport

brew tap hashicorp/tap
brew install hashicorp/tap/terraform

brew tap thought-machine/please
brew install please

# # Install cask application
# brew install --cask drawio
# brew install --cask iterm2
# brew install --cask visual-studio-code
# brew install --cask bitwarden
# brew install --cask rectangle
# brew install --cask maccy
# brew install --cask google-chrome
# brew install --cask google-drive
# brew install --cask microsoft-remote-desktop
# brew install --cask slack
# brew install --cask 1password-cli 1password
# brew install --cask multipass

# brew install ubuntu/microk8s/microk8s
# brew install Azure/kubelogin/kubelogin

# brew tap isen-ng/dotnet-sdk-versions
# brew install --cask dotnet-sdk6-0-400
# brew install --cask dotnet-sdk7-0-200
# brew install --cask dotnet-sdk



# brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
# brew update
# brew install mssql-tools




# # Remove outdated versions from the cellar.
# brew cleanup

# # curl -SsL https://github.com/kvz/json2hcl/releases/download/v0.1.1/json2hcl_0.1.1_darwin_arm64.tar.gz | tar -C  ~/.local/bin/ -xzv json2hcl > /dev/null && chmod 755 ~/.local/bin/json2hcl && json2hcl -version
