# pacman add more mirrors and update

#cat <<EOF >> /etc/pacman.conf
#[multilib]
#Include = /etc/pacman.d/mirrorlist

#[archlinuxfr]
#SigLevel = Never
#Server = http://repo.archlinux.fr/$arch
#EOF

# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOME=`pwd`

echo 'LANG=en_US.UTF-8' > /etc/locale.conf

pacman -Sy --noconfirm

# Installs
# pacman -S --noconfirm base-devel

pacman -S --noconfirm iotop ncdu gnu-netcat the_silver_searcher htop
pacman -S --noconfirm clang clang-analyzer
pacman -S --noconfirm valgrind
pacman -S --noconfirm ctags
pacman -S --noconfirm tmux
pacman -S --noconfirm git


pacman -S --noconfirm ccache

pacman -S --noconfirm nodejs

mkdir -p ~/npm-global
npm config set prefix '~/npm-global'
npm install -g jshint

pacman -S --noconfirm python-pip
pip install Pygments

# fix python version -- pretty much everything breaks with python3
rm /usr/bin/python
ln -s /usr/bin/python2 /usr/bin/python

# big but has python and ruby support and until we figure out how to eidt PKGBUILD on the fly to
# do https://github.com/thlorenz/dox/blob/master/misc/dual-boot-arch-on-mac.md#vim-with-python-and-ruby-support
# we'll live with it
pacman -S --noconfirm gvim

# my dotfile setup
git clone https://github.com/thlorenz/dotfiles.git ~/dotfiles
chown -R vagrant:vagrant ~/dotfiles

rm -f ~/.bashrc ~/.profile

~/dotfiles/scripts/create-links.sh
~/dotfiles/scripts/copy-fonts.sh

(cd ~/dotfiles && git submodule update --init)
(cd ~/dotfiles && git submodule foreach git pull origin master)
