import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AppBar, Toolbar, IconButton, Typography, Container, Box, Card, CardContent, Button, List, ListItem, ListItemText, TextField, Dialog, DialogTitle, DialogContent, DialogActions } from '@mui/material'
import { ArrowBack, Add } from '@mui/icons-material'

const ProfilePaymentsScreen: React.FC = () => {
  const navigate = useNavigate()
  const [open, setOpen] = useState(false)
  const [cards, setCards] = useState<{ brand: string; last4: string }[]>([])

  const addCard = (brand: string, last4: string) => setCards(prev => [...prev, { brand, last4 }])

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Payment Methods</Typography>
          <Button color="inherit" startIcon={<Add />} onClick={() => setOpen(true)}>Add</Button>
        </Toolbar>
      </AppBar>

      <Container maxWidth="sm" sx={{ py: 2 }}>
        <Card>
          <CardContent>
            <List>
              {cards.length === 0 ? (
                <ListItem><ListItemText primary="No payment methods" secondary="Add a card to pay for premium features" /></ListItem>
              ) : (
                cards.map((c, i) => (
                  <ListItem key={i}><ListItemText primary={`${c.brand} •••• ${c.last4}`} /></ListItem>
                ))
              )}
            </List>
          </CardContent>
        </Card>
      </Container>

      <Dialog open={open} onClose={() => setOpen(false)}>
        <DialogTitle>Add Card</DialogTitle>
        <DialogContent>
          <TextField autoFocus fullWidth label="Card Brand" margin="dense" id="brand" />
          <TextField fullWidth label="Last 4 Digits" margin="dense" id="last4" />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={() => {
            const brand = (document.getElementById('brand') as HTMLInputElement).value
            const last4 = (document.getElementById('last4') as HTMLInputElement).value
            if (brand && last4) addCard(brand, last4)
            setOpen(false)
          }} variant="contained">Save</Button>
        </DialogActions>
      </Dialog>
    </Box>
  )
}

export default ProfilePaymentsScreen
