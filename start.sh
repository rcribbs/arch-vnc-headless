#!/usr/bin/env bash

DEFAULT_VNC_PASSWORD="ArchTigerVNC"

# Add a custom xrandr resolution.
function addxrandr {
    local pixel_density
    local horiz
    local vert

    horiz=`cut -d'x' -f1 <<< $1`
    vert=`cut -d'x' -f2 <<< $1`

    pixel_density=`echo "scale=10;($horiz * $vert * 60) / 1000000" | bc`

    set -x
    xrandr --newmode $1 $pixel_density $horiz 0 0 $horiz $vert 0 0 $vert
    xrandr --addmode VNC-0 $1
}

# Read all the xrandr args (if they exist) from the environment and add them.
function _process_xrandr_env {
    local resolutions
    resolutions=$CUSTOM_RESOLUTIONS
    if [[ ! -z "$CUSTOM_RESOLUTIONS" ]]; then
        IFS=',' ; for res in `echo "$resolutions"`; do
            echo "Adding $res resolution..."
            (addxrandr $res)
        done
    fi
}

function _set_password {
    local password
    local pwdfile
    pwdfile=$HOME/.vnc/passwd

    password=$VNC_PASSWORD
    if [[ -z "$password" ]]; then
        password="$DEFAULT_VNC_PASSWORD"
    fi

    echo "$VNC_PASSWORD" | vncpasswd -f > $pwdfile
    chmod 600 $pwdfile
}

# Start up the vnc server and do setup.
function _start_vnc {
    _set_password

    vncserver

    _process_xrandr_env

    tail -f /root/.vnc/*.log
}

_start_vnc
