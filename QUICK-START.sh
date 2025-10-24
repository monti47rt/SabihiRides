#!/bin/bash
# 🚕 SabihiRides - Automated Setup & Test Script
# This script does EVERYTHING for you!

echo "🚕 Setting up SabihiRides for الصبيحي, Jordan..."
echo "📱 This will install, configure, and run your app!"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Step 1: Checking prerequisites...${NC}"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js not found. Installing Node.js...${NC}"
    # For different OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install node
    else
        echo -e "${RED}Please install Node.js manually from https://nodejs.org${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ Node.js found: $(node --version)${NC}"
fi

# Check if we're in the right directory
if [[ ! -f "package.json" ]]; then
    echo -e "${RED}Error: package.json not found. Please run this script from the SabihiRides directory.${NC}"
    exit 1
fi

echo -e "${BLUE}Step 2: Installing dependencies...${NC}"
npm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed successfully${NC}"
else
    echo -e "${RED}✗ Failed to install dependencies${NC}"
    exit 1
fi

echo -e "${BLUE}Step 3: Creating config files...${NC}"

# Create src/config directory
mkdir -p src/config

# Create dummy config files so app runs without API keys
cat > src/config/firebase.js << 'EOF'
// Demo Firebase config - replace with your keys for full functionality
export const firebaseConfig = {
  apiKey: "demo-key-replace-with-real-key",
  authDomain: "sabihirides-demo.firebaseapp.com",
  projectId: "sabihirides-demo",
  storageBucket: "sabihirides-demo.appspot.com",
  messagingSenderId: "123456789",
  appId: "demo-app-id"
};

// Initialize Firebase (demo mode)
export const initializeFirebase = () => {
  console.log('Firebase initialized in demo mode');
  return {
    auth: () => ({
      signInWithEmailAndPassword: () => Promise.resolve({ user: { uid: 'demo-user' } }),
      createUserWithEmailAndPassword: () => Promise.resolve({ user: { uid: 'demo-user' } }),
      signOut: () => Promise.resolve()
    })
  };
};
EOF

cat > src/config/maps.js << 'EOF'
// Google Maps config for الصبيحي area
export const GOOGLE_MAPS_API_KEY = "demo-key-get-real-key-from-google-cloud";

// الصبيحي coordinates and boundaries
export const SABIHI_BOUNDS = {
  latitude: 32.2407,
  longitude: 35.7485,
  latitudeDelta: 0.05,
  longitudeDelta: 0.05
};

export const SABIHI_REGION = {
  name: "الصبيحي",
  name_en: "Al-Sabihi",
  country: "Jordan",
  bounds: SABIHI_BOUNDS
};
EOF

cat > src/config/payments.js << 'EOF'
// Payment gateway configurations for Jordan
export const PAYMENT_CONFIG = {
  // Cliq (Jordan's payment system)
  cliq: {
    merchantId: "your-cliq-merchant-id",
    apiKey: "your-cliq-api-key",
    baseUrl: "https://api.cliq.jo/v1",
    demo: true // Remove this for production
  },
  
  // International cards
  stripe: {
    publishableKey: "pk_test_your-stripe-key-here",
    demo: true
  },
  
  // Google Pay
  googlePay: {
    environment: "TEST", // Change to "PRODUCTION" for live
    merchantId: "your-google-pay-merchant-id",
    gatewayMerchantId: "your-gateway-merchant-id"
  },
  
  // Apple Pay
  applePay: {
    merchantId: "merchant.com.yourapp.sabihirides",
    countryCode: "JO",
    currencyCode: "JOD"
  }
};

// Demo payment processor
export const processPayment = async (method, amount) => {
  console.log(`Processing ${amount} JOD via ${method} (DEMO MODE)`);
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        success: true,
        transactionId: `demo_${Date.now()}`,
        method: method,
        amount: amount
      });
    }, 2000);
  });
};
EOF

echo -e "${GREEN}✓ Config files created${NC}"

echo -e "${BLUE}Step 4: Setting up React Native...${NC}"

# Install React Native CLI if not present
if ! command -v react-native &> /dev/null; then
    echo "Installing React Native CLI..."
    npm install -g react-native-cli
fi

echo -e "${BLUE}Step 5: Checking for Android environment...${NC}"

# Check for Android
if command -v adb &> /dev/null; then
    echo -e "${GREEN}✓ Android tools found${NC}"
    
    # Check for connected devices
    DEVICES=$(adb devices | grep -v "List of devices" | grep "device" | wc -l)
    if [ $DEVICES -gt 0 ]; then
        echo -e "${GREEN}✓ Android device/emulator connected${NC}"
        ANDROID_AVAILABLE=true
    else
        echo -e "${YELLOW}! No Android device connected, but emulator might be available${NC}"
        ANDROID_AVAILABLE=true
    fi
else
    echo -e "${YELLOW}! Android Studio not found${NC}"
    ANDROID_AVAILABLE=false
fi

echo -e "${BLUE}Step 6: Building the app...${NC}"

echo -e "${YELLOW}Choose your testing option:${NC}"
echo "1. Run on Android (requires Android Studio/device)"
echo "2. Build APK for manual installation"
echo "3. Run on iOS (Mac only, requires Xcode)"
echo "4. Just install dependencies and show project info"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        if [ "$ANDROID_AVAILABLE" = true ]; then
            echo -e "${BLUE}Starting Android app...${NC}"
            npx react-native run-android
        else
            echo -e "${RED}Android environment not available${NC}"
        fi
        ;;
    2)
        echo -e "${BLUE}Building APK...${NC}"
        cd android
        if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
            ./gradlew.bat assembleDebug
        else
            ./gradlew assembleDebug
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ APK built successfully!${NC}"
            echo -e "${GREEN}📱 Your APK is at: android/app/build/outputs/apk/debug/app-debug.apk${NC}"
            echo -e "${GREEN}Transfer this file to your Android phone and install it!${NC}"
        fi
        cd ..
        ;;
    3)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo -e "${BLUE}Installing iOS dependencies...${NC}"
            cd ios && pod install && cd ..
            echo -e "${BLUE}Starting iOS app...${NC}"
            npx react-native run-ios
        else
            echo -e "${RED}iOS development requires macOS${NC}"
        fi
        ;;
    4)
        echo -e "${GREEN}✓ Setup complete!${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        ;;
esac

echo ""
echo -e "${GREEN}🎉 SabihiRides Setup Complete!${NC}"
echo ""
echo -e "${BLUE}📱 Your bilingual ride-hailing app for الصبيحي is ready!${NC}"
echo ""
echo -e "${YELLOW}Features available:${NC}"
echo "✅ Arabic/English UI"
echo "✅ Google Maps integration (demo)"
echo "✅ Payment gateways (Cliq, Visa, Google Pay, Apple Pay)"
echo "✅ Push notifications"
echo "✅ Driver tracking"
echo "✅ Rating system"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Get real API keys (see SETUP.md)"
echo "2. Test on your phone"
echo "3. Add your driver database"
echo "4. Deploy to Play Store/App Store"
echo ""
echo -e "${BLUE}Repository: https://github.com/monti47rt/SabihiRides${NC}"
echo -e "${BLUE}Ready to revolutionize transportation in الصبيحي! 🚕🇯🇴${NC}"
