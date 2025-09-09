import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  Button,
  Card,
  CardContent,
  CardMedia,
  Grid,
  Chip,
  IconButton,
  AppBar,
  Toolbar,
  Badge,
  Paper,
  TextField,
  InputAdornment,
  Divider,
  Avatar,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
} from '@mui/material'
import {
  Search,
  Notifications,
  Message,
  AccountCircle,
  LocationOn,
  ArrowForward,
  Star,
  Verified,
  SupportAgent,
  TrendingUp,
  Security,
  Speed,
  Support,
  Home as HomeIcon,
  Apartment,
  Villa,
  Business,
  KeyboardArrowLeft,
  KeyboardArrowRight,
} from '@mui/icons-material'

import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

interface SlideData {
  id: number
  title: string
  subtitle: string
  description: string
  imageUrl: string
  buttonText: string
  category: 'rent' | 'sale'
  stats: {
    properties: string
    avgPrice: string
  }
}

const HomeScreen: React.FC = () => {
  const navigate = useNavigate()
  const [currentSlide, setCurrentSlide] = useState(0)
  const [currentBottomIndex, setCurrentBottomIndex] = useState(0)

  // Hero slideshow data
  const slides: SlideData[] = [
    {
      id: 1,
      title: "Find Your Perfect Rental",
      subtitle: "Properties for Rent",
      description: "Discover thousands of rental properties from apartments to luxury homes. Find your next home with flexible lease terms and verified landlords.",
      imageUrl: "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1600&q=80",
      buttonText: "Browse Rentals",
      category: "rent",
      stats: {
        properties: "15,000+",
        avgPrice: "₦1,200,000/yr"
      }
    },
    {
      id: 2,
      title: "Invest in Your Future",
      subtitle: "Properties for Sale",
      description: "Explore premium properties for sale. From first-time buyers to seasoned investors, find the perfect property to call home or add to your portfolio.",
      imageUrl: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1600&q=80",
      buttonText: "Browse Sales",
      category: "sale",
      stats: {
        properties: "8,500+",
        avgPrice: "₦85,000,000"
      }
    },
    {
      id: 3,
      title: "List Your Property",
      subtitle: "For Landlords & Sellers",
      description: "Reach thousands of qualified tenants and buyers. Our platform makes it easy to list, manage, and rent or sell your properties with professional tools.",
      imageUrl: "https://images.unsplash.com/photo-1582407947304-fd86f028f716?auto=format&fit=crop&w=1600&q=80",
      buttonText: "List Property",
      category: "rent",
      stats: {
        properties: "Join 12,000+",
        avgPrice: "landlords"
      }
    }
  ]

  // Auto-advance slideshow
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentSlide((prev) => (prev + 1) % slides.length)
    }, 5000)
    return () => clearInterval(timer)
  }, [slides.length])

  const handleSlideChange = (direction: 'next' | 'prev') => {
    if (direction === 'next') {
      setCurrentSlide((prev) => (prev + 1) % slides.length)
    } else {
      setCurrentSlide((prev) => (prev - 1 + slides.length) % slides.length)
    }
  }

  const propertyCategories = [
    {
      icon: <Apartment sx={{ fontSize: 40 }} />,
      title: "Apartments",
      count: "8,500+",
      description: "Modern apartments in prime locations",
      color: "#2196F3"
    },
    {
      icon: <HomeIcon sx={{ fontSize: 40 }} />,
      title: "Houses",
      count: "6,200+",
      description: "Family homes with gardens and space",
      color: "#4CAF50"
    },
    {
      icon: <Villa sx={{ fontSize: 40 }} />,
      title: "Luxury Villas",
      count: "1,800+",
      description: "Premium properties for discerning clients",
      color: "#FF9800"
    },
    {
      icon: <Business sx={{ fontSize: 40 }} />,
      title: "Commercial",
      count: "2,400+",
      description: "Office spaces and retail properties",
      color: "#9C27B0"
    }
  ]

  const features = [
    {
      icon: <Verified sx={{ fontSize: 40, color: "#4CAF50" }} />,
      title: "Verified Properties",
      description: "All listings are verified by our team for authenticity and accuracy"
    },
    {
      icon: <Security sx={{ fontSize: 40, color: "#2196F3" }} />,
      title: "Secure Transactions",
      description: "Safe and secure payment processing with escrow protection"
    },
    {
      icon: <Speed sx={{ fontSize: 40, color: "#FF9800" }} />,
      title: "Quick Matches",
      description: "Advanced matching algorithm to find your perfect property fast"
    },
    {
      icon: <Support sx={{ fontSize: 40, color: "#9C27B0" }} />,
      title: "24/7 Support",
      description: "Round-the-clock customer support to assist with your needs"
    }
  ]

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa', pb: 12 }}>
      {/* Header with Navigation */}
      <AppBar position="sticky" elevation={1} sx={{ backgroundColor: 'white', color: 'text.primary' }}>
        <Toolbar>
          <Box sx={{ display: 'flex', alignItems: 'center', flexGrow: 1 }}>
            <HomeIcon sx={{ mr: 1, color: 'primary.main' }} />
            <Typography variant="h6" sx={{ fontWeight: 700, color: 'primary.main' }}>
              Findmyhome
            </Typography>
          </Box>
          
          <Box sx={{ display: 'flex', gap: 1 }}>
            <IconButton onClick={() => navigate('/notifications')}>
              <Badge badgeContent={3} color="error">
                <Notifications />
              </Badge>
            </IconButton>
            <IconButton onClick={() => navigate('/messages')}>
              <Badge badgeContent={2} color="error">
                <Message />
              </Badge>
            </IconButton>
            <IconButton onClick={() => navigate('/profile')}>
              <AccountCircle />
            </IconButton>
          </Box>
        </Toolbar>
      </AppBar>

      {/* Search Bar */}
      <Container maxWidth="lg" sx={{ mt: 2, mb: 3 }}>
        <Paper sx={{ p: 2, borderRadius: 3 }}>
          <TextField
            fullWidth
            placeholder="Search properties by location, type, or features..."
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <Search sx={{ color: 'text.secondary' }} />
                </InputAdornment>
              ),
              endAdornment: (
                <InputAdornment position="end">
                  <Button variant="contained" sx={{ borderRadius: 2 }}>
                    Search
                  </Button>
                </InputAdornment>
              ),
              sx: { borderRadius: 2 }
            }}
            onClick={() => navigate('/browse')}
          />
        </Paper>
      </Container>

      {/* Hero Slideshow */}
      <Container maxWidth="lg" sx={{ mb: 4 }}>
        <Box sx={{ position: 'relative', borderRadius: 3, overflow: 'hidden' }}>
          <Box
            sx={{
              height: { xs: 240, md: 420 },
              backgroundImage: `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(${slides[currentSlide].imageUrl})`,
              backgroundSize: 'cover',
              backgroundPosition: 'center',
              display: 'flex',
              alignItems: 'center',
              color: 'white',
              position: 'relative',
            }}
          >
            {/* Slide Content */}
            <Container maxWidth="md">
              <Box sx={{ textAlign: 'center' }}>
                <Chip 
                  label={slides[currentSlide].subtitle}
                  sx={{ 
                    backgroundColor: 'rgba(255,255,255,0.2)', 
                    color: 'white',
                    mb: 2,
                    fontWeight: 600
                  }}
                />
                <Typography variant="h3" sx={{ fontWeight: 700, mb: 2, fontSize: { xs: '1.6rem', sm: '2rem', md: '2.4rem' } }}>
                  {slides[currentSlide].title}
                </Typography>
                <Typography variant="h6" sx={{ mb: 3, opacity: 0.9, fontSize: { xs: '0.95rem', md: '1.15rem' }, lineHeight: { xs: 1.4, md: 1.6 } }}>
                  {slides[currentSlide].description}
                </Typography>
                
                <Box sx={{ display: 'flex', justifyContent: 'center', gap: 4, mb: 3 }}>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" sx={{ fontWeight: 700, fontSize: { xs: '1.25rem', md: '1.75rem' } }}>
                      {slides[currentSlide].stats.properties}
                    </Typography>
                    <Typography variant="body2">Properties</Typography>
                  </Box>
                  <Box sx={{ textAlign: 'center' }}>
                    <Typography variant="h4" sx={{ fontWeight: 700, fontSize: { xs: '1.25rem', md: '1.75rem' } }}>
                      {slides[currentSlide].stats.avgPrice}
                    </Typography>
                    <Typography variant="body2">Average Price</Typography>
                  </Box>
                </Box>

                <Button
                  variant="contained"
                  size="large"
                  endIcon={<ArrowForward />}
                  onClick={() => navigate(slides[currentSlide].category === 'rent' ? '/browse?type=rent' : '/browse?type=sale')}
                  sx={{
                    backgroundColor: 'white',
                    color: 'primary.main',
                    px: 4,
                    py: 1.5,
                    '&:hover': { backgroundColor: 'rgba(255,255,255,0.9)' }
                  }}
                >
                  {slides[currentSlide].buttonText}
                </Button>
              </Box>
            </Container>

            {/* Navigation Arrows */}
            <IconButton
              sx={{ position: 'absolute', left: 16, backgroundColor: 'rgba(255,255,255,0.2)' }}
              onClick={() => handleSlideChange('prev')}
            >
              <KeyboardArrowLeft sx={{ color: 'white' }} />
            </IconButton>
            <IconButton
              sx={{ position: 'absolute', right: 16, backgroundColor: 'rgba(255,255,255,0.2)' }}
              onClick={() => handleSlideChange('next')}
            >
              <KeyboardArrowRight sx={{ color: 'white' }} />
            </IconButton>

            {/* Slide Indicators */}
            <Box sx={{ position: 'absolute', bottom: 16, left: '50%', transform: 'translateX(-50%)', display: 'flex', gap: 1 }}>
              {slides.map((_, index) => (
                <Box
                  key={index}
                  sx={{
                    width: 12,
                    height: 12,
                    borderRadius: '50%',
                    backgroundColor: currentSlide === index ? 'white' : 'rgba(255,255,255,0.5)',
                    cursor: 'pointer',
                  }}
                  onClick={() => setCurrentSlide(index)}
                />
              ))}
            </Box>
          </Box>
        </Box>
      </Container>

      {/* Property Categories */}
      <Container maxWidth="lg" sx={{ mb: 4 }}>
        <Typography variant="h4" sx={{ fontWeight: 700, mb: 1, textAlign: 'center' }}>
          Browse by Category
        </Typography>
        <Typography variant="body1" color="text.secondary" sx={{ textAlign: 'center', mb: 4 }}>
          Find the perfect property type that matches your needs
        </Typography>
        
        <Grid container spacing={3}>
          {propertyCategories.map((category, index) => (
            <Grid item xs={6} md={3} key={index}>
              <Card
                sx={{
                  textAlign: 'center',
                  p: 3,
                  cursor: 'pointer',
                  transition: 'transform 0.2s',
                  '&:hover': { transform: 'translateY(-4px)' }
                }}
                onClick={() => navigate(`/browse?category=${category.title.toLowerCase()}`)}
              >
                <Box sx={{ color: category.color, mb: 2 }}>
                  {category.icon}
                </Box>
                <Typography variant="h6" sx={{ fontWeight: 600, mb: 1 }}>
                  {category.title}
                </Typography>
                <Typography variant="h5" sx={{ fontWeight: 700, color: 'primary.main', mb: 1 }}>
                  {category.count}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  {category.description}
                </Typography>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Container>

      {/* Features Section */}
      <Container maxWidth="lg" sx={{ mb: 4 }}>
        <Typography variant="h4" sx={{ fontWeight: 700, mb: 1, textAlign: 'center' }}>
          Why Choose Findmyhome?
        </Typography>
        <Typography variant="body1" color="text.secondary" sx={{ textAlign: 'center', mb: 4 }}>
          We provide the most comprehensive and secure platform for your property needs
        </Typography>
        
        <Grid container spacing={3}>
          {features.map((feature, index) => (
            <Grid item xs={12} md={6} key={index}>
              <Box sx={{ display: 'flex', p: 2 }}>
                <Box sx={{ mr: 3 }}>
                  {feature.icon}
                </Box>
                <Box>
                  <Typography variant="h6" sx={{ fontWeight: 600, mb: 1 }}>
                    {feature.title}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {feature.description}
                  </Typography>
                </Box>
              </Box>
            </Grid>
          ))}
        </Grid>
      </Container>

      {/* Customer Service Section */}
      <Container maxWidth="lg" sx={{ mb: 4 }}>
        <Paper sx={{ p: 4, textAlign: 'center', backgroundColor: 'primary.main', color: 'white' }}>
          <SupportAgent sx={{ fontSize: 60, mb: 2 }} />
          <Typography variant="h5" sx={{ fontWeight: 700, mb: 2 }}>
            Need Help? We're Here for You
          </Typography>
          <Typography variant="body1" sx={{ mb: 3, opacity: 0.9 }}>
            Our expert customer service team is available 24/7 to assist you with any questions about properties, rentals, sales, or technical support.
          </Typography>
          <Box sx={{ display: 'flex', justifyContent: 'center', gap: 2, flexWrap: 'wrap' }}>
            <Button
              variant="contained"
              sx={{ backgroundColor: 'white', color: 'primary.main' }}
              onClick={() => navigate('/support')}
            >
              Contact Support
            </Button>
            <Button
              variant="outlined"
              sx={{ borderColor: 'white', color: 'white' }}
              onClick={() => navigate('/support/chat')}
            >
              Live Chat
            </Button>
          </Box>
        </Paper>
      </Container>

      {/* Stats Section */}
      <Container maxWidth="lg" sx={{ mb: 4 }}>
        <Grid container spacing={4} sx={{ textAlign: 'center' }}>
          <Grid item xs={6} md={3}>
            <Typography variant="h3" sx={{ fontWeight: 700, color: 'primary.main' }}>
              25K+
            </Typography>
            <Typography variant="body1" color="text.secondary">
              Properties Listed
            </Typography>
          </Grid>
          <Grid item xs={6} md={3}>
            <Typography variant="h3" sx={{ fontWeight: 700, color: 'primary.main' }}>
              15K+
            </Typography>
            <Typography variant="body1" color="text.secondary">
              Happy Customers
            </Typography>
          </Grid>
          <Grid item xs={6} md={3}>
            <Typography variant="h3" sx={{ fontWeight: 700, color: 'primary.main' }}>
              98%
            </Typography>
            <Typography variant="body1" color="text.secondary">
              Success Rate
            </Typography>
          </Grid>
          <Grid item xs={6} md={3}>
            <Typography variant="h3" sx={{ fontWeight: 700, color: 'primary.main' }}>
              24/7
            </Typography>
            <Typography variant="body1" color="text.secondary">
              Customer Support
            </Typography>
          </Grid>
        </Grid>
      </Container>

      {/* Bottom Navigation */}
      <CustomBottomBar
        currentIndex={currentBottomIndex}
        onTap={setCurrentBottomIndex}
        variant={BottomBarVariant.STANDARD}
      />
    </Box>
  )
}

export default HomeScreen
