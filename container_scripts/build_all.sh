#!/usr/bin/env bash

XFCE_BASE=git://git.xfce.org/xfce

# (BRANCH URL NAME) tuples:
REPOS=( "xfce-4.14pre1 ${XFCE_BASE}/xfce4-panel xfce4-panel")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/thunar thunar")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-settings xfce4-settings")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-session xfce4-session")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfdesktop xfdesktop")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfwm4 xfwm4")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-appfinder xfce4-appfinder")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/tumbler tumbler")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-terminal xfce4-terminal")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-whiskermenu-plugin xfce4-whiskermenu-plugin")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-clipman xfce4-clipman")
REPOS+=("xfce-4.14pre1 ${XFCE_BASE}/xfce4-screenshooter xfce4-screenshooter")

## TBD...
## Grab xfce4-dev-tools from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/xfce4-dev-tools \
#  && cd xfce4-dev-tools \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig

## Grab libxfce4util from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/libxfce4util \
#  && cd libxfce4util \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig

## Grab xfconf from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/xfconf \
#  && cd xfconf \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig

## Grab libxfce4ui from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/libxfce4ui \
#  && cd libxfce4ui \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig

## Grab garcon from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/garcon \
#  && cd garcon \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig

## Grab exo from master
#RUN cd git \
#  && git clone git://git.xfce.org/xfce/exo \
#  && cd exo \
#  && ./autogen.sh $AUTOGEN_OPTIONS \
#  && make \
#  && make install \
#  && echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt \
#  && ldconfig


for tuple in "${REPOS[@]}"; do
    set -- $tuple
    BRANCH=$1
    URL=$2
    NAME=$3
    echo "--- Building $NAME ---"
    cd /git
    git clone --branch $BRANCH $URL
    cd $NAME
    ./autogen.sh $AUTOGEN_OPTIONS
    make
    make install
    echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt
done

