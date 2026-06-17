# Get this repo on your PC

The project lives on your Warehouse server in the UPS-Documents share.

## Option A — Windows Explorer (easiest)

Open in File Explorer:

```
\\10.0.0.250\UPS-Documents\ups-mobile-app
```

Copy the whole `ups-mobile-app` folder to your PC (e.g. `C:\dev\ups-mobile-app`).

## Option B — Git clone over the network share

From Git Bash or PowerShell on your PC (on the same LAN as `10.0.0.250`):

```bash
git clone "//10.0.0.250/UPS-Documents/ups-mobile-app" ups-mobile-app
cd ups-mobile-app
```

## Option C — Tailscale / SSH (if you use Tailscale)

```bash
scp -r root@100.89.204.12:/mnt/warehouse/backups/UPS/ups-mobile-app .
cd ups-mobile-app
```

## Then build

See [README.md](README.md) — you need Node.js 20+ and Android Studio.

Quick start:

```bash
npm install
npx cap sync android
cd android
./gradlew assembleDebug
```

Debug APK: `android/app/build/outputs/apk/debug/app-debug.apk`
