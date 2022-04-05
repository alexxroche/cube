#!/bin/sh
# install.sh ver. 20220405212346 Copyright 2022 alexx, MIT License
# RDFa:deps="[curl b2sum|sha256sum]"
usage(){ echo "Usage: $(basename $0) [-h]\n\t -h This help message"; exit 0;}
[ "$1" ]&& echo "$1"|grep -q '\-h' && usage

mkdir -p ~/.local/bin 2>/dev/null
cd ~/.local/bin
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/hash.blake2 -o .cube.b2 && \
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/hash.sha256 -o .cube.sha256 && \
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/cube -o cube && \
chmod 0555 "./cube" && \
chmod 0444 "./.cube.b2" "./.cube.sha256" && \
[ "$(which b2sum)" ] && $(which b2sum|head -n1) -c "./.cube.b2" && "./cube" \
|| { 
    sha256sum -c "./.cube.sha256" && \
    echo "[i] borg cube has been assimilated" && \
    "./cube" || \
    echo "[e] cube hashes failed. Investigate BEFORE use! [possibly corrupted]" >&2
}

