import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, FormControl, InputLabel, Select, MenuItem } from '@mui/material'
import { ArrowBack } from '@mui/icons-material'

const languages = ['English (US)', 'English (UK)', 'French', 'Spanish', 'German']

const ProfileLanguageScreen: React.FC = () => {
  const navigate = useNavigate()
  const [lang, setLang] = useState('English (US)')

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Language</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 2 }}>
        <Card>
          <CardContent>
            <FormControl fullWidth>
              <InputLabel>Language</InputLabel>
              <Select value={lang} label="Language" onChange={e => setLang(e.target.value)}>
                {languages.map(l => (<MenuItem key={l} value={l}>{l}</MenuItem>))}
              </Select>
            </FormControl>
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default ProfileLanguageScreen
