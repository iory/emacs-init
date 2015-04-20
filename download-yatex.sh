#!/bin/sh

# tex install
sudo apt-get -y install texlive
sudo apt-get -y install texlive-lang-cjk
sudo apt-get -y install xdvik-ja
sudo apt-get -y install dvipsk-ja
sudo apt-get -y install gv
sudo apt-get -y install texlive-fonts-recommended texlive-fonts-extra

# yatex install to site-lisp
wget http://www.yatex.org/yatex1.78.4.tar.gz
tar xvzf yatex1.78.4.tar.gz
mv yatex1.78.4 site-lisp/yatex
rm yatex1.78.4.tar.gz
