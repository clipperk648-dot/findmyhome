import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/property_card_widget.dart';
import './widgets/search_header_widget.dart';

class PropertyBrowseScreen extends StatefulWidget {
  const PropertyBrowseScreen({super.key});

  @override
  State<PropertyBrowseScreen> createState() => _PropertyBrowseScreenState();
}

class _PropertyBrowseScreenState extends State<PropertyBrowseScreen> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  Map<String, dynamic> _activeFilters = {};
  List<Map<String, dynamic>> _activeFilterChips = [];
  int _currentBottomIndex = 0;
  bool _isLoading = false;
  bool _hasMoreData = true;

  // Mock property data
  final List<Map<String, dynamic>> _allProperties = [
    {
      "id": 1,
      "title": "Modern Downtown Apartment",
      "price": "\$2,500/month",
      "location": "Downtown Seattle, WA",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1200,
      "status": "For Rent",
      "isFavorite": false,
      "images": [
        "https://images.unsplash.com/photo-1560518883-ce09059eeffa?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1484154218962-a197022b5858?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Parking", "Gym", "Pool"],
      "propertyType": "Apartment"
    },
    {
      "id": 2,
      "title": "Luxury Family House",
      "price": "\$850,000",
      "location": "Bellevue, WA",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2800,
      "status": "For Sale",
      "isFavorite": true,
      "images": [
        "https://images.unsplash.com/photo-1570129477492-45c003edd2be?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Garden", "Garage", "Security"],
      "propertyType": "House"
    },
    {
      "id": 3,
      "title": "Cozy Studio Loft",
      "price": "\$1,800/month",
      "location": "Capitol Hill, Seattle, WA",
      "bedrooms": 1,
      "bathrooms": 1,
      "area": 650,
      "status": "For Rent",
      "isFavorite": false,
      "images": [
        "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1493809842364-78817add7ffb?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Pet Friendly", "Balcony"],
      "propertyType": "Apartment"
    },
    {
      "id": 4,
      "title": "Spacious Townhouse",
      "price": "\$3,200/month",
      "location": "Redmond, WA",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1850,
      "status": "For Rent",
      "isFavorite": false,
      "images": [
        "https://images.unsplash.com/photo-1449844908441-8829872d2607?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Parking", "Garden", "Air Conditioning"],
      "propertyType": "Townhouse"
    },
    {
      "id": 5,
      "title": "Executive Condo",
      "price": "\$1,200,000",
      "location": "South Lake Union, Seattle, WA",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1600,
      "status": "For Sale",
      "isFavorite": true,
      "images": [
        "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Pool", "Gym", "Elevator", "Security"],
      "propertyType": "Condo"
    },
    {
      "id": 6,
      "title": "Charming Cottage",
      "price": "\$2,800/month",
      "location": "Kirkland, WA",
      "bedrooms": 2,
      "bathrooms": 1,
      "area": 1100,
      "status": "For Rent",
      "isFavorite": false,
      "images": [
        "https://images.unsplash.com/photo-1518780664697-55e3ad937233?fm=jpg&q=60&w=3000",
        "https://images.unsplash.com/photo-1505142468610-359e7d316be0?fm=jpg&q=60&w=3000"
      ],
      "amenities": ["Garden", "Pet Friendly", "Furnished"],
      "propertyType": "House"
    }
  ];

  List<Map<String, dynamic>> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    _filteredProperties = List.from(_allProperties);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreProperties();
    }
  }

  Future<void> _loadMoreProperties() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      // For demo purposes, we'll just mark as no more data after first load
      _hasMoreData = false;
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _filteredProperties = List.from(_allProperties);
      _hasMoreData = true;
    });
  }

  void _onSearchTap() {
    showSearch(
      context: context,
      delegate: PropertySearchDelegate(_allProperties, _onPropertySelected),
    );
  }

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterModalWidget(
        currentFilters: _activeFilters,
        onApplyFilters: _applyFilters,
      ),
    );
  }

  void _onLocationTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Getting your location...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _activeFilters = filters;
      _updateFilterChips();
      _filterProperties();
    });
  }

  void _updateFilterChips() {
    _activeFilterChips.clear();

    if (_activeFilters['propertyType'] != null &&
        _activeFilters['propertyType'] != 'All') {
      _activeFilterChips.add({
        'key': 'propertyType',
        'label': _activeFilters['propertyType'] as String,
      });
    }

    if (_activeFilters['bedrooms'] != null &&
        (_activeFilters['bedrooms'] as int) > 0) {
      final bedrooms = _activeFilters['bedrooms'] as int;
      _activeFilterChips.add({
        'key': 'bedrooms',
        'label': bedrooms == 5 ? '5+ Beds' : '$bedrooms Beds',
      });
    }

    if (_activeFilters['bathrooms'] != null &&
        (_activeFilters['bathrooms'] as int) > 0) {
      final bathrooms = _activeFilters['bathrooms'] as int;
      _activeFilterChips.add({
        'key': 'bathrooms',
        'label': bathrooms == 4 ? '4+ Baths' : '$bathrooms Baths',
      });
    }

    if (_activeFilters['minPrice'] != null &&
        (_activeFilters['minPrice'] as double) > 0) {
      final minPrice = (_activeFilters['minPrice'] as double) / 1000;
      final maxPrice = (_activeFilters['maxPrice'] as double) / 1000;
      _activeFilterChips.add({
        'key': 'price',
        'label': '\$${minPrice.round()}K - \$${maxPrice.round()}K',
      });
    }

    if (_activeFilters['amenities'] != null &&
        (_activeFilters['amenities'] as List).isNotEmpty) {
      final amenities = _activeFilters['amenities'] as List;
      _activeFilterChips.add({
        'key': 'amenities',
        'label': '${amenities.length} Amenities',
      });
    }
  }

  void _filterProperties() {
    _filteredProperties = _allProperties.where((property) {
      // Property type filter
      if (_activeFilters['propertyType'] != null &&
          _activeFilters['propertyType'] != 'All' &&
          property['propertyType'] != _activeFilters['propertyType']) {
        return false;
      }

      // Bedrooms filter
      if (_activeFilters['bedrooms'] != null &&
          (_activeFilters['bedrooms'] as int) > 0) {
        final filterBedrooms = _activeFilters['bedrooms'] as int;
        final propertyBedrooms = property['bedrooms'] as int;
        if (filterBedrooms == 5 && propertyBedrooms < 5) return false;
        if (filterBedrooms < 5 && propertyBedrooms != filterBedrooms)
          return false;
      }

      // Bathrooms filter
      if (_activeFilters['bathrooms'] != null &&
          (_activeFilters['bathrooms'] as int) > 0) {
        final filterBathrooms = _activeFilters['bathrooms'] as int;
        final propertyBathrooms = property['bathrooms'] as int;
        if (filterBathrooms == 4 && propertyBathrooms < 4) return false;
        if (filterBathrooms < 4 && propertyBathrooms != filterBathrooms)
          return false;
      }

      // Amenities filter
      if (_activeFilters['amenities'] != null &&
          (_activeFilters['amenities'] as List).isNotEmpty) {
        final filterAmenities = _activeFilters['amenities'] as List<String>;
        final propertyAmenities = property['amenities'] as List<String>;
        if (!filterAmenities
            .every((amenity) => propertyAmenities.contains(amenity))) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _removeFilter(String key) {
    setState(() {
      switch (key) {
        case 'propertyType':
          _activeFilters.remove('propertyType');
          break;
        case 'bedrooms':
          _activeFilters.remove('bedrooms');
          break;
        case 'bathrooms':
          _activeFilters.remove('bathrooms');
          break;
        case 'price':
          _activeFilters.remove('minPrice');
          _activeFilters.remove('maxPrice');
          break;
        case 'amenities':
          _activeFilters.remove('amenities');
          break;
      }
      _updateFilterChips();
      _filterProperties();
    });
  }

  void _onPropertySelected(Map<String, dynamic> property) {
    Navigator.pushNamed(
      context,
      '/property-detail-screen',
      arguments: property,
    );
  }

  void _toggleFavorite(Map<String, dynamic> property) {
    setState(() {
      property['isFavorite'] = !(property['isFavorite'] as bool);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (property['isFavorite'] as bool)
              ? 'Added to favorites'
              : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareProperty(Map<String, dynamic> property) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${property['title']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onMapViewTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Map view coming soon...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchHeaderWidget(
            searchQuery: _searchQuery,
            filterCount: _activeFilterChips.length,
            onSearchTap: _onSearchTap,
            onFilterTap: _onFilterTap,
            onLocationTap: _onLocationTap,
          ),
          FilterChipsWidget(
            activeFilters: _activeFilterChips,
            onRemoveFilter: _removeFilter,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: _filteredProperties.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          _filteredProperties.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _filteredProperties.length) {
                          return _buildLoadingIndicator();
                        }

                        final property = _filteredProperties[index];
                        return PropertyCardWidget(
                          property: property,
                          onTap: () => _onPropertySelected(property),
                          onFavorite: () => _toggleFavorite(property),
                          onShare: () => _shareProperty(property),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onMapViewTap,
        icon: CustomIconWidget(
          iconName: 'map',
          color: Colors.white,
          size: 20,
        ),
        label: const Text('Map View'),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          setState(() {
            _currentBottomIndex = index;
          });
        },
        variant: BottomBarVariant.standard,
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              size: 80,
            ),
            SizedBox(height: 3.h),
            Text(
              'No Properties Found',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Try adjusting your filters or search criteria',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _activeFilters.clear();
                  _activeFilterChips.clear();
                  _filteredProperties = List.from(_allProperties);
                });
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PropertySearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  final List<Map<String, dynamic>> properties;
  final Function(Map<String, dynamic>) onPropertySelected;

  PropertySearchDelegate(this.properties, this.onPropertySelected);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final filteredProperties = properties.where((property) {
      return (property['title'] as String)
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          (property['location'] as String)
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    if (filteredProperties.isEmpty) {
      return const Center(
        child: Text('No properties found'),
      );
    }

    return ListView.builder(
      itemCount: filteredProperties.length,
      itemBuilder: (context, index) {
        final property = filteredProperties[index];
        return PropertyCardWidget(
          property: property,
          onTap: () {
            close(context, property);
            onPropertySelected(property);
          },
        );
      },
    );
  }
}
