import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom AppBar widget for the real estate application
/// Provides consistent navigation and branding across screens
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final VoidCallback? onBackPressed;
  final AppBarVariant variant;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 1.0,
    this.onBackPressed,
    this.variant = AppBarVariant.standard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: _getTitleStyle(theme),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? _getBackgroundColor(theme),
      foregroundColor: foregroundColor ?? _getForegroundColor(theme),
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      shadowColor: theme.shadowColor,
      leading: leading ?? _buildLeading(context),
      actions: _buildActions(context),
      automaticallyImplyLeading: showBackButton,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (!showBackButton) return null;

    final canPop = Navigator.of(context).canPop();
    if (!canPop) return null;

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      tooltip: 'Back',
    );
  }

  List<Widget>? _buildActions(BuildContext context) {
    if (actions != null) return actions;

    switch (variant) {
      case AppBarVariant.search:
        return [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
            tooltip: 'Search Properties',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
            tooltip: 'Filter Properties',
          ),
        ];
      case AppBarVariant.profile:
        return [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(context),
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => _showProfile(context),
            tooltip: 'Profile',
          ),
        ];
      case AppBarVariant.property:
        return [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => _toggleFavorite(context),
            tooltip: 'Add to Favorites',
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _shareProperty(context),
            tooltip: 'Share Property',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.report_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Report Property'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.contact_phone_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Contact Owner'),
                  ],
                ),
              ),
            ],
          ),
        ];
      case AppBarVariant.standard:
      default:
        return null;
    }
  }

  TextStyle _getTitleStyle(ThemeData theme) {
    switch (variant) {
      case AppBarVariant.search:
        return GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: _getForegroundColor(theme),
        );
      case AppBarVariant.profile:
        return GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: _getForegroundColor(theme),
        );
      case AppBarVariant.property:
        return GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _getForegroundColor(theme),
        );
      case AppBarVariant.standard:
      default:
        return GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: _getForegroundColor(theme),
        );
    }
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (variant) {
      case AppBarVariant.search:
      case AppBarVariant.profile:
      case AppBarVariant.property:
      case AppBarVariant.standard:
      default:
        return theme.colorScheme.surface;
    }
  }

  Color _getForegroundColor(ThemeData theme) {
    return theme.colorScheme.onSurface;
  }

  void _showSearch(BuildContext context) {
    Navigator.pushNamed(context, '/property-browse-screen');
  }

  void _showFilters(BuildContext context) {
    // Show filter bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Filter Properties',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // Add filter options here
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    // Navigate to notifications or show notifications panel
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications feature coming soon')),
    );
  }

  void _showProfile(BuildContext context) {
    // Navigate to profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile feature coming soon')),
    );
  }

  void _toggleFavorite(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to favorites')),
    );
  }

  void _shareProperty(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Property shared')),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'report':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Property reported')),
        );
        break;
      case 'contact':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contacting property owner')),
        );
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Enum defining different AppBar variants for different screens
enum AppBarVariant {
  standard,
  search,
  profile,
  property,
}
