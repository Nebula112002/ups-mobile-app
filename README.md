# Under Pressure Services — Android App

Capacitor shell that loads **https://gounderpressurepa.com** as a native Android app.

| Field | Value |
|-------|-------|
| App name | Under Pressure Services |
| Package ID | `com.gounderpressurepa.app` |
| Website | https://gounderpressurepa.com |

Free distribution — no Google Play ($25) or Apple ($99) fees required unless you want store listings later.

---

## Build on your PC (Windows or Mac)

### Prerequisites

1. [Node.js 20+](https://nodejs.org/)
2. [Android Studio](https://developer.android.com/studio) (includes Android SDK + Java)

In Android Studio: **Settings → Languages & Frameworks → Android SDK** — install **Android SDK Platform 35** (or whatever `compileSdk` in `android/variables.gradle` specifies) and **Android SDK Build-Tools**.

### Steps

```bash
git clone <repo-url>
cd ups-mobile-app

npm install
npx cap sync android
```

Open in Android Studio (optional but easiest for signing):

```bash
npx cap open android
```

Then **Build → Build Bundle(s) / APK(s) → Build APK(s)**.

Or build from the command line:

```bash
cd android
./gradlew assembleDebug
```

**Debug APK** (for testing / sideload):

`android/app/build/outputs/apk/debug/app-debug.apk`

For a **release APK** you can share publicly, sign it once:

```bash
keytool -genkey -v -keystore ups-release.keystore -alias ups \
  -keyalg RSA -keysize 2048 -validity 10000
```

Then in Android Studio: **Build → Generate Signed Bundle / APK** → APK → select your keystore.

---

## Install on a phone (no store)

1. Copy the signed APK to your phone (USB, email, Google Drive, etc.)
2. On Android: **Settings → Security → Install unknown apps** → allow your file manager or browser
3. Open the APK and install

Optional: host the signed file as `UPS.apk` on the website at  
`https://gounderpressurepa.com/downloads/UPS.apk`

---

## Samsung Galaxy Store (free listing)

1. Register at [Samsung Seller Portal](https://seller.samsungapps.com/) — free
2. Upload your signed APK or AAB
3. Category: **Business** or **Utilities**

---

## iPhone (no App Store fee)

Use the website PWA instead:

1. Open https://gounderpressurepa.com in **Safari**
2. Share → **Add to Home Screen**

---

## Native features (APK / Galaxy Store only)

These run in the installed app, not in regular Chrome:

| Feature | What it does |
|---------|----------------|
| Camera button | “Take photo with camera” on quote forms |
| Android back button | Goes back in the app; exits on home page |
| Deep links | Opens paths like `quote-commercial.html` |

Website helper: `html/js/capacitor-app.js` on the live site.

---

## After changing plugins or config

```bash
npm install
npx cap sync android
```

Plugins: **Camera**, **App** (back + deep links), **SplashScreen**, **StatusBar**.

---

## Project layout

```
ups-mobile-app/
├── capacitor.config.ts   # loads gounderpressurepa.com
├── www/                  # minimal local shell
├── android/              # Android Studio / Gradle project
├── ios/                  # Xcode project (optional)
└── package.json
```
