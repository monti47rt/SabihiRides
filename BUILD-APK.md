# 📱 Build APK for SabihiRides

Complete step-by-step guide to build a real, installable APK file for your Android phone.

---

## 🚀 Quick Start (Estimated Time: 25 minutes)

### Prerequisites

Before starting, you need:
1. **Computer** (Windows, Mac, or Linux)
2. **Internet connection** (for downloading and building)
3. **Expo account** (free - you'll create one during setup)

---

## 📋 Step-by-Step Instructions

### Step 1: Install Node.js (5 minutes)

**Download Node.js:**
- Go to: https://nodejs.org/
- Download the **LTS version** (Long Term Support)
- Run the installer and follow the prompts
- Restart your computer after installation

**Verify installation:**
Open Terminal (Mac/Linux) or Command Prompt (Windows) and type:
```bash
node --version
npm --version
```
You should see version numbers (e.g., v20.x.x and 10.x.x)

---

### Step 2: Clone This Repository (2 minutes)

**Option A: Using Git (Recommended)**
```bash
# Open Terminal/Command Prompt
# Navigate to where you want the project
cd Desktop

# Clone the repository
git clone https://github.com/monti47rt/SabihiRides.git

# Enter the project folder
cd SabihiRides
```

**Option B: Download ZIP**
1. Go to: https://github.com/monti47rt/SabihiRides
2. Click the green "Code" button
3. Click "Download ZIP"
4. Extract the ZIP file
5. Open Terminal/Command Prompt in that folder

---

### Step 3: Install Dependencies (3 minutes)

```bash
# Make sure you're in the SabihiRides folder
# Install all required packages
npm install
```

Wait for all packages to download and install.

---

### Step 4: Install EAS CLI (1 minute)

```bash
# Install Expo Application Services CLI globally
npm install -g eas-cli
```

---

### Step 5: Create Expo Account & Login (2 minutes)

```bash
# Login to Expo (or create account)
eas login
```

You'll be prompted to:
- **If you have an account:** Enter your username/email and password
- **If you don't:** Follow the prompts to create a free account

---

### Step 6: Configure EAS Build (1 minute)

```bash
# Initialize EAS Build configuration
eas build:configure
```

Press **Enter** when prompted to accept defaults.

---

### Step 7: Create app.json Configuration (2 minutes)

**Create a file named `app.json` in the root folder with this content:**

```json
{
  "expo": {
    "name": "SabihiRides",
    "slug": "sabihirides",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "light",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#FF6B35"
    },
    "android": {
      "package": "com.sabihirides.app",
      "versionCode": 1,
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#FF6B35"
      }
    },
    "plugins": [],
    "extra": {
      "eas": {
        "projectId": "your-project-id-will-be-added-automatically"
      }
    }
  }
}
```

**Note:** If `app.json` already exists, just verify it has the android section.

---

### Step 8: Build the APK! (15-20 minutes)

```bash
# Build APK for Android
eas build -p android --profile preview
```

**What happens now:**
1. ✅ Your code is uploaded to Expo's build servers
2. ✅ Expo builds your APK in the cloud (this takes 15-20 minutes)
3. ✅ You'll get a **download link** when it's done

**During the build, you'll be asked:**
- "Generate a new Android Keystore?" → Press **Y** (Yes)
- Wait for the build to complete...

---

### Step 9: Download & Install APK (2 minutes)

**When build completes:**

1. **You'll see a link** in the terminal like:
   ```
   ✔ Build finished
   https://expo.dev/accounts/yourname/projects/sabihirides/builds/abc123
   ```

2. **Open this link** on your Android phone's browser

3. **Download the APK** file

4. **Install it:**
   - Your phone may warn "Install from Unknown Sources"
   - Go to Settings → Security → Enable "Unknown Sources" or "Install Unknown Apps"
   - Tap the downloaded APK file
   - Tap "Install"

5. **Open the app** and test!

---

## 🎉 Success!

You now have a real, installable SabihiRides APK on your phone!

---

## 📱 Alternative: Quick Test with Expo Go (No APK Build)

If you want to test IMMEDIATELY without building APK:

```bash
# After Step 3 (npm install), run:
npx expo start
```

Then:
1. Download **Expo Go** app from Play Store
2. Scan the QR code that appears
3. App loads instantly!

---

## ❓ Troubleshooting

### "command not found: eas"
```bash
# Reinstall EAS CLI
npm install -g eas-cli

# Or use npx
npx eas-cli build -p android --profile preview
```

### "Build failed"
- Check your internet connection
- Make sure `app.json` is correctly formatted
- Try running: `eas build:configure` again

### "Can't install APK"
- Enable "Install from Unknown Sources" in phone settings
- Make sure you downloaded the `.apk` file (not `.aab`)

### Need help?
- Expo Documentation: https://docs.expo.dev/build/setup/
- Expo Discord: https://chat.expo.dev/

---

## 🔄 Rebuild APK (After Making Changes)

Whenever you update the code:

```bash
# Commit your changes to GitHub first
git add .
git commit -m "Updated app"
git push

# Build new APK
eas build -p android --profile preview
```

---

## 📦 Build Progress

You can check build status at any time:
```bash
eas build:list
```

Or visit: https://expo.dev/accounts/[your-username]/projects/sabihirides/builds

---

## 🎯 Next Steps

- ✅ Test the app thoroughly on your phone
- ✅ Add your Google Maps API key (in `App.js`)
- ✅ Configure payment gateways (Cliq, Visa, etc.)
- ✅ Connect to your backend server
- ✅ Add driver database

---

## 📝 Notes

- **First build takes 20-25 minutes** (subsequent builds are faster)
- **APK file will be ~50-80 MB** in size
- **Free Expo accounts** get limited builds per month
- **This is a development APK** - for production/Play Store, use production builds

---

**Ready to build? Start with Step 1!** 🚀
