#!/bin/bash
set -euo pipefail

LOGFILE="$HOME/.local/share/log/update_script.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(stdbuf -i0 -oL -eL tee -a "$LOGFILE") 2>&1

run_sudo() {
    sudo /bin/sh -c "$*"
}

eclean_kernel() {
    run_sudo "mount /boot && eclean-kernel -n 1 &&  unmount -l /boot"
}

eix_sync() {
     run_sudo "TERM=xterm-256color eix-sync --color=yes"
}

installed() {
    emerge --color=y -epv @world | awk -F'] ' '/^\[/{print $2}' | sort | less -R
}

update_bin() {
    run_sudo "mount /boot && emerge --color=y -aDkNuvg --with-bdeps=y --backtrack=3000 --keep-going --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @world && umount -l /boot"
    
}

update() {
    run_sudo "mount /boot && emerge --color=y -aDNuv --with-bdeps=y --backtrack=3000 --keep-going @world && unmount -l /boot"
}

clean() {
    run_sudo "mount /boot && emerge --color=y -acv && eclean packages && unmount -l /boot"
}

repair() {
    run_sudo "revdep-rebuild"
}

dispatch_conf() {
    run_sudo "dispatch-conf"
}

preserved_rebuild() {
    run_sudo "emerge --color=y -av @preserved-rebuild"
}

rebuild_system() {
    run_sudo "emerge --color=y -e --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @system"
}

rebuild_world() {
    run_sudo "emerge --color=y -e --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @world"
}

rebuild_system_world() {
    run_sudo "emerge --color=y -e --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @system && emerge --color=y -e --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @world"
}

show_news() {
    run_sudo "eselect news read"
}

show_all_news() {
    run_sudo "eselect news read all | less -R"
}

perl_cleaner_all() {
    run_sudo "perl-cleaner --all"
}

perl_cleaner_reallyall() {
    run_sudo "perl-cleaner --reallyall"
}

eclean_dist() {
    run_sudo "eclean-dist"
}

PS3="Kies een optie: "
options=(
    "Sync portage met eix-sync"
    "Update"
    "Update met binaries"
    "Clean"
    "Verwijder oude kernels"
    "@preserved-rebuild"
    "Check en herstel"
    "Update config-bestanden"
    "Herbouw systeem"
    "Herbouw wereld"
    "Herbouw systeem + wereld"
    "Toon nieuws"
    "Toon al het nieuws"
    "Perl cleaner all"
    "Perl cleaner reallyall"
    "Clean distfiles"
    "Toon geïnstalleerde pakketten"
    "Stoppen"
)

while true; do
    PS3="Kies een optie: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) eix_sync; break ;;
            2) update; break ;;
            3) update_bin; break ;;
            4) clean; break ;;
            5) eclean_kernel; break ;;
            6) preserved_rebuild; break ;;
            7) repair; break ;;
            8) dispatch_conf; break ;;
            9) rebuild_system; break ;;
            10) rebuild_world; break ;;
            11) rebuild_system_world; break ;;
            12) show_news; break ;;
            13) show_all_news; break ;;
            14) perl_cleaner_all; break ;;
            15) perl_cleaner_reallyall; break ;;
            16) eclean_dist; break ;;
            17) installed; break ;;
            18) echo "Tot ziens!"; exit 0 ;;
            *) echo "Ongeldige optie: $REPLY" >&2 ;;
        esac
    done
done


#eof
