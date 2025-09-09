import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  TextField,
  Button,
  Card,
  CardContent,
  Grid,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Stepper,
  Step,
  StepLabel,
  AppBar,
  Toolbar,
  IconButton,
  Chip,
  Paper,
  InputAdornment,
  FormControlLabel,
  Checkbox,
  LinearProgress,
} from '@mui/material'
import {
  ArrowBack,
  CloudUpload,
  LocationOn,
  AttachMoney,
  Home,
  Delete,
} from '@mui/icons-material'

interface PropertyForm {
  title: string
  description: string
  price: string
  propertyType: string
  bedrooms: string
  bathrooms: string
  area: string
  location: string
  amenities: string[]
  images: File[]
}

const PropertyListingCreation: React.FC = () => {
  const navigate = useNavigate()
  const [activeStep, setActiveStep] = useState(0)
  const [isSubmitting, setIsSubmitting] = useState(false)
  
  const [formData, setFormData] = useState<PropertyForm>({
    title: '',
    description: '',
    price: '',
    propertyType: '',
    bedrooms: '',
    bathrooms: '',
    area: '',
    location: '',
    amenities: [],
    images: [],
  })

  const steps = ['Property Details', 'Photos & Media', 'Review & Publish']
  
  const propertyTypes = ['Apartment', 'House', 'Penthouse', 'Villa', 'Studio', 'Townhouse']
  const availableAmenities = [
    'Parking', 'Swimming Pool', 'Gym', 'WiFi', 'Air Conditioning', 
    'Security', 'Garden', 'Balcony', 'Elevator', 'Laundry'
  ]

  const handleInputChange = (field: keyof PropertyForm, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }))
  }

  const handleAmenityToggle = (amenity: string) => {
    setFormData(prev => ({
      ...prev,
      amenities: prev.amenities.includes(amenity)
        ? prev.amenities.filter(a => a !== amenity)
        : [...prev.amenities, amenity]
    }))
  }

  const handleImageUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(event.target.files || [])
    setFormData(prev => ({ ...prev, images: [...prev.images, ...files] }))
  }

  const removeImage = (index: number) => {
    setFormData(prev => ({
      ...prev,
      images: prev.images.filter((_, i) => i !== index)
    }))
  }

  const handleNext = () => {
    setActiveStep(prev => Math.min(prev + 1, steps.length - 1))
  }

  const handleBack = () => {
    setActiveStep(prev => Math.max(prev - 1, 0))
  }

  const handleSubmit = async () => {
    setIsSubmitting(true)
    
    // Simulate submission delay
    await new Promise(resolve => setTimeout(resolve, 2000))
    
    alert('Property listing created successfully!')
    navigate('/browse')
  }

  const isStepValid = (step: number) => {
    switch (step) {
      case 0:
        return formData.title && formData.price && formData.propertyType && formData.location
      case 1:
        return formData.images.length > 0
      case 2:
        return true
      default:
        return false
    }
  }

  const renderPropertyDetails = () => (
    <Grid container spacing={3}>
      <Grid item xs={12}>
        <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
          Basic Information
        </Typography>
      </Grid>
      
      <Grid item xs={12}>
        <TextField
          fullWidth
          label="Property Title"
          value={formData.title}
          onChange={(e) => handleInputChange('title', e.target.value)}
          placeholder="e.g., Modern Downtown Apartment"
        />
      </Grid>

      <Grid item xs={12}>
        <TextField
          fullWidth
          multiline
          rows={4}
          label="Description"
          value={formData.description}
          onChange={(e) => handleInputChange('description', e.target.value)}
          placeholder="Describe your property in detail..."
        />
      </Grid>

      <Grid item xs={12} md={6}>
        <TextField
          fullWidth
          label="Price"
          value={formData.price}
          onChange={(e) => handleInputChange('price', e.target.value)}
          InputProps={{
            startAdornment: <InputAdornment position="start">₦</InputAdornment>,
          }}
          placeholder="250000"
        />
      </Grid>

      <Grid item xs={12} md={6}>
        <FormControl fullWidth>
          <InputLabel>Property Type</InputLabel>
          <Select
            value={formData.propertyType}
            onChange={(e) => handleInputChange('propertyType', e.target.value)}
          >
            {propertyTypes.map(type => (
              <MenuItem key={type} value={type}>{type}</MenuItem>
            ))}
          </Select>
        </FormControl>
      </Grid>

      <Grid item xs={4}>
        <TextField
          fullWidth
          label="Bedrooms"
          type="number"
          value={formData.bedrooms}
          onChange={(e) => handleInputChange('bedrooms', e.target.value)}
        />
      </Grid>

      <Grid item xs={4}>
        <TextField
          fullWidth
          label="Bathrooms"
          type="number"
          value={formData.bathrooms}
          onChange={(e) => handleInputChange('bathrooms', e.target.value)}
        />
      </Grid>

      <Grid item xs={4}>
        <TextField
          fullWidth
          label="Area (sqft)"
          type="number"
          value={formData.area}
          onChange={(e) => handleInputChange('area', e.target.value)}
        />
      </Grid>

      <Grid item xs={12}>
        <TextField
          fullWidth
          label="Location"
          value={formData.location}
          onChange={(e) => handleInputChange('location', e.target.value)}
          InputProps={{
            startAdornment: <InputAdornment position="start"><LocationOn /></InputAdornment>,
          }}
          placeholder="Enter full address or area"
        />
      </Grid>

      <Grid item xs={12}>
        <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
          Amenities
        </Typography>
        <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
          {availableAmenities.map(amenity => (
            <FormControlLabel
              key={amenity}
              control={
                <Checkbox
                  checked={formData.amenities.includes(amenity)}
                  onChange={() => handleAmenityToggle(amenity)}
                />
              }
              label={amenity}
            />
          ))}
        </Box>
      </Grid>
    </Grid>
  )

  const renderPhotosUpload = () => (
    <Grid container spacing={3}>
      <Grid item xs={12}>
        <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
          Property Photos
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
          Upload high-quality photos to attract more potential buyers/tenants
        </Typography>
      </Grid>

      <Grid item xs={12}>
        <Paper
          sx={{
            border: '2px dashed #ccc',
            borderRadius: 2,
            p: 4,
            textAlign: 'center',
            cursor: 'pointer',
            '&:hover': { borderColor: 'primary.main' }
          }}
          onClick={() => document.getElementById('image-upload')?.click()}
        >
          <CloudUpload sx={{ fontSize: 48, color: 'text.secondary', mb: 2 }} />
          <Typography variant="h6" sx={{ mb: 1 }}>
            Upload Photos
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Click to browse or drag and drop images here
          </Typography>
          <input
            id="image-upload"
            type="file"
            multiple
            accept="image/*"
            onChange={handleImageUpload}
            style={{ display: 'none' }}
          />
        </Paper>
      </Grid>

      {formData.images.length > 0 && (
        <Grid item xs={12}>
          <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
            Uploaded Photos ({formData.images.length})
          </Typography>
          <Grid container spacing={2}>
            {formData.images.map((image, index) => (
              <Grid item xs={6} sm={4} md={3} key={index}>
                <Box sx={{ position: 'relative' }}>
                  <Box
                    component="img"
                    src={URL.createObjectURL(image)}
                    alt={`Upload ${index + 1}`}
                    sx={{
                      width: '100%',
                      height: 120,
                      objectFit: 'cover',
                      borderRadius: 1,
                    }}
                  />
                  <IconButton
                    size="small"
                    sx={{
                      position: 'absolute',
                      top: 4,
                      right: 4,
                      backgroundColor: 'rgba(255, 255, 255, 0.8)',
                    }}
                    onClick={() => removeImage(index)}
                  >
                    <Delete />
                  </IconButton>
                </Box>
              </Grid>
            ))}
          </Grid>
        </Grid>
      )}
    </Grid>
  )

  const renderReview = () => (
    <Grid container spacing={3}>
      <Grid item xs={12}>
        <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
          Review Your Listing
        </Typography>
      </Grid>

      <Grid item xs={12}>
        <Card variant="outlined">
          <CardContent>
            <Typography variant="h5" sx={{ fontWeight: 600, mb: 1 }}>
              {formData.title}
            </Typography>
            <Typography variant="h4" color="primary" sx={{ fontWeight: 700, mb: 2 }}>
              ₦{Number(formData.price).toLocaleString()}
            </Typography>
            
            <Box sx={{ display: 'flex', gap: 2, mb: 2 }}>
              <Chip label={formData.propertyType} color="primary" variant="outlined" />
              <Chip label={`${formData.bedrooms} Beds`} variant="outlined" />
              <Chip label={`${formData.bathrooms} Baths`} variant="outlined" />
              <Chip label={`${formData.area} sqft`} variant="outlined" />
            </Box>

            <Typography variant="body1" sx={{ mb: 2 }}>
              📍 {formData.location}
            </Typography>

            <Typography variant="body2" sx={{ mb: 2 }}>
              {formData.description}
            </Typography>

            {formData.amenities.length > 0 && (
              <Box>
                <Typography variant="subtitle2" sx={{ mb: 1 }}>Amenities:</Typography>
                <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5 }}>
                  {formData.amenities.map(amenity => (
                    <Chip key={amenity} label={amenity} size="small" />
                  ))}
                </Box>
              </Box>
            )}
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  )

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      {/* App Bar */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            Create Property Listing
          </Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="md" sx={{ py: 3 }}>
        {/* Progress Stepper */}
        <Card sx={{ mb: 4 }}>
          <CardContent>
            <Stepper activeStep={activeStep} alternativeLabel>
              {steps.map((label) => (
                <Step key={label}>
                  <StepLabel>{label}</StepLabel>
                </Step>
              ))}
            </Stepper>
          </CardContent>
        </Card>

        {/* Main Content */}
        <Card>
          <CardContent sx={{ p: 4 }}>
            {activeStep === 0 && renderPropertyDetails()}
            {activeStep === 1 && renderPhotosUpload()}
            {activeStep === 2 && renderReview()}
          </CardContent>
        </Card>

        {/* Navigation Buttons */}
        <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 3 }}>
          <Button
            onClick={handleBack}
            disabled={activeStep === 0}
            sx={{ textTransform: 'none' }}
          >
            Back
          </Button>
          
          {activeStep === steps.length - 1 ? (
            <Button
              variant="contained"
              onClick={handleSubmit}
              disabled={isSubmitting || !isStepValid(activeStep)}
              sx={{ textTransform: 'none' }}
            >
              {isSubmitting ? 'Publishing...' : 'Publish Listing'}
            </Button>
          ) : (
            <Button
              variant="contained"
              onClick={handleNext}
              disabled={!isStepValid(activeStep)}
              sx={{ textTransform: 'none' }}
            >
              Next
            </Button>
          )}
        </Box>

        {isSubmitting && (
          <Box sx={{ mt: 2 }}>
            <LinearProgress />
          </Box>
        )}
      </Container>
    </Box>
  )
}

export default PropertyListingCreation
