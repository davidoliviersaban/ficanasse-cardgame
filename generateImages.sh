#!/usr/bin/env bash

set -o errexit -o noclobber -o pipefail

function install_rbenv_upgrade_ruby() {
    # Get Homebrew:
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install rbenv ruby-build
    # Add rbenv to bash so that it loads every time you open a terminal
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
    source ~/.bash_profile

    rbenv install 2.7.1
    rbenv global 2.7.1
    ruby -v
    gem install pkg-config
    gem install squib
}

# install_rbenv_upgrade_ruby

# source ~/.bash_profile

rm -rf _cards* _terrain*
ruby src/main/ruby/carte.rb
# ruby src/main/ruby/horde_cards.rb
cd ../printableCardsAppender
./gradlew appendCard --args="../ficanasse-cardgame/_cards ../ficanasse-cardgame/imagesToPrint/carte   A4 false"
# ./gradlew appendCard --args="../windwalkers-cardgame/_cards1  ../windwalkers-cardgame/imagesToPrint/cards_v1_ A4 false"
# ./gradlew appendCard --args="../windwalkers-cardgame/_cards_cut  ../windwalkers-cardgame/imagesToPrint/cards_cut_ A4 false"
