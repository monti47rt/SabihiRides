import React, { useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { View, StyleSheet } from 'react-native';

// Import localization
import { strings_en, strings_ar } from './src/i18n';

// Import components
import LanguageToggle from './src/components/LanguageToggle';

// Import screens
import LoginScreen from './src/screens/LoginScreen';
import RegisterScreen from './src/screens/RegisterScreen';
import HomeScreen from './src/screens/HomeScreen';
import BookingScreen from './src/screens/BookingScreen';
import DriverTrackingScreen from './src/screens/DriverTrackingScreen';
import PaymentScreen from './src/screens/PaymentScreen';
import ProfileScreen from './src/screens/ProfileScreen';

const Stack = createStackNavigator();

export default function App() {
  const [language, setLanguage] = useState('en');
  const strings = language === 'ar' ? strings_ar : strings_en;
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  return (
    <NavigationContainer>
      <View style={styles.container}>
        <LanguageToggle 
          language={language} 
          setLanguage={setLanguage} 
          strings={strings}
        />
        
        <Stack.Navigator 
          initialRouteName={isAuthenticated ? "Home" : "Login"}
          screenOptions={{
            headerStyle: {
              backgroundColor: '#2E8B57',
            },
            headerTintColor: '#fff',
            headerTitleStyle: {
              fontWeight: 'bold',
            },
            headerTitleAlign: language === 'ar' ? 'right' : 'center',
          }}
        >
          {!isAuthenticated ? (
            // Auth Stack
            <>
              <Stack.Screen 
                name="Login" 
                options={{ title: strings.login }}
              >
                {props => (
                  <LoginScreen 
                    {...props} 
                    strings={strings} 
                    setIsAuthenticated={setIsAuthenticated}
                  />
                )}
              </Stack.Screen>
              
              <Stack.Screen 
                name="Register" 
                options={{ title: strings.register }}
              >
                {props => (
                  <RegisterScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
            </>
          ) : (
            // Main App Stack
            <>
              <Stack.Screen 
                name="Home" 
                options={{ title: strings.bookRide }}
              >
                {props => (
                  <HomeScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
              
              <Stack.Screen 
                name="Booking" 
                options={{ title: strings.bookRide }}
              >
                {props => (
                  <BookingScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
              
              <Stack.Screen 
                name="Tracking" 
                options={{ title: strings.driverTracking }}
              >
                {props => (
                  <DriverTrackingScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
              
              <Stack.Screen 
                name="Payment" 
                options={{ title: strings.pay }}
              >
                {props => (
                  <PaymentScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
              
              <Stack.Screen 
                name="Profile" 
                options={{ title: strings.profile }}
              >
                {props => (
                  <ProfileScreen 
                    {...props} 
                    strings={strings}
                  />
                )}
              </Stack.Screen>
            </>
          )}
        </Stack.Navigator>
      </View>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
});
