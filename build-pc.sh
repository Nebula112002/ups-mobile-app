#!/bin/sh
# Build a debug APK on your PC (macOS/Linux). For Windows, use Git Bash or WSL.
set -eu

cd "$(dirname "$0")"

if ! command -v npm >/dev/null 2>&1; then
  echo "Install Node.js 20+ first: https://nodejs.org/" >&2
  exit 1
fi

if [ -z "${ANDROID_HOME:-}" ] && [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [ -z "${ANDROID_HOME:-}" ] && [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
fi

if [ -n "${ANDROID_HOME:-}" ]; then
  echo "sdk.dir=$ANDROID_HOME" > android/local.properties
fi

npm install
npx cap sync android

cd android
./gradlew assembleDebug

APK="app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK" ]; then
  echo ""
  echo "Built: android/$APK"
  ls -lh "$APK"
else
  echo "Build finished but APK not found at $APK" >&2
  exit 1
fi
