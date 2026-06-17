import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "com.gounderpressurepa.app",
  appName: "Under Pressure Services",
  webDir: "www",
  server: {
    url: "https://gounderpressurepa.com",
    cleartext: false,
    androidScheme: "https",
    iosScheme: "https",
  },
  android: {
    allowMixedContent: false,
    captureInput: true,
    webContentsDebuggingEnabled: false,
  },
  ios: {
    contentInset: "automatic",
    scrollEnabled: true,
  },
  plugins: {
    App: {
      launchUrl: "https://gounderpressurepa.com",
    },
    SplashScreen: {
      launchShowDuration: 2000,
      launchAutoHide: true,
      backgroundColor: "#ffffff",
      showSpinner: false,
    },
    StatusBar: {
      style: "LIGHT",
      backgroundColor: "#243456",
    },
  },
};

export default config;
