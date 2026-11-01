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
    run_sudo "mount /boot && eclean-kernel -n 3 && umount -l /boot"
}

#eix_sync() {
#    run_sudo "eix-sync"
#    #run_sudo "TERM=xterm-256color eix-sync --color=yes"
#}

eix_sync() {
    exec 3>&1
    run_sudo "emaint sync -A > /dev/tty 2>&1 < /dev/tty"
    eix-diff > /dev/tty 2>&1 < /dev/tty
}

qlistamd64() {
    mapfile -t categories < <(
        qlist -IC | cut -d/ -f1 | sort -u
    )

    echo
    echo "Available categories:"
    echo

    select category in "${categories[@]}"; do
        [[ -n "$category" ]] || {
            echo "Invalid selection"
            continue
        }

        echo
        qlist -ICv "$category" \
            | sort -u \
            | sed 's/^/=/; s/$/ ~amd64/'
        echo
        break
    done
}

installed() {
    emerge --color=y -epv @world | awk -F'] ' '/^\[/{print $2}' | sort | less -R
}

update() {
    # Step 1: determine whether a new kernel is available
    latest=$(ls -1 /lib/modules | sort -V | tail -n1)
    current=$(uname -r)

    if [[ "$latest" != "$current" ]]; then
        echo "New kernel detected: $latest"
        rebuild_cmd="emerge @module-rebuild"
    else
        echo "No new kernel detected, skipping module rebuild"
        rebuild_cmd=":"
    fi

    # Step 2: build the complete sudo command as a single command string
    full_cmd="
        mount /boot &&
        emerge --color=y -aDNuv --with-bdeps=y --backtrack=30 --keep-going @world &&
        $rebuild_cmd &&
        umount -l /boot
    "

    # Step 3: execute everything in a single sudo session
    run_sudo "$full_cmd"
}

update_bin() {
    # Step 1: determine whether a new kernel is available
    latest=$(ls -1 /lib/modules | sort -V | tail -n1)
    current=$(uname -r)

    if [[ "$latest" != "$current" ]]; then
        echo "New kernel detected: $latest"
        rebuild_cmd="emerge @module-rebuild"
    else
        echo "No new kernel detected, skipping module rebuild"
        rebuild_cmd=":"
    fi

    # Step 2: build the complete sudo command as a single command string
    full_cmd="
        mount /boot &&
        emerge --color=y -aDkNuvg --with-bdeps=y --backtrack=30 --keep-going \
            --buildpkg-exclude 'sys-kernel/*-sources virtual/*' @world &&
        $rebuild_cmd &&
        umount -l /boot
    "

    # Step 3: execute everything in a single sudo session
    run_sudo "$full_cmd"
}

clean() {
    run_sudo "mount /boot && emerge --color=y -acv && eclean packages && umount -l /boot"
}

repair() {
    run_sudo "revdep-rebuild"
}

dispatch_conf() {
    exec 3>&1
    run_sudo "dispatch-conf > /dev/tty 2>&1 < /dev/tty"
}

preserved_rebuild() {
    run_sudo "emerge --color=y -av @preserved-rebuild"
}

#emerge @module-rebuild

rebuild_system() {
    run_sudo "mount /boot && FEATURES='-getbinpkg' emerge --color=y -eDNv --usepkg=n --keep-going @system && umount -l /boot"
}

rebuild_world() {
    run_sudo "mount /boot && FEATURES='-getbinpkg' emerge --color=y -eDNv --usepkg=n --keep-going @world && umount -l /boot"
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

PS3="Select an option: "

options=(
    "Sync Portage with eix-sync"
    "Update"
    "Update using binary packages"
    "Clean"
    "Remove old kernels"
    "@preserved-rebuild"
    "Check and repair"
    "Run eix-test-obsolete"
    "Update configuration files"
    "Rebuild system"
    "Rebuild world"
    "Rebuild system and world"
    "Show news"
    "Show all news"
    "Perl cleaner all"
    "Perl cleaner reallyall"
    "Clean distfiles"
    "Show installed packages"
    "Generate ~amd64 keywords by category"
    "Exit"
)

while true; do
    PS3="Select an option: "

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
            19) qlistamd64; break ;;
            20) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option: $REPLY" >&2 ;;
        esac
    done
done

#eof
