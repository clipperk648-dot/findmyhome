import React from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Button, Grid } from '@mui/material'
import { ArrowBack, Add } from '@mui/icons-material'
import PropertyCard from '../components/PropertyCard'

const mockMyProperties = [
  {
    id: 'mp1',
    title: '3-Bed Apartment in Lekki',
    price: '₦2,500,000/yr',
    location: 'Lekki Phase 1, Lagos',
    bedrooms: 3,
    bathrooms: 2,
    area: 1450,
    status: 'For Rent',
    isFavorite: false,
    images: ['https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80'],
    amenities: ['Parking', 'Gym'],
    propertyType: 'Apartment'
  },
  {
    id: 'mp2',
    title: 'Family House in Gwarinpa',
    price: '₦85,000,000',
    location: 'Gwarinpa, FCT - Abuja',
    bedrooms: 4,
    bathrooms: 3,
    area: 2800,
    status: 'For Sale',
    isFavorite: true,
    images: ['https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1200&q=80'],
    amenities: ['Garden', 'Garage'],
    propertyType: 'House'
  },
]

const MyPropertiesScreen: React.FC = () => {
  const navigate = useNavigate()

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>My Properties</Typography>
          <Button color="inherit" startIcon={<Add />} onClick={() => navigate('/create-listing')}>
            Add Listing
          </Button>
        </Toolbar>
      </AppBar>

      <Container maxWidth="lg" sx={{ py: 2 }}>
        <Grid container spacing={2}>
          {mockMyProperties.map((p) => (
            <Grid item xs={12} sm={6} md={4} key={p.id}>
              <PropertyCard property={p as any} onTap={() => navigate(`/property/${p.id}`)} />
            </Grid>
          ))}
        </Grid>
      </Container>
    </Box>
  )
}

export default MyPropertiesScreen
