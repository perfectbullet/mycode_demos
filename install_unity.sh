#!/bin/bash
# by feixueruge 2019.03.22
# test on ubunut 17.04
ROOT_PASSWORD="123456"
echo "Entern password for root user"
passwd root
# enter password for root
apt update
apt install vim
apt install unity

#config files
echo 'chang configfiles gdm-autologin gdm-autologin,gdm-password,profile'
CFGA=/etc/pam.d/gdm-autologin
CFGB=/etc/pam.d/gdm-password
# zhu shi diao am_succeed_if.so suo zai de hang    sed -i '/匹配字符串/s/替换源字符串/替换目标字符串/g' filename
sed -i /am_succeed_if.so/s/auth/#auth/g $CFGA
sed -i /pam_succeed_if.so/s/auth/#auth/g $CFGB

# change /root/.profile, mesg to tty -s && mesg
CFGC='/root/.profile'
sed -i 's/mesg/tty -s \&\& mesg/g' $CFGC
echo 'Finished change install unity, please restart.'
