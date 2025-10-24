# 🚕 Sabihi Rides - Setup Guide

**Ride-hailing mobile app for الصبيحي, Jordan**  
*React Native frontend with Node.js backend, Google Maps integration, bilingual Arabic/English support*

---

## 📱 Features

### Core Features
- ✅ **Bilingual Support**: Arabic/English UI with complete translations
- ✅ **User Authentication**: Phone/Email registration + Social login stubs
- ✅ **Real-time Maps**: Google Maps integration for الصبيحي area
- ✅ **Ride Booking**: Pickup/dropoff selection with fare estimation
- ✅ **Driver Tracking**: Live location tracking during rides
- ✅ **Payment Integration**: Cliq, Visa, Google Pay, Apple Pay (stubs ready)
- ✅ **Push Notifications**: Firebase Cloud Messaging setup
- ✅ **Rating System**: Driver ratings and feedback
- ✅ **Photo Upload**: ID/profile photo upload capability

### Payment Methods
- 💳 **Cliq** (Jordan's payment system)
- 💳 **Visa/Mastercard**
- 💳 **Google Pay**
- 💳 **Apple Pay**
- 💵 **Cash**

---

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- React Native CLI
- Android Studio (for Android)
- Xcode (for iOS, Mac only)
- Firebase account
- Google Cloud Platform account

### 1. Clone & Install
```bash
git clone https://github.com/YOUR_USERNAME/SabihiRides.git
cd SabihiRides
npm install
```

### 2. Setup Configuration Files

Create these config files (not included in repo for security):

#### `src/config/firebase.js`
```javascript
export const firebaseConfig = {
  apiKey: "your-api-key",
  authDomain: "your-domain.firebaseapp.com",
  projectId: "your-project-id",
  messagingSenderId: "your-sender-id",
  appId: "your-app-id"
};
```

#### `src/config/maps.js`
```javascript
export const GOOGLE_MAPS_API_KEY = "your-google-maps-api-key";
export const SABIHI_BOUNDS = {
  latitude: 32.2407,
  longitude: 35.7485,
  latitudeDelta: 0.05,
  longitudeDelta: 0.05
};
```

#### `src/config/payments.js`
```javascript
export const PAYMENT_CONFIG = {
  cliq: {
    merchantId: "your-cliq-merchant-id",
    apiKey: "your-cliq-api-key"
  },
  stripe: {
    publishableKey: "pk_test_your-stripe-key"
  }
};
```

### 3. Run the App

#### Android
```bash
npx react-native run-android
```

#### iOS (Mac only)
```bash
cd ios && pod install && cd ..
npx react-native run-ios
```

---

## 🌐 API Keys Setup

### Google Maps API
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Enable Maps SDK for Android/iOS
3. Create API key
4. Add restrictions for your app

### Firebase Setup
1. Create project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Phone, Google, Apple)
3. Enable Cloud Messaging
4. Download `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)

### Payment Gateways
- **Cliq**: Contact [JoPACC](https://www.jopacc.com/) for merchant account
- **Stripe**: Sign up at [Stripe](https://stripe.com/) for international cards

---

## 📁 Project Structure

```
SabihiRides/
├── App.js                 # Main app with navigation
├── package.json           # Dependencies
├── src/
│   ├── i18n/
│   │   └── index.js      # Bilingual strings (Arabic/English)
│   ├── components/
│   │   └── LanguageToggle.js
│   ├── screens/
│   │   ├── LoginScreen.js
│   │   ├── RegisterScreen.js
│   │   ├── HomeScreen.js
│   │   ├── BookingScreen.js
│   │   ├── DriverTrackingScreen.js
│   │   ├── PaymentScreen.js
│   │   └── ProfileScreen.js
│   └── config/           # API keys (create these)
│       ├── firebase.js
│       ├── maps.js
│       └── payments.js
├── backend/
│   ├── server.js         # Express server
│   ├── models/           # Database models
│   └── routes/           # API endpoints
└── README.md
```

---

## 🛠 Development

### Adding New Features
1. **New Screen**: Add to `src/screens/` and register in `App.js`
2. **New Language**: Add strings to both `strings_en` and `strings_ar` in `src/i18n/index.js`
3. **New Payment**: Add gateway configuration to `src/config/payments.js`

### Testing
```bash
npm test                  # Run tests
npm run lint             # Check code style
```

### Building for Production

#### Android APK
```bash
cd android
./gradlew assembleRelease
# APK will be in android/app/build/outputs/apk/release/
```

#### iOS IPA (Mac only)
1. Open `ios/SabihiRides.xcworkspace` in Xcode
2. Select "Generic iOS Device" or your device
3. Product → Archive
4. Export for distribution

---

## 🚀 Deployment

### Google Play Store
1. Create signed APK (see above)
2. Create developer account
3. Upload APK with screenshots

### Apple App Store
1. Create IPA (see above)
2. Upload via Xcode or Transporter
3. Submit for review

---

## 🌍 Localization

The app supports Arabic and English:
- **Arabic**: Full RTL support with proper text alignment
- **English**: LTR default
- **Toggle**: Users can switch languages in-app
- **Persist**: Language preference saved locally

---

## 💡 Next Steps for Production

### Backend Implementation
1. **Database**: MongoDB/PostgreSQL for users, rides, drivers
2. **Real-time**: Socket.IO for live tracking
3. **Payment Processing**: Implement actual payment gateways
4. **Push Notifications**: Firebase admin SDK
5. **Analytics**: Firebase Analytics or Mixpanel

### Advanced Features
1. **Driver App**: Separate app for drivers
2. **Food Delivery**: Extend for food delivery services
3. **Admin Dashboard**: Web panel for management
4. **AI Route Optimization**: Smart routing algorithms

---

## 📞 Support

**For الصبيحي, Jordan market specifically**

- 📧 Email: support@sabihirides.com
- 📱 Phone: +962-XX-XXX-XXXX
- 🌐 Website: Coming soon

---

## 📜 License

MIT License - Feel free to use this as a starting point for your ride-hailing business in Jordan!

**Ready to revolutionize transportation in الصبيحي! 🚕🇯🇴**
