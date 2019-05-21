#!/usr/bin/env bash

XFCE_BASE=git://git.xfce.org

# (BRANCH URL NAME) tuples:
REPOS=( "master ${XFCE_BASE}/xfce/xfce4-panel xfce4-panel")
REPOS+=("master ${XFCE_BASE}/xfce/thunar thunar")
REPOS+=("master ${XFCE_BASE}/xfce/xfce4-settings xfce4-settings")
REPOS+=("master ${XFCE_BASE}/xfce/xfce4-session xfce4-session")
REPOS+=("master ${XFCE_BASE}/xfce/xfdesktop xfdesktop")
REPOS+=("master ${XFCE_BASE}/xfce/xfwm4 xfwm4")
REPOS+=("master ${XFCE_BASE}/xfce/xfce4-appfinder xfce4-appfinder")
REPOS+=("master ${XFCE_BASE}/xfce/tumbler tumbler")
REPOS+=("master ${XFCE_BASE}/apps/xfce4-terminal xfce4-terminal")
REPOS+=("master ${XFCE_BASE}/apps/xfce4-screenshooter xfce4-screenshooter")
REPOS+=("master ${XFCE_BASE}/panel-plugins/xfce4-whiskermenu-plugin xfce4-whiskermenu-plugin")
REPOS+=("master ${XFCE_BASE}/panel-plugins/xfce4-clipman-plugin xfce4-clipman-plugin")

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
    echo "--- Building $NAME ($BRANCH) ---"
    cd /git
    git clone --branch $BRANCH $URL
    cd $NAME
    ./autogen.sh $AUTOGEN_OPTIONS
    make
    make install
    echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt
done

