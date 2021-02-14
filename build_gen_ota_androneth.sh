#!/bin/bash
##
# Bash sheebang is mandatory (for build scripts)
##

. ./build/make/envsetup_androneth.sh

# Build android and otatools
time mka target-files-package otatools

croot

VERSION_DATE="$(date +"%+4Y%m%d")"
mkdir -p "${ANDRONETH_BASE_OUTDIR}/${VERSION_DATE}"
ln -s -r -f -n "${ANDRONETH_BASE_OUTDIR}/${VERSION_DATE}" "${ANDRONETH_BASE_OUTDIR}/latest"

OUTDIR="${ANDRONETH_BASE_OUTDIR}/${VERSION_DATE}"

printf -- "Sign target files APKS\n"

./build/tools/releasetools/sign_target_files_apks -o \
    -d "${ANDRONETH_KEY_PATH}" \
    ${OUT}/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip \
    ${OUTDIR}/signed-target_files.zip

printf -- "Generate OTA from target files\n"

./build/tools/releasetools/ota_from_target_files \
    -k "${ANDRONETH_KEY_PATH}/releasekey" \
    --block --backup=true \
    ${OUTDIR}/signed-target_files.zip \
    ${OUTDIR}/lineage-17.1-${VERSION_DATE}-Androneth-ota_update.zip

printf -- "Done, OTA ready here : '%s'\n" "$(realpath ${OUTDIR}/lineage-17.1-${VERSION_DATE}-Androneth-ota_update.zip)"

printf -- "----------------------\n"
printf -- "NOTE:\n"
printf -- "If you are about to updating from another ROM with different keys, you need to run key-migration script before flashing!\n"
printf -- "Androneth migration script is ready to switch from LineageOS testkey to Androneth official key\n"
printf -- "Available here : '%s'\n" "$(realpath lineage/scripts/androneth-key-migration.sh)"
printf -- "Note: You must run it on Android (with 'stop') before going to recovery\n"
printf -- "----------------------\n"

exit 0
