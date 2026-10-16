#!/bin/bash

chmod +x configure

if [ "$(uname)" == "Darwin" ];
then
    ./configure --prefix=$PREFIX --with-pic --enable-cxx --build=x86_64-apple-darwin
else
    ./configure --prefix=$PREFIX --with-pic --enable-cxx --enable-fat
fi

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
make check -j${CPU_COUNT}
fi
make install
