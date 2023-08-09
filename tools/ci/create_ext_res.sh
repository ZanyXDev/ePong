#!/bin/bash

set -Eeuxo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

pushd .
trap "popd" EXIT HUP INT QUIT TERM

CUR_GIT_ROOT=$(git rev-parse --show-toplevel)

RCC="$1/bin/rcc"

MANIFEST=$CUR_GIT_ROOT/android/AndroidManifest.xml

EXT_RES=$CUR_GIT_ROOT/ext_res.qrc

GEN_DIR=$CUR_GIT_ROOT/build/generated_files

if [ ! -f $RCC ]; then
	echo error: $RCC not found
	exit 1
fi

if [ ! -f $MANIFEST ]; then
	echo error: $MANIFEST not found
	exit 1
fi

if [ ! -f $EXT_RES ]; then
	echo error: $EXT_RES not found
	exit 1
fi

if [ "x" = "x$(which xmlstarlet)" ]; then
	echo "error: xmlstarlet not found."
	echo "	     install it by 'sudo apt install xmlstarlet'"
	exit 1
fi

mkdir -p $GEN_DIR
 
VERSION_NAME=$(xmlstarlet sel -t -v manifest/@android:versionName < $MANIFEST)
VERSION_CODE=$(xmlstarlet sel -t -v manifest/@android:versionCode < $MANIFEST)
PACKAGE_NAME=$(xmlstarlet sel -t -v manifest/@package < $MANIFEST)
ACTIVITY_NAME=$(xmlstarlet sel -t -v manifest/application/activity/@android:name < $MANIFEST)

echo $VERSION_NAME > $CUR_GIT_ROOT/version.txt
echo $PACKAGE_NAME > $CUR_GIT_ROOT/package_name.txt
$RCC -binary $EXT_RES -o $GEN_DIR/main.$VERSION_CODE.$PACKAGE_NAME.obb

popd >& /dev/null





