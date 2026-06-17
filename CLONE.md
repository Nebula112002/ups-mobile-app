# Get this repo on your PC

## Option A — GitHub (recommended)

```bash
git clone https://github.com/Nebula112002/ups-mobile-app.git
cd ups-mobile-app
```

## Option B — Windows network share

Open in File Explorer:

```
\\10.0.0.250\UPS-Documents\ups-mobile-app
```

Or clone from the LAN share:

```bash
git clone "//10.0.0.250/UPS-Documents/ups-mobile-app" ups-mobile-app
cd ups-mobile-app
```

## Option C — Tailscale / SSH

```bash
scp -r root@100.89.204.12:/mnt/warehouse/backups/UPS/ups-mobile-app .
cd ups-mobile-app
```

## Then build

See [README.md](README.md) — you need Node.js 20+ and Android Studio.

**Windows (PowerShell):**

```powershell
.\build-pc.ps1
```

**macOS / Linux / Git Bash:**

```bash
./build-pc.sh
```

Debug APK: `android/app/build/outputs/apk/debug/app-debug.apk`
