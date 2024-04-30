#!/usr/bin/env bash
profile=~/.nix-profile/etc/profile.d/nix.sh

install_source=https://nixos.org/nix/install
mirror_ustc=https://mirrors.ustc.edu.cn
mirror_bfsu=https://mirrors.bfsu.edu.cn
mirror_nju=https://mirror.nju.edu.cn
mirror_iscas=https://mirror.iscas.ac.cn
channel=nixpkgs-unstable

curl --connect-timeout 5 $mirror_ustc >/dev/null
ustc_reachable=$?
curl --connect-timeout 5 $mirror_bfsu >/dev/null
bfsu_reachable=$?
curl --connect-timeout 5 $mirror_nju >/dev/null
nju_reachable=$?
curl --connect-timeout 5 $mirror_iscas >/dev/null
iscas_reachable=$?
curl --connect-timeout 5 https://nixos.org/ >/dev/null
nix_reachable=$?

echo "---Connection Status---"
echo "USTC: $ustc_reachable"
echo "BFSU: $bfsu_reachable"
echo "NJU: $nju_reachable"
echo "ISCAS: $iscas_reachable"
echo "NIX: $nix_reachable"

if [[ "$nix_no_mirror" ]]; then
    echo "wont use mirror"
elif [[ "$nix_mirror" ]]; then
    selected_mirror=$nix_mirror
elif [[ "$bfsu_reachable" == "0" ]]; then
    selected_mirror=$mirror_bfsu
elif [[ "$ustc_reachable" == "0" ]]; then
    selected_mirror=$mirror_ustc
elif [[ "$nju_reachable" == "0" ]]; then
    selected_mirror=$mirror_nju
elif [[ "$iscas_reachable" == "0" ]]; then
    selected_mirror=$mirror_iscas
fi

if [ -f $profile ] && ! [ -x "$(command -v nix)" ]; then
    . $profile || true
fi

set -e
PATH=$PATH:/usr/sbin

if ! [ -x "$(command -v nix)" ]; then
    echo No nix found. Installing...
    if [ -x "$(command -v apk)" ]; then
        apk add xz curl bash shadow
    fi
    mkdir -p -m 0755 /nix
    if ! [ -x "$(command -v groupadd)" ]; then
        echo "groupadd command was required to run this script"
        exit
    fi
    groupadd nixbld -g 30000 || true
    for i in {1..10}; do
        useradd -c "Nix build user $i" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" "nixbld$i" || true
    done
    if ! [ -x "$(command -v xz)" ]; then
        if [ -f "/usr/bin/apt-get" ] && [ -f "/usr/bin/dpkg" ]; then
            apt-get update
            apt-get install xz-utils -y
        else
            echo "xz command was required to run this script"
            exit
        fi
    fi
    if [ -f "/snap/bin/curl" ]; then # Not compatible with snap curl
        snap remove curl || true
        if [ -f "/usr/bin/apt-get" ] && [ -f "/usr/bin/dpkg" ]; then
            apt-get update
            apt-get install curl -y
        elif ! [ -x "$(command -v wget)" ]; then
            echo "please install wget or curl, without snap."
            exit
        fi
    fi
    [[ -z "$selected_mirror" ]] || install_source=$selected_mirror/nix/latest/install
    [[ -z "$nix_install_source" ]] || install_source=$nix_install_source
    sh <(curl -L $install_source) --no-daemon --no-channel-add
    echo ". $profile" >>~/.bashrc
    [[ -f ~/.zshrc ]] && echo ". $profile" >>~/.zshrc
    . $profile
    mkdir -p /etc/nix
fi

if [[ -z "$nix_no_mirror" ]]; then
    echo "substituters = $mirror_bfsu/nix-channels/store $mirror_ustc/nix-channels/store $mirror_nju/nix-channels/store $mirror_iscas/nix-channels/store https://nix-bin.hydro.ac/" >/etc/nix/nix.conf    
fi
echo "trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydro.ac:EytfvyReWHFwhY9MCGimCIn46KQNfmv9y8E2NqlNfxQ=" >>/etc/nix/nix.conf
echo "connect-timeout = 10" >>/etc/nix/nix.conf
echo "experimental-features = nix-command flakes" >>/etc/nix/nix.conf
if ! [ "$(nix-channel --list | grep nixpkgs)" ]; then
    if [[ -z "$selected_mirror" ]]; then
        nix-channel --add https://nixos.org/channels/$channel nixpkgs
    else
        nix-channel --add $selected_mirror/nix-channels/$channel nixpkgs
    fi
fi
nix-channel --add https://nix-channel.hydro.ac/ hydro
echo "Now unpacking channel. might take a long time."
echo "You can safely ignore the 'installing Nix as root is not supported by this script' error above."
nix-channel --update
mkdir -p ~/.config/nixpkgs

set +e
