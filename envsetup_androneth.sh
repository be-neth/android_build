# Must be sourced!
export LC_ALL=C

. build/envsetup.sh

sudo touch /usr/lib/libncurses.so.5
sudo mount --bind prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/sysroot/usr/lib/libncurses.so.5 /usr/lib/libncurses.so.5

sudo touch /usr/lib/libtinfo.so.5
sudo mount --bind prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/sysroot/usr/lib/libtinfo.so.5 /usr/lib/libtinfo.so.5

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
ccache -o compression=true

export ANDRONETH_KEY_PATH="/home/beneth/devel/android/op7tpro_hotdog/android-certs"
export ANDRONETH_BASE_OUTDIR="/home/beneth/devel/android/op7tpro_hotdog/build"

breakfast hotdog
