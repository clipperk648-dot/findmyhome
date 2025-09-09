import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  Button,
  Card,
  CardContent,
  Stepper,
  Step,
  StepLabel,
  RadioGroup,
  FormControlLabel,
  Radio,
  FormControl,
  FormLabel,
  Grid,
} from '@mui/material'
import { ArrowBack, ArrowForward, SkipNext } from '@mui/icons-material'

interface OnboardingSlide {
  title: string
  description: string
  imageUrl: string
}

const OnboardingFlow: React.FC = () => {
  const navigate = useNavigate()
  const [currentStep, setCurrentStep] = useState(0)
  const [selectedUserType, setSelectedUserType] = useState<string>('')

  const onboardingSlides: OnboardingSlide[] = [
    {
      title: "Find Your Perfect Property",
      description: "Discover thousands of properties for rent and sale. Filter by location, price, and amenities to find exactly what you're looking for.",
      imageUrl: "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1600&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG91c2V8ZW58MHx8MHx8fDA%3D"
    },
    {
      title: "List & Manage Properties",
      description: "Easily create property listings with photos and detailed descriptions. Manage inquiries and connect with potential tenants or buyers.",
      imageUrl: "https://images.unsplash.com/photo-1582407947304-fd86f028f716?auto=format&fit=crop&w=1600&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHx8MA%3D%3D"
    },
    {
      title: "Connect & Communicate", 
      description: "Chat directly with property owners and seekers. Schedule viewings, negotiate prices, and close deals seamlessly.",
      imageUrl: "https://images.unsplash.com/photo-1556761175-b413da4baf72?auto=format&fit=crop&w=1600&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cmVhbCUyMGVzdGF0ZSUyMGFnZW50fGVufDB8fDB8fHww"
    },
    {
      title: "Save & Compare Favorites",
      description: "Bookmark properties you love and compare them side by side. Never lose track of your dream home or investment opportunity.",
      imageUrl: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1600&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG91c2V8ZW58MHx8MHx8fDA%3D"
    }
  ]

  const totalSteps = onboardingSlides.length + 1 // +1 for user type selection

  const handleNext = () => {
    if (currentStep < totalSteps - 1) {
      setCurrentStep(currentStep + 1)
    } else {
      completeOnboarding()
    }
  }

  const handleBack = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1)
    }
  }

  const handleSkip = () => {
    completeOnboarding()
  }

  const completeOnboarding = () => {
    // Save onboarding completion and user type to localStorage
    localStorage.setItem('onboarding_completed', 'true')
    if (selectedUserType) {
      localStorage.setItem('user_type', selectedUserType)
    }
    navigate('/login', { replace: true })
  }

  const canProceed = () => {
    if (currentStep < onboardingSlides.length) {
      return true
    }
    return selectedUserType !== ''
  }

  const renderOnboardingSlide = (slide: OnboardingSlide) => (
    <Container maxWidth="md">
      <Grid container spacing={4} alignItems="center" sx={{ minHeight: '60vh' }}>
        <Grid item xs={12} md={6}>
          <Box
            component="img"
            src={slide.imageUrl}
            alt={slide.title}
            loading="lazy"
            referrerPolicy="no-referrer"
            onError={(e: any) => { e.currentTarget.src = "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80"; }}
            sx={{
              width: '100%',
              height: { xs: 200, md: 320 },
              objectFit: 'cover',
              borderRadius: 2,
              boxShadow: 2,
            }}
          />
        </Grid>
        <Grid item xs={12} md={6}>
          <Typography
            variant="h3"
            sx={{ fontWeight: 700, mb: 2, color: 'primary.main' }}
          >
            {slide.title}
          </Typography>
          <Typography
            variant="h6"
            sx={{ color: 'text.secondary', lineHeight: 1.6 }}
          >
            {slide.description}
          </Typography>
        </Grid>
      </Grid>
    </Container>
  )

  const renderUserTypeSelection = () => (
    <Container maxWidth="sm">
      <Box sx={{ textAlign: 'center', py: 4 }}>
        <Typography variant="h3" sx={{ fontWeight: 700, mb: 2 }}>
          What brings you here?
        </Typography>
        <Typography variant="h6" sx={{ color: 'text.secondary', mb: 4 }}>
          Help us personalize your experience
        </Typography>

        <Card sx={{ p: 3 }}>
          <CardContent>
            <FormControl component="fieldset" fullWidth>
              <FormLabel component="legend" sx={{ mb: 2 }}>
                <Typography variant="h6">Select your role:</Typography>
              </FormLabel>
              <RadioGroup
                value={selectedUserType}
                onChange={(e) => setSelectedUserType(e.target.value)}
              >
                <FormControlLabel
                  value="tenant"
                  control={<Radio />}
                  label={
                    <Box>
                      <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                        Looking for a Property
                      </Typography>
                      <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                        I want to rent or buy a property
                      </Typography>
                    </Box>
                  }
                  sx={{ mb: 2 }}
                />
                <FormControlLabel
                  value="landlord"
                  control={<Radio />}
                  label={
                    <Box>
                      <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                        Property Owner/Agent
                      </Typography>
                      <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                        I want to list and manage properties
                      </Typography>
                    </Box>
                  }
                  sx={{ mb: 2 }}
                />
                <FormControlLabel
                  value="both"
                  control={<Radio />}
                  label={
                    <Box>
                      <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                        Both
                      </Typography>
                      <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                        I'm interested in both renting/buying and listing
                      </Typography>
                    </Box>
                  }
                />
              </RadioGroup>
            </FormControl>
          </CardContent>
        </Card>
      </Box>
    </Container>
  )

  return (
    <Box sx={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      {/* Header with progress */}
      <Box sx={{ p: 2, borderBottom: 1, borderColor: 'divider' }}>
        <Container maxWidth="lg">
          <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
            <Typography variant="h6" sx={{ fontWeight: 600 }}>
              Findmyhome
            </Typography>
            <Button
              startIcon={<SkipNext />}
              onClick={handleSkip}
              sx={{ textTransform: 'none' }}
            >
              Skip
            </Button>
          </Box>
          <Stepper activeStep={currentStep} alternativeLabel>
            {Array.from({ length: totalSteps }).map((_, index) => (
              <Step key={index}>
                <StepLabel />
              </Step>
            ))}
          </Stepper>
        </Container>
      </Box>

      {/* Main content */}
      <Box sx={{ flexGrow: 1, display: 'flex', alignItems: 'center', py: 4 }}>
        {currentStep < onboardingSlides.length 
          ? renderOnboardingSlide(onboardingSlides[currentStep])
          : renderUserTypeSelection()
        }
      </Box>

      {/* Navigation controls */}
      <Box sx={{ p: 2, borderTop: 1, borderColor: 'divider' }}>
        <Container maxWidth="lg">
          <Box sx={{ display: 'flex', justifyContent: 'space-between' }}>
            <Button
              startIcon={<ArrowBack />}
              onClick={handleBack}
              disabled={currentStep === 0}
              sx={{ textTransform: 'none' }}
            >
              Back
            </Button>
            <Button
              endIcon={<ArrowForward />}
              onClick={handleNext}
              variant="contained"
              disabled={!canProceed()}
              sx={{ textTransform: 'none' }}
            >
              {currentStep === totalSteps - 1 ? 'Get Started' : 'Next'}
            </Button>
          </Box>
        </Container>
      </Box>
    </Box>
  )
}

export default OnboardingFlow
