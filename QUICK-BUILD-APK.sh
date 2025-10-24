#!/bin/bash

# ================================================================
# SABIHIRIDES - AUTOMATED APK BUILD SCRIPT
# ================================================================
# This script automates the entire APK build process
# Just run: bash QUICK-BUILD-APK.sh
# ================================================================

echo "🚀 SabihiRides APK Builder"
echo "================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "📥 Please download and install Node.js from: https://nodejs.org/"
    echo "   Download the LTS version, install it, then run this script again."
    exit 1
fi

echo "✅ Node.js is installed: $(node --version)"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found!"
    echo "📁 Please run this script from the SabihiRides project folder"
    exit 1
fi

echo "✅ Found package.json"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo "✅ Dependencies installed"
echo ""

# Install EAS CLI globally
echo "📥 Installing EAS CLI..."
npm install -g eas-cli

if [ $? -ne 0 ]; then
    echo "❌ Failed to install EAS CLI"
    exit 1
fi

echo "✅ EAS CLI installed"
echo ""

# Check if user is logged in to Expo
echo "🔐 Checking Expo login status..."
if ! eas whoami &> /dev/null; then
    echo "⚠️  You're not logged in to Expo"
    echo "Please login (or create a free account):"
    eas login
    
    if [ $? -ne 0 ]; then
        echo "❌ Login failed"
        exit 1
    fi
fi

echo "✅ Logged in as: $(eas whoami)"
echo ""

# Configure EAS Build (if not already configured)
if [ ! -f "eas.json" ]; then
    echo "⚙️  Configuring EAS Build..."
    eas build:configure -p android
    
    if [ $? -ne 0 ]; then
        echo "❌ Failed to configure EAS Build"
        exit 1
    fi
    
    echo "✅ EAS Build configured"
    echo ""
fi

# Create app.json if it doesn't exist
if [ ! -f "app.json" ]; then
    echo "📝 Creating app.json configuration..."
    cat > app.json << 'EOF'
{
  "expo": {
    "name": "SabihiRides",
    "slug": "sabihirides",
    "version": "1.0.0",
    "orientation": "portrait",
    "userInterfaceStyle": "light",
    "android": {
      "package": "com.sabihirides.app",
      "versionCode": 1
    }
  }
}
EOF
    echo "✅ app.json created"
    echo ""
fi

# Build the APK!
echo "🏗️  Starting APK build..."
echo "⏱️  This will take 15-20 minutes"
echo "☕ Grab a coffee while Expo builds your app in the cloud!"
echo ""
echo "Building..."

eas build -p android --profile preview

if [ $? -ne 0 ]; then
    echo "❌ Build failed"
    echo "💡 Try running: eas build:list to see build status"
    exit 1
fi

echo ""
echo "🎉 SUCCESS! Your APK is ready!"
echo ""
echo "📱 Next steps:"
echo "1. Look for the download link above (starts with https://expo.dev/...)"
echo "2. Open that link on your Android phone's browser"
echo "3. Download the APK file"
echo "4. Install it (you may need to enable 'Unknown Sources' in settings)"
echo "5. Open the SabihiRides app and test!"
echo ""
echo "✅ Build complete!"

# Show build list
echo ""
echo "📋 Your recent builds:"
eas build:list --limit=3
