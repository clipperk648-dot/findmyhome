import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { Box } from '@mui/material'

import HomeScreen from './screens/HomeScreen'
import SplashScreen from './screens/SplashScreen'
import OnboardingFlow from './screens/OnboardingFlow'
import LoginScreen from './screens/LoginScreen'
import PropertyBrowseScreen from './screens/PropertyBrowseScreen'
import PropertyDetailScreen from './screens/PropertyDetailScreen'
import PropertyListingCreation from './screens/PropertyListingCreation'
import ProfileScreen from './screens/ProfileScreen'
import MessagesScreen from './screens/MessagesScreen'
import NotificationsScreen from './screens/NotificationsScreen'
import SupportScreen from './screens/SupportScreen'
import LiveChatScreen from './screens/LiveChatScreen'
import MyPropertiesScreen from './screens/MyPropertiesScreen'
import FavoritesScreen from './screens/FavoritesScreen'
import HistoryScreen from './screens/HistoryScreen'
import ProfileEditScreen from './screens/ProfileEditScreen'
import ProfilePaymentsScreen from './screens/ProfilePaymentsScreen'
import ProfileNotificationsScreen from './screens/ProfileNotificationsScreen'
import ProfileSecurityScreen from './screens/ProfileSecurityScreen'
import ProfileLanguageScreen from './screens/ProfileLanguageScreen'
import ProfileSettingsScreen from './screens/ProfileSettingsScreen'

function App() {
  return (
    <Box sx={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <Routes>
        <Route path="/" element={<HomeScreen />} />
        <Route path="/splash" element={<SplashScreen />} />
        <Route path="/onboarding" element={<OnboardingFlow />} />
        <Route path="/login" element={<LoginScreen />} />
        <Route path="/browse" element={<PropertyBrowseScreen />} />
        <Route path="/property/:id" element={<PropertyDetailScreen />} />
        <Route path="/create-listing" element={<PropertyListingCreation />} />
        <Route path="/profile" element={<ProfileScreen />} />
        <Route path="/my-properties" element={<MyPropertiesScreen />} />
        <Route path="/favorites" element={<FavoritesScreen />} />
        <Route path="/history" element={<HistoryScreen />} />
        <Route path="/profile/edit" element={<ProfileEditScreen />} />
        <Route path="/profile/payments" element={<ProfilePaymentsScreen />} />
        <Route path="/profile/notifications" element={<ProfileNotificationsScreen />} />
        <Route path="/profile/security" element={<ProfileSecurityScreen />} />
        <Route path="/profile/language" element={<ProfileLanguageScreen />} />
        <Route path="/profile/settings" element={<ProfileSettingsScreen />} />
        <Route path="/messages" element={<MessagesScreen />} />
        <Route path="/notifications" element={<NotificationsScreen />} />
        <Route path="/support" element={<SupportScreen />} />
        <Route path="/support/chat" element={<LiveChatScreen />} />
      </Routes>
    </Box>
  )
}

export default App
