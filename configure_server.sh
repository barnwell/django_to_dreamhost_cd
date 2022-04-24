#!/bin/bash


# setup github actions key:
read -r -p "Configure Server for Github CD? (y/n): " github_cd
if [ "$github_cd" == "y" ]; then
  cd ~/.ssh || exit

  read -r -p "Enter github account email:" git_email
  ssh-keygen -t rsa -b 4096 -C "$git_email" -f ~/.ssh/github-actions -N "" <<<y >/dev/null 2>&1

  cat github-actions.pub >> authorized_keys

  read -r -p "Enter host eg:jasonbarnwell.net" hostname
  ssh-keyscan -H "$hostname" >> ~/.ssh/known_hosts

fi

# Installing Python:
read -r -p "Install Python? (y/n): " python_install
if [ "$python_install" == "y" ]; then
  cd ~ || exit
  mkdir tmp
  cd tmp || exit
  wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
  tar zxvf Python-3.10.1.tgz
  cd Python-3.10.1 || exit
  ./configure --prefix="$HOME"/opt/python-3.10.1
  make
  make install

  cd ~ || exit
  echo export PATH=$HOME/opt/python-3.10.1/bin:$PATH >> ~/.bash_profile
  # shellcheck disable=SC1090
  . ~/.bash_profile
fi


# Installing Virtualenv using pip3:
read -r -p "Install virtualenv? (y/n): " virtualenv_install
if [ "$virtualenv_install" == "y" ]; then
  python3 -m pip install --upgrade pip
  pip3 install virtualenv
fi


read -r -p "Domain folder eg:mywebsite.com: " domain_folder
if [ -n "$domain_folder" ]; then
  mkdir -p "$HOME"/"$domain_folder"/public
  cd ~/"$domain_folder"/public || exit
  # shellcheck disable=SC1090
  . ~/.bash_profile
  virtualenv -p ~/opt/python-3.10.1/bin/python3 venv
  source venv/bin/activate
fi
