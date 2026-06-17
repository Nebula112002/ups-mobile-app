#!/bin/sh
set -e
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/java-17-openjdk}"
export PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME="${ANDROID_HOME:-/mnt/warehouse/opt/android-sdk}"
export GRADLE_OPTS="-Xmx512m -XX:MaxMetaspaceSize=128m -XX:+UseSerialGC"
ROOT="/mnt/warehouse/opt/web-tunnel"
LOG="/tmp/ups-apk-build.log"

STOPPED=""
for c in homeassistant homepage uptime-kuma pihole beszel beszel-agent \
  web-tunnel-nginx-1 web-tunnel-ups-backend-1 web-tunnel-cloudflared-1; do
  if docker stop "$c" 2>/dev/null; then
    STOPPED="$STOPPED $c"
  fi
done

{
  echo "=== UPS APK build $(date -Iseconds) ==="
  free -m | head -2
  cd "$ROOT/mobile-app"
  npm install --silent 2>/dev/null || npm install
  npx cap sync android
  echo "sdk.dir=$ANDROID_HOME" > android/local.properties
  cd android
  ./gradlew --stop 2>/dev/null || true
  ./gradlew assembleDebug --no-daemon --max-workers=1
  APK=$(find app/build/outputs/apk/debug -name "*.apk" | head -1)
  if [ -z "$APK" ]; then
    echo "BUILD_FAIL: no APK found"
    exit 1
  fi
  mkdir -p "$ROOT/html/downloads"
  cp "$APK" "$ROOT/html/downloads/UPS.apk"
  ls -lh "$ROOT/html/downloads/UPS.apk"
  echo "BUILD_OK"
} 2>&1 | tee "$LOG"

for c in $STOPPED; do
  docker start "$c" 2>/dev/null || true
done
docker compose --profile email -f "$ROOT/docker-compose.yml" up -d email-filer 2>/dev/null || true
