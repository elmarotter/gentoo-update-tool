#!/bin/bash
source /etc/profile
export EIX_COLOR=always
#set -euo pipefail

LOGFILE="$HOME/.local/share/log/update_script.log"
mkdir -p "$(dirname "$LOGFILE")"
exec > >(stdbuf -i0 -oL -eL tee -a "$LOGFILE") 2>&1

#trap 'sudo umount -l /boot 2>/dev/null || true' EXIT

run_sudo() {
    sudo /bin/sh -c "$*"
}

run_eix-test-obsolete() {
	eix-test-obsolete
}
eclean_kernel() {
    run_sudo "mount /boot && eclean-kernel -n 1 && umount -l /boot"
}

eix_sync() {
    run_sudo "eix-sync"
    #run_sudo "TERM=xterm-256color eix-sync --color=yes"
}

installed() {
    emerge --color=y -epv @world | awk -F'] ' '/^\[/{print $2}' | sort | less -R
}

update_bin() {
    run_sudo "mount /boot && emerge --color=y -aDkNuvg --with-bdeps=y --backtrack=3000 --keep-going --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @world && umount -l /boot"
}

update() {
    run_sudo "mount /boot && emerge --color=y -aDNuv --with-bdeps=y --backtrack=3000 --keep-going @world && umount -l /boot"
}

clean() {
    run_sudo "mount /boot && emerge --color=y -acv && eclean packages && umount -l /boot"
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
    run_sudo "mount /boot && FEATURES='-getbinpkg' emerge --color=y -eDNv --usepkg=n @system && umount -l /boot"
}

rebuild_world() {
    run_sudo "mount /boot && FEATURES='-getbinpkg' emerge --color=y -eDNv --usepkg=n @world && umount -l /boot"
}

rebuild_system_world() {
    rebuild_system && rebuild_system && rebuild_world
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
    "Doe de eix-test-obsolete"
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
            8) run_eix-test-obsolete; break ;;
            9) dispatch_conf; break ;;
            10) rebuild_system; break ;;
            11) rebuild_world; break ;;
            12) rebuild_system_world; break ;;
            13) show_news; break ;;
            14) show_all_news; break ;;
            15) perl_cleaner_all; break ;;
            16) perl_cleaner_reallyall; break ;;
            17) eclean_dist; break ;;
            18) installed; break ;;
            19) echo "Tot ziens!"; exit 0 ;;
            *) echo "Ongeldige optie: $REPLY" >&2 ;;
        esac
    done
done


#eof
