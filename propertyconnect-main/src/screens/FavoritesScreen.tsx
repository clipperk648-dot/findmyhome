import React from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Grid, Card, CardContent, Button } from '@mui/material'
import { ArrowBack, Favorite } from '@mui/icons-material'
import PropertyCard from '../components/PropertyCard'

const mockFavorites: any[] = []

const FavoritesScreen: React.FC = () => {
  const navigate = useNavigate()

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Favorites</Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="lg" sx={{ py: 2 }}>
        {mockFavorites.length === 0 ? (
          <Card>
            <CardContent sx={{ textAlign: 'center', py: 6 }}>
              <Favorite sx={{ fontSize: 48, color: 'text.secondary', mb: 1 }} />
              <Typography variant="h6" sx={{ mb: 1 }}>No favorites yet</Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                Save properties you love and they will show up here.
              </Typography>
              <Button variant="contained" onClick={() => navigate('/browse')}>Browse Properties</Button>
            </CardContent>
          </Card>
        ) : (
          <Grid container spacing={2}>
            {mockFavorites.map((p) => (
              <Grid item xs={12} sm={6} md={4} key={p.id}>
                <PropertyCard property={p as any} onTap={() => navigate(`/property/${p.id}`)} />
              </Grid>
            ))}
          </Grid>
        )}
      </Container>
    </Box>
  )
}

export default FavoritesScreen
