#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

deps(){
    if ! [ -d "KindleUnpack" ]; then
      git clone https://github.com/kevinhendricks/KindleUnpack.git
    fi
    if ! [ -d "PocketBookDic" ]; then
      git clone git@github.com:ivy-rew/PocketBookDic.git
    fi
    
    # perl deps: 
    # -------------
    # alternative: 
    # https://stackoverflow.com/questions/19302025/cant-locate-xml-libxml-pm
    # perl -MCPAN -e shell
    # install XML::Tidy
    sudo cpan XML::Tidy

    sudo apt install -y dictzip stardict-tools
    pip3 install penelope
}

mobi=`ls input/*.mobi`
fBase=`basename "${mobi}"`
base=`echo "${fBase%.*}"`

unpacked="${DIR}/input/${base}/mobi7"

unpack(){
  # 1. Unpack *.mobi Dictionary; bought 4 Amazon Kindle
  if ! [ -d "${unpacked}" ]; then
    echo "unpacking mobie file ${mobi}"
    python3 ${DIR}/KindleUnpack/lib/kindleunpack.py "${mobi}" "input/${base}"
    mv -v "${unpacked}/book.html" "${unpacked}/${base}.html"
  fi
}

toXML(){
  cd "PocketBookDic"
  perl "pocketbookdic.pl" "../${mobi}"
  cd ".."
}

toStartdict(){
  echo "packing to 'startdict.ifo' format"
  recBase="${unpacked}/${base}_reconstructed"
  xml="${recBase}.xml"
  ifo="${recBase}.ifo"
  echo "==> if you face 'CDATA invalid char value' parser errors, remove these manually!!"
  echo "==> use VsCode search/replace: on ${xml}"
  /usr/lib/stardict-tools/stardict-text2bin "${xml}" "${ifo}"

  # zip [.ifo|.idx|.dict.dz] into a single zip file as input for 'penelop'
  cd "${unpacked}"
  ls -la
  zip "${base}_stardict.zip" "`ls *.ifo`" "`ls *.idx`" "`ls *.dict.dz`"
  cd ${DIR}
}

toKobo(){
  # penelope: stardict > kobo
  # > omit file extensions in input and output! (.zip is auto added)
  read -p "Enter from language (e.g. 'en'): " inLang
  read -p "Enter target language (e.g. 'de'): " outLang
  penelope -i "${unpacked}/${base}_stardict" -j stardict -f ${inLang} -t ${outLang} -p kobo -o dicthtml-${inLang}-${outLang}
}

convert(){
  deps
  unpack
  toXML
  # manually remove special non utf-8 chars from 'xml'
  toStartdict
  toKobo
}

convert
