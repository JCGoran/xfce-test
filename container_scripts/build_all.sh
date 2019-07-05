#!/usr/bin/env bash

XFCE_BASE=git://git.xfce.org

# (BRANCH URL NAME) tuples:
REPOS=( "xfce-4.14pre2 ${XFCE_BASE}/xfce/libxfce4ui libxfce4ui")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/libxfce4util libxfce4util")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/exo exo")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-dev-tools xfce4-dev-tools")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-panel xfce4-panel")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/garcon garcon")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/thunar thunar")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/thunar-volman thunar-volman")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-power-manager xfce4-power-manager")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-settings xfce4-settings")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-session xfce4-session")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfconf xfconf")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfdesktop xfdesktop")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfwm4 xfwm4")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/xfce4-appfinder xfce4-appfinder")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/xfce/tumbler tumbler")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/apps/xfce4-terminal xfce4-terminal")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/apps/xfce4-screenshooter xfce4-screenshooter")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/panel-plugins/xfce4-whiskermenu-plugin xfce4-whiskermenu-plugin")
REPOS+=("xfce-4.14pre2 ${XFCE_BASE}/panel-plugins/xfce4-clipman-plugin xfce4-clipman-plugin")


for tuple in "${REPOS[@]}"; do
    set -- $tuple
    BRANCH=$1
    URL=$2
    NAME=$3
    echo "--- Building $NAME ($BRANCH) ---"
    cd /git
    git clone $URL
    cd $NAME
    git checkout $BRANCH || echo "Branch $BRANCH not found - leaving default"
    ./autogen.sh $AUTOGEN_OPTIONS
    make -j8
    make install
    echo "$(pwd): $(git describe)" >> ~xfce-test_user/version_info.txt
done

