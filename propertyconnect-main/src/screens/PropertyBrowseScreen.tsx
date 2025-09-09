import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  TextField,
  IconButton,
  InputAdornment,
  Fab,
  Chip,
  Stack,
  Typography,
  Drawer,
  List,
  ListItem,
  ListItemText,
  Slider,
  FormControlLabel,
  Checkbox,
  Button,
  Badge,
  CircularProgress,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Grid,
  ToggleButton,
  ToggleButtonGroup,
} from '@mui/material'
import {
  Search,
  FilterList,
  MyLocation,
  Map,
} from '@mui/icons-material'

import PropertyCard from '../components/PropertyCard'
import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

interface Property {
  id: string | number
  title: string
  price: string
  location: string
  bedrooms: number
  bathrooms: number
  area: number
  status: string
  isFavorite: boolean
  images: string[]
  amenities: string[]
  propertyType: string
}

const NIGERIAN_STATES: string[] = [
  'Abia','Adamawa','Akwa Ibom','Anambra','Bauchi','Bayelsa','Benue','Borno','Cross River','Delta','Ebonyi','Edo','Ekiti','Enugu','Gombe','Imo','Jigawa','Kaduna','Kano','Katsina','Kebbi','Kogi','Kwara','Lagos','Nasarawa','Niger','Ogun','Ondo','Osun','Oyo','Plateau','Rivers','Sokoto','Taraba','Yobe','Zamfara','FCT - Abuja'
]

const PropertyBrowseScreen: React.FC = () => {
  const navigate = useNavigate()
  const [searchQuery, setSearchQuery] = useState('')
  const [filterDrawerOpen, setFilterDrawerOpen] = useState(false)
  const [currentBottomIndex, setCurrentBottomIndex] = useState(0)
  const [isLoading, setIsLoading] = useState(false)
  
  // Filter states
  const [activeFilters, setActiveFilters] = useState<any>({})
  const [activeFilterChips, setActiveFilterChips] = useState<any[]>([])
  const [priceRange, setPriceRange] = useState<number[]>([0, 100000000])
  const [selectedPropertyTypes, setSelectedPropertyTypes] = useState<string[]>([])
  const [selectedAmenities, setSelectedAmenities] = useState<string[]>([])
  const [selectedBedrooms, setSelectedBedrooms] = useState<number>(0)
  const [selectedBathrooms, setSelectedBathrooms] = useState<number>(0)
  const [selectedState, setSelectedState] = useState<string>('')
  const [selectedStatus, setSelectedStatus] = useState<string>('')

  // Mock property data (Nigeria)
  const allProperties: Property[] = [
    {
      id: 1,
      title: 'Luxury Apartment in Lekki Phase 1',
      price: '₦2,500,000/yr',
      location: 'Lekki, Lagos',
      bedrooms: 2,
      bathrooms: 2,
      area: 1200,
      status: 'For Rent',
      isFavorite: false,
      images: [
        'https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Parking', 'Gym', 'Pool'],
      propertyType: 'Apartment'
    },
    {
      id: 2,
      title: 'Family House in Gwarinpa',
      price: '₦85,000,000',
      location: 'Gwarinpa, FCT - Abuja',
      bedrooms: 4,
      bathrooms: 3,
      area: 2800,
      status: 'For Sale',
      isFavorite: true,
      images: [
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Garden', 'Garage', 'Security'],
      propertyType: 'House'
    },
    {
      id: 3,
      title: 'Cozy Studio in Yaba',
      price: '₦1,800,000/yr',
      location: 'Yaba, Lagos',
      bedrooms: 1,
      bathrooms: 1,
      area: 650,
      status: 'For Rent',
      isFavorite: false,
      images: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Pet Friendly', 'Balcony'],
      propertyType: 'Apartment'
    },
    {
      id: 4,
      title: 'Spacious Townhouse in Enugu',
      price: '₦3,200,000/yr',
      location: 'Independence Layout, Enugu',
      bedrooms: 3,
      bathrooms: 2,
      area: 1850,
      status: 'For Rent',
      isFavorite: false,
      images: [
        'https://images.unsplash.com/photo-1449844908441-8829872d2607?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Parking', 'Garden', 'Air Conditioning'],
      propertyType: 'Townhouse'
    },
    {
      id: 5,
      title: 'Executive Condo in Port Harcourt',
      price: '₦120,000,000',
      location: 'GRA Phase 2, Rivers',
      bedrooms: 3,
      bathrooms: 2,
      area: 1600,
      status: 'For Sale',
      isFavorite: true,
      images: [
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Pool', 'Gym', 'Elevator', 'Security'],
      propertyType: 'Condo'
    },
    {
      id: 6,
      title: 'Charming Cottage in Ibadan',
      price: '₦2,800,000/yr',
      location: 'Bodija, Oyo',
      bedrooms: 2,
      bathrooms: 1,
      area: 1100,
      status: 'For Rent',
      isFavorite: false,
      images: [
        'https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1505142468610-359e7d316be0?auto=format&fit=crop&w=1200&q=80'
      ],
      amenities: ['Garden', 'Pet Friendly', 'Furnished'],
      propertyType: 'House'
    }
  ]

  const [properties, setProperties] = useState<Property[]>(allProperties)
  const [filteredProperties, setFilteredProperties] = useState<Property[]>(allProperties)

  const propertyTypes = ['Apartment', 'House', 'Townhouse', 'Condo']
  const amenitiesList = ['Parking', 'Pool', 'Gym', 'Garden', 'Security', 'Pet Friendly', 'Balcony', 'Air Conditioning', 'Elevator', 'Furnished']

  const handleSearch = () => {
    alert('Search functionality coming soon!')
  }

  const handleLocationTap = () => {
    alert('Getting your location...')
  }

  const handleFilterTap = () => {
    setFilterDrawerOpen(true)
  }

  const applyFilters = () => {
    let filtered = allProperties

    if (searchQuery) {
      filtered = filtered.filter(property =>
        property.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        property.location.toLowerCase().includes(searchQuery.toLowerCase())
      )
    }

    if (selectedPropertyTypes.length > 0) {
      filtered = filtered.filter(property =>
        selectedPropertyTypes.includes(property.propertyType)
      )
    }

    if (selectedBedrooms > 0) {
      filtered = filtered.filter(property =>
        selectedBedrooms === 5 ? property.bedrooms >= 5 : property.bedrooms === selectedBedrooms
      )
    }

    if (selectedBathrooms > 0) {
      filtered = filtered.filter(property =>
        selectedBathrooms === 4 ? property.bathrooms >= 4 : property.bathrooms === selectedBathrooms
      )
    }

    if (selectedAmenities.length > 0) {
      filtered = filtered.filter(property =>
        selectedAmenities.every(amenity => property.amenities.includes(amenity))
      )
    }

    if (selectedState) {
      filtered = filtered.filter(property => property.location.includes(selectedState))
    }

    if (selectedStatus) {
      filtered = filtered.filter(property => property.status === selectedStatus)
    }

    setFilteredProperties(filtered)
    updateFilterChips()
    setFilterDrawerOpen(false)
  }

  const updateFilterChips = () => {
    const chips: any[] = []

    if (selectedPropertyTypes.length > 0) {
      chips.push({ key: 'propertyType', label: selectedPropertyTypes.length === 1 ? selectedPropertyTypes[0] : `${selectedPropertyTypes.length} Types` })
    }

    if (selectedBedrooms > 0) {
      chips.push({ key: 'bedrooms', label: selectedBedrooms === 5 ? '5+ Beds' : `${selectedBedrooms} Beds` })
    }

    if (selectedBathrooms > 0) {
      chips.push({ key: 'bathrooms', label: selectedBathrooms === 4 ? '4+ Baths' : `${selectedBathrooms} Baths` })
    }

    if (selectedAmenities.length > 0) {
      chips.push({ key: 'amenities', label: `${selectedAmenities.length} Amenities` })
    }

    if (selectedState) {
      chips.push({ key: 'state', label: selectedState })
    }

    if (selectedStatus) {
      chips.push({ key: 'status', label: selectedStatus })
    }

    setActiveFilterChips(chips)
  }

  const removeFilter = (key: string) => {
    switch (key) {
      case 'propertyType':
        setSelectedPropertyTypes([])
        break
      case 'bedrooms':
        setSelectedBedrooms(0)
        break
      case 'bathrooms':
        setSelectedBathrooms(0)
        break
      case 'amenities':
        setSelectedAmenities([])
        break
      case 'state':
        setSelectedState('')
        break
      case 'status':
        setSelectedStatus('')
        break
    }
    applyFilters()
  }

  const toggleFavorite = (propertyId: string | number) => {
    const updatedProperties = properties.map(property =>
      property.id === propertyId
        ? { ...property, isFavorite: !property.isFavorite }
        : property
    )
    setProperties(updatedProperties)
    setFilteredProperties(prev =>
      prev.map(property =>
        property.id === propertyId
          ? { ...property, isFavorite: !property.isFavorite }
          : property
      )
    )
  }

  const shareProperty = (property: Property) => {
    alert(`Sharing ${property.title}...`)
  }

  const onPropertySelected = (property: Property) => {
    navigate(`/property/${property.id}`)
  }

  const onMapViewTap = () => {
    alert('Map view coming soon...')
  }

  const clearAllFilters = () => {
    setSelectedPropertyTypes([])
    setSelectedBedrooms(0)
    setSelectedBathrooms(0)
    setSelectedAmenities([])
    setSelectedState('')
    setSelectedStatus('')
    setPriceRange([0, 100000000])
    setActiveFilterChips([])
    setFilteredProperties(allProperties)
  }

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa', pb: 12 }}>
      {/* Custom Search Header */}
      <Box
        sx={{
          backgroundColor: 'white',
          boxShadow: '0 2px 4px rgba(0,0,0,0.05)',
          p: 2,
        }}
      >
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5 }}>
          <TextField
            fullWidth
            placeholder="Search properties..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleSearch()}
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <Search sx={{ color: 'text.secondary' }} />
                </InputAdornment>
              ),
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton onClick={handleLocationTap} edge="end">
                    <MyLocation sx={{ color: 'primary.main' }} />
                  </IconButton>
                </InputAdornment>
              ),
              sx: {
                borderRadius: 3,
                '& .MuiOutlinedInput-notchedOutline': {
                  borderColor: 'rgba(0,0,0,0.12)',
                },
              },
            }}
          />
          <IconButton
            onClick={handleFilterTap}
            sx={{
              border: activeFilterChips.length > 0 ? 'none' : '1px solid rgba(0,0,0,0.12)',
              backgroundColor: activeFilterChips.length > 0 ? 'primary.main' : 'transparent',
              color: activeFilterChips.length > 0 ? 'white' : 'text.secondary',
              borderRadius: 3,
              p: 1.5,
            }}
          >
            <Badge badgeContent={activeFilterChips.length} color="secondary">
              <FilterList />
            </Badge>
          </IconButton>
        </Box>
      </Box>

      {/* Active Filter Chips */}
      {activeFilterChips.length > 0 && (
        <Box sx={{ p: 2, pt: 1 }}>
          <Stack direction="row" spacing={1} sx={{ flexWrap: 'wrap', gap: 1 }}>
            {activeFilterChips.map((chip) => (
              <Chip
                key={chip.key}
                label={chip.label}
                onDelete={() => removeFilter(chip.key)}
                color="primary"
                variant="outlined"
                size="small"
              />
            ))}
          </Stack>
        </Box>
      )}

      {/* Properties List */}
      <Box sx={{ flex: 1 }}>
        {filteredProperties.length === 0 ? (
          <Box sx={{ textAlign: 'center', py: 8 }}>
            <Typography variant="h6" color="text.secondary" sx={{ mb: 1 }}>
              No Properties Found
            </Typography>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
              Try adjusting your filters or search criteria
            </Typography>
            <Button variant="contained" onClick={clearAllFilters}>
              Clear Filters
            </Button>
          </Box>
        ) : (
          <Box>
            <Container maxWidth="lg">
              <Grid container spacing={2}>
                {filteredProperties.map((property) => (
                  <Grid item xs={12} sm={6} md={4} key={property.id}>
                    <PropertyCard
                      property={property}
                      onTap={() => onPropertySelected(property)}
                      onFavorite={() => toggleFavorite(property.id)}
                      onShare={() => shareProperty(property)}
                    />
                  </Grid>
                ))}
              </Grid>
            </Container>
            {isLoading && (
              <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
                <CircularProgress />
              </Box>
            )}
          </Box>
        )}
      </Box>

      {/* Floating Action Button */}
      <Fab
        variant="extended"
        color="primary"
        onClick={onMapViewTap}
        sx={{
          position: 'fixed',
          bottom: 100,
          right: 16,
          zIndex: 1000,
        }}
      >
        <Map sx={{ mr: 1 }} />
        Map View
      </Fab>

      {/* Filter Drawer */}
      <Drawer
        anchor="right"
        open={filterDrawerOpen}
        onClose={() => setFilterDrawerOpen(false)}
      >
        <Box sx={{ width: { xs: '100vw', sm: 360 }, maxWidth: '100vw', height: '100vh', p: 3, display: 'flex', flexDirection: 'column' }}>
          <Typography variant="h6" sx={{ mb: 3 }}>
            Filters
          </Typography>

          <Box sx={{ flex: 1, overflowY: 'auto', pr: 1 }}>

          {/* Listing Status */}
          <Typography variant="subtitle2" sx={{ mb: 2 }}>
            Listing Status
          </Typography>
          <ToggleButtonGroup
            exclusive
            value={selectedStatus}
            onChange={(_, v) => setSelectedStatus(v || '')}
            size="small"
            sx={{ mb: 3, flexWrap: 'wrap' }}
          >
            <ToggleButton value="For Rent">For Rent</ToggleButton>
            <ToggleButton value="For Sale">For Sale</ToggleButton>
          </ToggleButtonGroup>

          {/* Property Types */}
          <Typography variant="subtitle2" sx={{ mb: 2 }}>
            Property Type
          </Typography>
          <List dense>
            {propertyTypes.map(type => (
              <ListItem key={type} disablePadding>
                <FormControlLabel
                  control={
                    <Checkbox
                      checked={selectedPropertyTypes.includes(type)}
                      onChange={(e) => {
                        if (e.target.checked) {
                          setSelectedPropertyTypes(prev => [...prev, type])
                        } else {
                          setSelectedPropertyTypes(prev => prev.filter(t => t !== type))
                        }
                      }}
                    />
                  }
                  label={type}
                />
              </ListItem>
            ))}
          </List>

          {/* Location by State */}
          <Typography variant="subtitle2" sx={{ mb: 2, mt: 3 }}>
            Location (State)
          </Typography>
          <FormControl fullWidth size="small" sx={{ mb: 1 }}>
            <InputLabel id="state-select-label">Select State</InputLabel>
            <Select
              labelId="state-select-label"
              value={selectedState}
              label="Select State"
              onChange={(e) => setSelectedState(e.target.value)}
            >
              <MenuItem value="">
                <em>All States</em>
              </MenuItem>
              {NIGERIAN_STATES.map((state) => (
                <MenuItem key={state} value={state}>{state}</MenuItem>
              ))}
            </Select>
          </FormControl>

          {/* Bedrooms */}
          <Typography variant="subtitle2" sx={{ mb: 2, mt: 3 }}>
            Bedrooms
          </Typography>
          <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap' }}>
            {[1, 2, 3, 4, 5].map(beds => (
              <Chip
                key={beds}
                label={beds === 5 ? '5+' : beds.toString()}
                clickable
                color={selectedBedrooms === beds ? 'primary' : 'default'}
                onClick={() => setSelectedBedrooms(selectedBedrooms === beds ? 0 : beds)}
              />
            ))}
          </Box>

          {/* Bathrooms */}
          <Typography variant="subtitle2" sx={{ mb: 2, mt: 3 }}>
            Bathrooms
          </Typography>
          <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap' }}>
            {[1, 2, 3, 4].map(baths => (
              <Chip
                key={baths}
                label={baths === 4 ? '4+' : baths.toString()}
                clickable
                color={selectedBathrooms === baths ? 'primary' : 'default'}
                onClick={() => setSelectedBathrooms(selectedBathrooms === baths ? 0 : baths)}
              />
            ))}
          </Box>

          {/* Amenities */}
          <Typography variant="subtitle2" sx={{ mb: 2, mt: 3 }}>
            Amenities
          </Typography>
          <List dense>
            {amenitiesList.map(amenity => (
              <ListItem key={amenity} disablePadding>
                <FormControlLabel
                  control={
                    <Checkbox
                      checked={selectedAmenities.includes(amenity)}
                      onChange={(e) => {
                        if (e.target.checked) {
                          setSelectedAmenities(prev => [...prev, amenity])
                        } else {
                          setSelectedAmenities(prev => prev.filter(a => a !== amenity))
                        }
                      }}
                    />
                  }
                  label={amenity}
                />
              </ListItem>
            ))}
          </List>

          </Box>

          <Box sx={{ mt: 2, display: 'flex', gap: 2, position: 'sticky', bottom: 0, backgroundColor: 'white', pt: 2 }}>
            <Button
              fullWidth
              variant="outlined"
              onClick={clearAllFilters}
            >
              Clear All
            </Button>
            <Button
              fullWidth
              variant="contained"
              onClick={applyFilters}
            >
              Apply Filters
            </Button>
          </Box>
        </Box>
      </Drawer>

      {/* Bottom Navigation */}
      <CustomBottomBar
        currentIndex={currentBottomIndex}
        onTap={setCurrentBottomIndex}
        variant={BottomBarVariant.STANDARD}
      />
    </Box>
  )
}

export default PropertyBrowseScreen
