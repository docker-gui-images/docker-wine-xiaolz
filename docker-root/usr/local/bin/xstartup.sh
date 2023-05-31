#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export XMODIFIERS=@im=fcitx
fcitx &

if [ -x /etc/X11/xinit/xinitrc ]; then
  exec /etc/X11/xinit/xinitrc
fi
if [ -f /etc/X11/xinit/xinitrc ]; then
  exec sh /etc/X11/xinit/xinitrc
fi

[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
