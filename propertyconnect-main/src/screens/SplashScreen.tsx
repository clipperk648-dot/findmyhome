import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { 
  Box, 
  Typography, 
  CircularProgress, 
  Container,
  Fade,
  Zoom,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button
} from '@mui/material'
import { Home } from '@mui/icons-material'

const SplashScreen: React.FC = () => {
  const navigate = useNavigate()
  const [isInitialized, setIsInitialized] = useState(false)
  const [showRetryDialog, setShowRetryDialog] = useState(false)
  const [showContent, setShowContent] = useState(false)

  useEffect(() => {
    const timer = setTimeout(() => setShowContent(true), 100)
    initializeApp()
    return () => clearTimeout(timer)
  }, [])

  const initializeApp = async () => {
    try {
      await Promise.all([
        checkAuthenticationStatus(),
        loadUserPreferences(),
        initializeLocationServices(),
        cachePropertyData(),
      ])

      setIsInitialized(true)

      // Wait for animation to complete before navigation
      setTimeout(() => {
        navigate('/', { replace: true })
      }, 3000)
    } catch (error) {
      setShowRetryDialog(true)
    }
  }

  const checkAuthenticationStatus = async () => {
    await new Promise(resolve => setTimeout(resolve, 500))
  }

  const loadUserPreferences = async () => {
    await new Promise(resolve => setTimeout(resolve, 300))
  }

  const initializeLocationServices = async () => {
    await new Promise(resolve => setTimeout(resolve, 400))
  }

  const cachePropertyData = async () => {
    await new Promise(resolve => setTimeout(resolve, 600))
  }

  const getLoadingText = () => {
    return isInitialized ? 'Ready to explore properties!' : 'Initializing...'
  }

  const handleRetry = () => {
    setShowRetryDialog(false)
    initializeApp()
  }

  return (
    <Box
      sx={{
        minHeight: '100vh',
        background: 'linear-gradient(135deg, #2196F3 0%, #1976D2 50%, #1565C0 100%)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      <Container maxWidth="sm">
        <Box
          sx={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            textAlign: 'center',
          }}
        >
          {/* Logo Section */}
          <Zoom in={showContent} timeout={1000}>
            <Box
              sx={{
                width: 120,
                height: 120,
                backgroundColor: 'rgba(255, 255, 255, 0.15)',
                borderRadius: 3,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                mb: 4,
                boxShadow: '0 10px 30px rgba(0, 0, 0, 0.1)',
              }}
            >
              <Home sx={{ fontSize: 60, color: 'white' }} />
            </Box>
          </Zoom>

          <Fade in={showContent} timeout={1500}>
            <Box>
              {/* App Name */}
              <Typography
                variant="h3"
                sx={{
                  color: 'white',
                  fontWeight: 700,
                  letterSpacing: 1.2,
                  mb: 1,
                }}
              >
                Findmyhome
              </Typography>

              {/* App Tagline */}
              <Typography
                variant="h6"
                sx={{
                  color: 'rgba(255, 255, 255, 0.9)',
                  fontWeight: 400,
                  letterSpacing: 0.5,
                  mb: 8,
                }}
              >
                Connecting Properties & People
              </Typography>
            </Box>
          </Fade>

          {/* Loading Section */}
          <Fade in={showContent} timeout={2000}>
            <Box
              sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
              }}
            >
              <CircularProgress
                size={40}
                thickness={3}
                sx={{
                  color: 'rgba(255, 255, 255, 0.8)',
                  mb: 3,
                }}
              />
              <Typography
                variant="body1"
                sx={{
                  color: 'rgba(255, 255, 255, 0.8)',
                  fontWeight: 400,
                }}
              >
                {getLoadingText()}
              </Typography>
            </Box>
          </Fade>
        </Box>
      </Container>

      {/* Retry Dialog */}
      <Dialog
        open={showRetryDialog}
        onClose={() => {}}
        maxWidth="sm"
        fullWidth
      >
        <DialogTitle>Connection Error</DialogTitle>
        <DialogContent>
          <Typography>
            Unable to initialize the app. Please check your internet connection and try again.
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleRetry} variant="contained">
            Retry
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default SplashScreen
