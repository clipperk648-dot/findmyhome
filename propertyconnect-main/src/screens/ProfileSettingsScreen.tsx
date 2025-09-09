import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, FormGroup, FormControlLabel, Switch } from '@mui/material'
import { ArrowBack } from '@mui/icons-material'

const ProfileSettingsScreen: React.FC = () => {
  const navigate = useNavigate()
  const [darkMode, setDarkMode] = useState(false)
  const [dataSaver, setDataSaver] = useState(false)

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>App Settings</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 2 }}>
        <Card>
          <CardContent>
            <FormGroup>
              <FormControlLabel control={<Switch checked={darkMode} onChange={e => setDarkMode(e.target.checked)} />} label="Dark Mode" />
              <FormControlLabel control={<Switch checked={dataSaver} onChange={e => setDataSaver(e.target.checked)} />} label="Data Saver" />
            </FormGroup>
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default ProfileSettingsScreen
