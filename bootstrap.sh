# Before running this script:
# sudo chrown -R evan /usr/local
# sudo echo '/usr/local/bin/bash' >> /etc/shells

# make in case they aren't already there
mkdir -p "/usr/local/lib"
mkdir -p "/usr/local/bin"

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install and use latest bash
brew install bash
chsh -s /usr/local/bin/bash

# Install git
brew install git
# Some git defaults
git config --global color.ui true
git config --global push.default simple

# Install nvm
echo "Installing nvm..."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install stable
nvm alias default stable

# Centralize global npm packages for different node versions
echo "prefix = /usr/local" > ~/.npmrc

# Install Node modules
modules=(
  grunt-cli
  jasmine-node
  gulp
  phantomjs
  casperjs
  anywhere
  webpack
  browserify
  watchify
  bower
  starz
)

echo "installing node modules..."
npm install -g ${modules[@]}

# Install Brew Cask
echo "Installing brew cask..."
brew install caskroom/cask/brew-cask

# Apps
apps=(
  google-chrome
  firefox
  iterm2
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# clone this repo
git clone https://github.com/uedaeita/dotfiles ~/.dotfiles

# Make some commonly used folders
mkdir ~/Personal
mkdir ~/Work

# Source dot files
echo '. ~/.dotfiles/bash/.profile' >> ~/.profile
source ~/.profile

