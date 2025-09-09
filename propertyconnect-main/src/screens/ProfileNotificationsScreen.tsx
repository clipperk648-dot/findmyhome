import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, FormGroup, FormControlLabel, Switch } from '@mui/material'
import { ArrowBack } from '@mui/icons-material'

const ProfileNotificationsScreen: React.FC = () => {
  const navigate = useNavigate()
  const [email, setEmail] = useState(true)
  const [push, setPush] = useState(true)
  const [sms, setSms] = useState(false)

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Notification Settings</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 2 }}>
        <Card>
          <CardContent>
            <FormGroup>
              <FormControlLabel control={<Switch checked={email} onChange={e => setEmail(e.target.checked)} />} label="Email Notifications" />
              <FormControlLabel control={<Switch checked={push} onChange={e => setPush(e.target.checked)} />} label="Push Notifications" />
              <FormControlLabel control={<Switch checked={sms} onChange={e => setSms(e.target.checked)} />} label="SMS Notifications" />
            </FormGroup>
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default ProfileNotificationsScreen
