import React, { useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  Button,
  Card,
  CardContent,
  Grid,
  Chip,
  IconButton,
  AppBar,
  Toolbar,
  ImageList,
  ImageListItem,
  Avatar,
  Divider,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Dialog,
  DialogContent,
} from '@mui/material'
import {
  ArrowBack,
  Favorite,
  FavoriteBorder,
  Share,
  LocationOn,
  Bed,
  Bathtub,
  SquareFoot,
  LocalParking,
  Pool,
  Wifi,
  AcUnit,
  Security,
  Phone,
  Email,
  Message,
  Close,
} from '@mui/icons-material'

const PropertyDetailScreen: React.FC = () => {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const [isFavorite, setIsFavorite] = useState(false)
  const [selectedImageIndex, setSelectedImageIndex] = useState(0)
  const [showFullscreenGallery, setShowFullscreenGallery] = useState(false)

  // Mock property data
  const property = {
    id: id || '1',
    title: 'Modern Downtown Apartment',
    price: 250000,
    location: 'Downtown, City Center',
    bedrooms: 2,
    bathrooms: 2,
    area: 1200,
    type: 'Apartment',
    description: 'Beautiful modern apartment in the heart of downtown. This stunning property features contemporary design, high-end finishes, and breathtaking city views. Perfect for urban professionals seeking luxury and convenience.',
    images: [
      'https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1600&q=80',
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=1600&q=80',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=1600&q=80',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1600&q=80',
    ],
    amenities: [
      { name: 'Parking', icon: <LocalParking /> },
      { name: 'Swimming Pool', icon: <Pool /> },
      { name: 'WiFi', icon: <Wifi /> },
      { name: 'Air Conditioning', icon: <AcUnit /> },
      { name: 'Security', icon: <Security /> },
    ],
    landlord: {
      name: 'John Smith',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      phone: '+1 (555) 123-4567',
      email: 'john.smith@findmyhome.com',
      rating: 4.8,
      properties: 12,
    }
  }

  const handleShare = () => {
    if (navigator.share) {
      navigator.share({
        title: property.title,
        text: property.description,
        url: window.location.href,
      })
    } else {
      navigator.clipboard.writeText(window.location.href)
      alert('Link copied to clipboard!')
    }
  }

  const handleContact = (method: 'phone' | 'email' | 'message') => {
    switch (method) {
      case 'phone':
        window.open(`tel:${property.landlord.phone}`)
        break
      case 'email':
        window.open(`mailto:${property.landlord.email}`)
        break
      case 'message':
        alert('Messaging feature coming soon!')
        break
    }
  }

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      {/* App Bar */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            Property Details
          </Typography>
          <IconButton color="inherit" onClick={() => setIsFavorite(!isFavorite)}>
            {isFavorite ? <Favorite sx={{ color: 'red' }} /> : <FavoriteBorder />}
          </IconButton>
          <IconButton color="inherit" onClick={handleShare}>
            <Share />
          </IconButton>
        </Toolbar>
      </AppBar>

      <Container maxWidth="lg" sx={{ py: 3 }}>
        <Grid container spacing={3}>
          {/* Image Gallery */}
          <Grid item xs={12} md={8}>
            <Card sx={{ mb: 3 }}>
              <Box
                component="img"
                src={property.images[selectedImageIndex]}
                alt={property.title}
                loading="lazy"
                referrerPolicy="no-referrer"
                onError={(e: any) => { e.currentTarget.src = "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1600&q=80"; }}
                sx={{
                  width: '100%',
                  height: { xs: 240, md: 480 },
                  objectFit: 'cover',
                  cursor: 'pointer',
                }}
                onClick={() => setShowFullscreenGallery(true)}
              />
            </Card>
            
            <ImageList cols={4} gap={8}>
              {property.images.map((image, index) => (
                <ImageListItem key={index}>
                  <Box
                    component="img"
                    src={image}
                    alt={`Property ${index + 1}`}
                    loading="lazy"
                    referrerPolicy="no-referrer"
                    onError={(e: any) => { e.currentTarget.src = "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=400&q=80"; }}
                    sx={{
                      width: '100%',
                      height: { xs: 60, md: 80 },
                      objectFit: 'cover',
                      cursor: 'pointer',
                      border: selectedImageIndex === index ? '3px solid' : 'none',
                      borderColor: 'primary.main',
                      borderRadius: 1,
                    }}
                    onClick={() => setSelectedImageIndex(index)}
                  />
                </ImageListItem>
              ))}
            </ImageList>
          </Grid>

          {/* Property Info */}
          <Grid item xs={12} md={4}>
            <Card sx={{ mb: 3 }}>
              <CardContent>
                <Typography variant="h4" sx={{ fontWeight: 700, mb: 1 }}>
                  ₦{property.price.toLocaleString()}
                </Typography>
                <Typography variant="h5" sx={{ fontWeight: 600, mb: 2 }}>
                  {property.title}
                </Typography>
                
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <LocationOn sx={{ mr: 1, color: 'text.secondary' }} />
                  <Typography variant="body1" color="text.secondary">
                    {property.location}
                  </Typography>
                </Box>

                <Box sx={{ display: 'flex', gap: 3, mb: 3 }}>
                  <Box sx={{ display: 'flex', alignItems: 'center' }}>
                    <Bed sx={{ mr: 1, color: 'text.secondary' }} />
                    <Typography>{property.bedrooms} Beds</Typography>
                  </Box>
                  <Box sx={{ display: 'flex', alignItems: 'center' }}>
                    <Bathtub sx={{ mr: 1, color: 'text.secondary' }} />
                    <Typography>{property.bathrooms} Baths</Typography>
                  </Box>
                  <Box sx={{ display: 'flex', alignItems: 'center' }}>
                    <SquareFoot sx={{ mr: 1, color: 'text.secondary' }} />
                    <Typography>{property.area} sqft</Typography>
                  </Box>
                </Box>

                <Chip label={property.type} variant="outlined" color="primary" />
              </CardContent>
            </Card>

            {/* Landlord Contact */}
            <Card>
              <CardContent>
                <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
                  Contact Owner
                </Typography>
                
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                  <Avatar src={property.landlord.avatar} imgProps={{ referrerPolicy: 'no-referrer' }} sx={{ mr: 2 }} />
                  <Box>
                    <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                      {property.landlord.name}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      {property.landlord.properties} properties • ⭐ {property.landlord.rating}
                    </Typography>
                  </Box>
                </Box>

                <Box sx={{ display: 'flex', gap: 1, mb: 2 }}>
                  <Button
                    variant="contained"
                    startIcon={<Phone />}
                    onClick={() => handleContact('phone')}
                    fullWidth
                  >
                    Call
                  </Button>
                  <Button
                    variant="outlined"
                    startIcon={<Email />}
                    onClick={() => handleContact('email')}
                    fullWidth
                  >
                    Email
                  </Button>
                </Box>
                
                <Button
                  variant="outlined"
                  startIcon={<Message />}
                  onClick={() => handleContact('message')}
                  fullWidth
                >
                  Send Message
                </Button>
              </CardContent>
            </Card>
          </Grid>

          {/* Description */}
          <Grid item xs={12}>
            <Card sx={{ mb: 3 }}>
              <CardContent>
                <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
                  Description
                </Typography>
                <Typography variant="body1" sx={{ lineHeight: 1.6 }}>
                  {property.description}
                </Typography>
              </CardContent>
            </Card>
          </Grid>

          {/* Amenities */}
          <Grid item xs={12}>
            <Card>
              <CardContent>
                <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
                  Amenities
                </Typography>
                <List>
                  {property.amenities.map((amenity, index) => (
                    <ListItem key={index} divider={index < property.amenities.length - 1}>
                      <ListItemIcon>{amenity.icon}</ListItemIcon>
                      <ListItemText primary={amenity.name} />
                    </ListItem>
                  ))}
                </List>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      </Container>

      {/* Fullscreen Gallery Dialog */}
      <Dialog
        open={showFullscreenGallery}
        onClose={() => setShowFullscreenGallery(false)}
        maxWidth="lg"
        fullWidth
      >
        <Box sx={{ position: 'relative' }}>
          <IconButton
            sx={{ position: 'absolute', top: 8, right: 8, zIndex: 1, backgroundColor: 'rgba(0,0,0,0.5)' }}
            onClick={() => setShowFullscreenGallery(false)}
          >
            <Close sx={{ color: 'white' }} />
          </IconButton>
          <DialogContent sx={{ p: 0 }}>
            <Box
              component="img"
              src={property.images[selectedImageIndex]}
              alt={property.title}
              sx={{ width: '100%', height: 'auto', maxHeight: '80vh', objectFit: 'contain' }}
            />
          </DialogContent>
        </Box>
      </Dialog>
    </Box>
  )
}

export default PropertyDetailScreen
