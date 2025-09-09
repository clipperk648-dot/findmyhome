import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/property_listing_creation/property_listing_creation.dart';
import '../presentation/property_detail_screen/property_detail_screen.dart';
import '../presentation/property_browse_screen/property_browse_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String login = '/login-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String propertyListingCreation = '/property-listing-creation';
  static const String propertyDetail = '/property-detail-screen';
  static const String propertyBrowse = '/property-browse-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    propertyListingCreation: (context) => const PropertyListingCreation(),
    propertyDetail: (context) => const PropertyDetailScreen(),
    propertyBrowse: (context) => const PropertyBrowseScreen(),
    // TODO: Add your other routes here
  };
}
