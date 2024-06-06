#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

deps(){
    if ! [ -d "KindleUnpack" ]; then
      git clone https://github.com/kevinhendricks/KindleUnpack.git
    fi
    if ! [ -d "PocketBookDic" ]; then
      git clone git@github.com:ivy-rew/PocketBookDic.git
    fi
    sudo apt install -y dictzip stardict-tools
    pip3 install penelope
}

mobi=`ls input/*.mobi`
fBase=`basename "${mobi}"`
base=`echo "${fBase%.*}"`

unpacked="${DIR}/input/${base}/mobi7"
unlocal="${DIR}/PocketBookDic/input/${base}/mobi7"

convert(){
    # 1. Unpack *.mobi Dictionary; bought 4 Amazon Kindle
    if ! [ -d "${unpacked}" ]; then
      echo "unpacking mobie file ${mobi}"
      python3 ${DIR}/KindleUnpack/lib/kindleunpack.py "${mobi}" "input/${base}"
      mv -v "${unpacked}/book.html" "${unpacked}/${base}.html"
    fi

    cd "PocketBookDic"
    perl "pocketbookdic.pl" "../${mobi}"

#    # manually run stardict:
#    xml="/mnt/data/dev/_kobo/PocketBookDic/fr/pons/ponsFR/mobi7/ponsFR_reconstructed.xml"
#    ifo="/mnt/data/dev/_kobo/PocketBookDic/fr/pons/ponsFR/mobi7/ponsFR_reconstructed.ifo"
#    /usr/lib/stardict-tools/stardict-text2bin "${xml}" "${ifo}"
#
#
#    # manually remove special non utf-8 chars from 'xml'
#
#    # zip [.ifo|.idx|.dict.dz] into a single zip file as input for 'penelop'
#    zip ponsFRstardict.zip *.ifo *.idx *.dict.dz
#
#    # penelope: stardict > kobo
#    # > omit file extensions in input and output! (.zip is auto added)
#    penelope -i ../PocketBookDic/fr/pons/ponsFR/mobi7/ponsFRstardict -j stardict -f fr -t de -p kobo -o dicthtml-fr-de
}

convert

