#! /bin/bash

export TOOLCHAINS=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64

export SYSROOT=$TOOLCHAINS/sysroot

export API=22

function build_ffmpeg(){
    CROSS_PREFIX=$TOOLCHAINS/bin/$TARGET
 
    echo "### configure ffmpeg for android $ARCH"

    ./configure  \
        --prefix=./android/$CPU \
        --enable-small \
        --disable-programs \
        --disable-avdevice \
        --disable-encoders \
        --disable-yasm \
       	--disable-neon \
    --disable-everything \
    --disable-asm \
    --disable-symver \
    --enable-gpl \
    --disable-doc \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffmpeg \
    --disable-muxers \
    --disable-stripping \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --enable-pic \
    --host-os=linux \
    --disable-static \
    --enable-shared \
    --enable-cross-compile \
    --cross-prefix=$CROSS_PREFIX- \
    --toolchain=llvm-cov  \
    --cc=$CROSS_PREFIX$API-clang \
    --cxx=$CROSS_PREFIX$API-clang++ \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic" 
    

echo "### compile ffmpeg for android $ARCH"

make clean     
make  -j4
make install

echo "### end compile ffmpeg for android $ARCH"
}

    
# for armv7a
ARCH=arm
CPU=armv7-a
TARGET=armv7a-linux-androideabi
build_ffmpeg

#for arm64
ARCH=arm64
CPU=armv8-a
TARGET=aarch64-linux-android
build_ffmpeg

# for x86 
ARCH=x86
CPU=x86
TARGET=i686-linux-android
build_ffmpeg

# for x86_64
ARCH=x86_64
CPU=x86_64
TARGET=x86_64-linux-android
build_ffmpeg


