import React from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, Button } from '@mui/material'
import { ArrowBack, History } from '@mui/icons-material'

const HistoryScreen: React.FC = () => {
  const navigate = useNavigate()

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Recently Viewed</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="md" sx={{ py: 2 }}>
        <Card>
          <CardContent sx={{ textAlign: 'center', py: 6 }}>
            <History sx={{ fontSize: 48, color: 'text.secondary', mb: 1 }} />
            <Typography variant="h6" sx={{ mb: 1 }}>No recently viewed properties</Typography>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
              Explore properties and your recently viewed items will show up here.
            </Typography>
            <Button variant="contained" onClick={() => navigate('/browse')}>Browse Properties</Button>
          </CardContent>
        </Card>
      </Container>
    </Box>
  )
}

export default HistoryScreen
