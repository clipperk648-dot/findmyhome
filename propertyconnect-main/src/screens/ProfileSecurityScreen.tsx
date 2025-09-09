import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, TextField, Button, FormControlLabel, Switch } from '@mui/material'
import { ArrowBack, Lock } from '@mui/icons-material'

const ProfileSecurityScreen: React.FC = () => {
  const navigate = useNavigate()
  const [twoFA, setTwoFA] = useState(false)

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Security</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 2 }}>
        <Card sx={{ mb: 2 }}>
          <CardContent>
            <Typography variant="subtitle1" sx={{ mb: 2 }}>Change Password</Typography>
            <TextField fullWidth label="Current Password" type="password" sx={{ mb: 2 }} />
            <TextField fullWidth label="New Password" type="password" sx={{ mb: 2 }} />
            <TextField fullWidth label="Confirm New Password" type="password" sx={{ mb: 2 }} />
            <Button variant="contained">Update Password</Button>
          </CardContent>
        </Card>
        <Card>
          <CardContent>
            <FormControlLabel control={<Switch checked={twoFA} onChange={e => setTwoFA(e.target.checked)} />} label="Enable Two-Factor Authentication" />
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default ProfileSecurityScreen
