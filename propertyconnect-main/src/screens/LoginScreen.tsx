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
  Divider,
  IconButton,
  Alert,
  CircularProgress,
  InputAdornment,
} from '@mui/material'
import {
  Home,
  Google,
  Apple,
  Facebook,
  Visibility,
  VisibilityOff,
} from '@mui/icons-material'

const LoginScreen: React.FC = () => {
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState('')

  // Mock credentials for testing
  const mockCredentials = {
    'landlord@propertyconnect.com': 'landlord123',
    'tenant@propertyconnect.com': 'tenant123',
    'admin@propertyconnect.com': 'admin123',
  }

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')

    if (!email || !password) {
      setError('Please fill in all fields')
      return
    }

    setIsLoading(true)

    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 2000))

    // Check mock credentials
    if (mockCredentials[email as keyof typeof mockCredentials] === password) {
      navigate('/', { replace: true })
    } else {
      setError('Invalid credentials. Please check your email and password.')
    }

    setIsLoading(false)
  }

  const handleForgotPassword = () => {
    alert('Password reset link sent to your email')
  }

  const handleSocialLogin = (provider: string) => {
    alert(`${provider} login will be available soon`)
  }

  const handleSignUp = () => {
    alert('Sign up feature coming soon')
  }

  return (
    <Box
      sx={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#fafafa',
        p: 2,
      }}
    >
      <Container maxWidth="sm">
        <Box sx={{ textAlign: 'center', mb: 4 }}>
          {/* App Logo */}
          <Box
            sx={{
              width: 100,
              height: 100,
              backgroundColor: 'primary.main',
              borderRadius: 2,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              mx: 'auto',
              mb: 3,
              boxShadow: 1,
            }}
          >
            <Home sx={{ fontSize: 48, color: 'white' }} />
          </Box>

          {/* Welcome Text */}
          <Typography variant="h4" sx={{ fontWeight: 700, mb: 1 }}>
            Welcome Back
          </Typography>
          <Typography variant="body1" sx={{ color: 'text.secondary' }}>
            Sign in to your PropertyConnect account
          </Typography>
        </Box>

        <Card sx={{ p: 2 }}>
          <CardContent>
            <form onSubmit={handleLogin}>
              {error && (
                <Alert severity="error" sx={{ mb: 2 }}>
                  {error}
                </Alert>
              )}

              <TextField
                fullWidth
                label="Email"
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                sx={{ mb: 2 }}
                variant="outlined"
              />

              <TextField
                fullWidth
                label="Password"
                type={showPassword ? 'text' : 'password'}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                sx={{ mb: 2 }}
                variant="outlined"
                InputProps={{
                  endAdornment: (
                    <InputAdornment position="end">
                      <IconButton
                        onClick={() => setShowPassword(!showPassword)}
                        edge="end"
                      >
                        {showPassword ? <VisibilityOff /> : <Visibility />}
                      </IconButton>
                    </InputAdornment>
                  ),
                }}
              />

              <Box sx={{ textAlign: 'right', mb: 3 }}>
                <Button
                  variant="text"
                  size="small"
                  onClick={handleForgotPassword}
                  sx={{ textTransform: 'none' }}
                >
                  Forgot Password?
                </Button>
              </Box>

              <Button
                type="submit"
                fullWidth
                variant="contained"
                size="large"
                disabled={isLoading}
                sx={{ mb: 3, py: 1.5 }}
              >
                {isLoading ? <CircularProgress size={24} /> : 'Sign In'}
              </Button>
            </form>

            <Divider sx={{ my: 3 }}>
              <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                Or continue with
              </Typography>
            </Divider>

            {/* Social Login Buttons */}
            <Box sx={{ display: 'flex', gap: 1, mb: 3 }}>
              <Button
                fullWidth
                variant="outlined"
                onClick={() => handleSocialLogin('Google')}
                startIcon={<Google />}
                sx={{ textTransform: 'none' }}
              >
                Google
              </Button>
              <Button
                fullWidth
                variant="outlined"
                onClick={() => handleSocialLogin('Apple')}
                startIcon={<Apple />}
                sx={{ textTransform: 'none' }}
              >
                Apple
              </Button>
              <Button
                fullWidth
                variant="outlined"
                onClick={() => handleSocialLogin('Facebook')}
                startIcon={<Facebook />}
                sx={{ textTransform: 'none' }}
              >
                Facebook
              </Button>
            </Box>

            {/* Sign Up Link */}
            <Box sx={{ textAlign: 'center' }}>
              <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                New user?{' '}
                <Button
                  variant="text"
                  onClick={handleSignUp}
                  sx={{ textTransform: 'none', p: 0, minWidth: 'auto' }}
                >
                  Sign Up
                </Button>
              </Typography>
            </Box>
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default LoginScreen
