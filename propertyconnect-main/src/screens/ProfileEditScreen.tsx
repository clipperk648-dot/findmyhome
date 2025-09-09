import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, TextField, Button, Grid } from '@mui/material'
import { ArrowBack, Save } from '@mui/icons-material'

const ProfileEditScreen: React.FC = () => {
  const navigate = useNavigate()
  const [name, setName] = useState('John Smith')
  const [email, setEmail] = useState('john.smith@findmyhome.com')
  const [phone, setPhone] = useState('+1 (555) 123-4567')
  const [location, setLocation] = useState('Seattle, WA')

  useEffect(() => {
    const saved = localStorage.getItem('profile_edit')
    if (saved) {
      const data = JSON.parse(saved)
      setName(data.name || name)
      setEmail(data.email || email)
      setPhone(data.phone || phone)
      setLocation(data.location || location)
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleSave = () => {
    localStorage.setItem('profile_edit', JSON.stringify({ name, email, phone, location }))
    navigate(-1)
  }

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Edit Profile</Typography>
          <Button color="inherit" startIcon={<Save />} onClick={handleSave}>Save</Button>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 3 }}>
        <Grid container spacing={2}>
          <Grid item xs={12}><TextField fullWidth label="Full Name" value={name} onChange={e => setName(e.target.value)} /></Grid>
          <Grid item xs={12}><TextField fullWidth label="Email" value={email} onChange={e => setEmail(e.target.value)} /></Grid>
          <Grid item xs={12}><TextField fullWidth label="Phone" value={phone} onChange={e => setPhone(e.target.value)} /></Grid>
          <Grid item xs={12}><TextField fullWidth label="Location" value={location} onChange={e => setLocation(e.target.value)} /></Grid>
        </Grid>
      </Container>
    </Box>
  )
}

export default ProfileEditScreen
