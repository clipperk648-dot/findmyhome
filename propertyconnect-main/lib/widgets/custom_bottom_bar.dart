import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom Bottom Navigation Bar for the real estate application
/// Provides main navigation between key app sections
class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final BottomBarVariant variant;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.variant = BottomBarVariant.standard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavigationItems(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems(BuildContext context) {
    final items = _getNavigationItems();

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isSelected = currentIndex == index;

      return _NavigationItem(
        item: item,
        isSelected: isSelected,
        onTap: () => _handleNavigation(context, index, item.route),
        variant: variant,
      );
    }).toList();
  }

  List<_BottomNavItem> _getNavigationItems() {
    switch (variant) {
      case BottomBarVariant.landlord:
        return [
          _BottomNavItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Properties',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.add_circle_outline,
            selectedIcon: Icons.add_circle,
            label: 'Add Listing',
            route: '/property-listing-creation',
          ),
          _BottomNavItem(
            icon: Icons.people_outline,
            selectedIcon: Icons.people,
            label: 'Tenants',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.analytics_outlined,
            selectedIcon: Icons.analytics,
            label: 'Analytics',
            route: '/property-browse-screen',
          ),
        ];
      case BottomBarVariant.seeker:
        return [
          _BottomNavItem(
            icon: Icons.search_outlined,
            selectedIcon: Icons.search,
            label: 'Search',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.favorite_outline,
            selectedIcon: Icons.favorite,
            label: 'Favorites',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.map_outlined,
            selectedIcon: Icons.map,
            label: 'Map View',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Profile',
            route: '/login-screen',
          ),
        ];
      case BottomBarVariant.standard:
      default:
        return [
          _BottomNavItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Home',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.search_outlined,
            selectedIcon: Icons.search,
            label: 'Search',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.favorite_outline,
            selectedIcon: Icons.favorite,
            label: 'Favorites',
            route: '/property-browse-screen',
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Profile',
            route: '/login-screen',
          ),
        ];
    }
  }

  void _handleNavigation(BuildContext context, int index, String route) {
    onTap(index);

    // Navigate to the selected route
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != route) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (route) => false,
      );
    }
  }
}

/// Individual navigation item widget
class _NavigationItem extends StatelessWidget {
  final _BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final BottomBarVariant variant;

  const _NavigationItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.onSurface.withValues(alpha: 0.6);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? selectedColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Data class for bottom navigation items
class _BottomNavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  const _BottomNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });
}

/// Enum defining different bottom bar variants for different user types
enum BottomBarVariant {
  standard,
  landlord,
  seeker,
}
