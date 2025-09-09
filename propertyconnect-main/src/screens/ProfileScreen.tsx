import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  Avatar,
  Button,
  Card,
  CardContent,
  Grid,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  ListItemButton,
  Divider,
  Switch,
  FormControlLabel,
  AppBar,
  Toolbar,
  IconButton,
  Badge,
  Paper,
} from '@mui/material'
import {
  ArrowBack,
  Edit,
  Home,
  Favorite,
  History,
  Settings,
  Help,
  Logout,
  Person,
  Email,
  Phone,
  LocationOn,
  Notifications,
  Security,
  Language,
  PaymentOutlined,
  Verified,
  Star,
} from '@mui/icons-material'

import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

const ProfileScreen: React.FC = () => {
  const navigate = useNavigate()
  const [notificationsEnabled, setNotificationsEnabled] = useState(true)
  const [currentBottomIndex, setCurrentBottomIndex] = useState(3)

  // Mock user data
  const user = {
    name: "John Smith",
    email: "john.smith@findmyhome.com",
    phone: "+1 (555) 123-4567",
    location: "Seattle, WA",
    avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100",
    memberSince: "January 2023",
    verified: true,
    rating: 4.8,
    totalReviews: 24,
    userType: "Premium Member",
    favoriteProperties: 12,
    viewedProperties: 48,
    savedSearches: 6
  }

  const menuSections = [
    {
      title: "Property Management",
      items: [
        { icon: <Home />, title: "My Properties", subtitle: "Manage your listings", action: () => navigate('/my-properties') },
        { icon: <Favorite />, title: "Favorites", subtitle: `${user.favoriteProperties} saved properties`, action: () => navigate('/favorites') },
        { icon: <History />, title: "Recently Viewed", subtitle: `${user.viewedProperties} properties`, action: () => navigate('/history') },
      ]
    },
    {
      title: "Account Settings",
      items: [
        { icon: <Person />, title: "Personal Information", subtitle: "Update your profile", action: () => navigate('/profile/edit') },
        { icon: <PaymentOutlined />, title: "Payment Methods", subtitle: "Manage billing", action: () => navigate('/profile/payments') },
        { icon: <Notifications />, title: "Notification Settings", subtitle: "Customize alerts", action: () => navigate('/profile/notifications') },
        { icon: <Security />, title: "Privacy & Security", subtitle: "Account security", action: () => navigate('/profile/security') },
      ]
    },
    {
      title: "Support & Information",
      items: [
        { icon: <Help />, title: "Help Center", subtitle: "FAQs and guides", action: () => navigate('/support') },
        { icon: <Language />, title: "Language", subtitle: "English (US)", action: () => navigate('/profile/language') },
        { icon: <Settings />, title: "App Settings", subtitle: "Preferences", action: () => navigate('/profile/settings') },
      ]
    }
  ]

  const stats = [
    { label: "Properties Viewed", value: user.viewedProperties },
    { label: "Favorites", value: user.favoriteProperties },
    { label: "Saved Searches", value: user.savedSearches },
  ]

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa' }}>
      {/* Header */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            Profile
          </Typography>
          <IconButton color="inherit" onClick={() => navigate('/profile/edit')}>
            <Edit />
          </IconButton>
        </Toolbar>
      </AppBar>

      <Container maxWidth="md" sx={{ py: 3, pb: 12 }}>
        {/* Profile Header */}
        <Card sx={{ mb: 3 }}>
          <CardContent sx={{ textAlign: 'center', p: 4 }}>
            <Box sx={{ position: 'relative', display: 'inline-block', mb: 2 }}>
              <Avatar
                imgProps={{ referrerPolicy: 'no-referrer' }}
                src={user.avatar}
                sx={{ width: 100, height: 100, mx: 'auto', mb: 2 }}
              />
              {user.verified && (
                <Badge
                  overlap="circular"
                  anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
                  badgeContent={
                    <Verified sx={{ color: '#4CAF50', backgroundColor: 'white', borderRadius: '50%' }} />
                  }
                />
              )}
            </Box>
            
            <Typography variant="h5" sx={{ fontWeight: 700, mb: 1 }}>
              {user.name}
            </Typography>
            
            <Typography variant="body1" color="primary" sx={{ fontWeight: 600, mb: 1 }}>
              {user.userType}
            </Typography>
            
            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'center', mb: 2 }}>
              <Star sx={{ color: '#FFD700', mr: 0.5 }} />
              <Typography variant="body2" sx={{ mr: 1 }}>
                {user.rating}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                ({user.totalReviews} reviews)
              </Typography>
            </Box>
            
            <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
              Member since {user.memberSince}
            </Typography>

            <Box sx={{ display: 'flex', justifyContent: 'center', gap: 1, mb: 3 }}>
              <Button variant="contained" onClick={() => navigate('/profile/edit')}>
                Edit Profile
              </Button>
              <Button variant="outlined" onClick={() => navigate('/support')}>
                Get Help
              </Button>
            </Box>

            {/* Contact Info */}
            <Box sx={{ textAlign: 'left' }}>
              <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                <Email sx={{ mr: 2, color: 'text.secondary' }} />
                <Typography variant="body2">{user.email}</Typography>
              </Box>
              <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                <Phone sx={{ mr: 2, color: 'text.secondary' }} />
                <Typography variant="body2">{user.phone}</Typography>
              </Box>
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <LocationOn sx={{ mr: 2, color: 'text.secondary' }} />
                <Typography variant="body2">{user.location}</Typography>
              </Box>
            </Box>
          </CardContent>
        </Card>

        {/* Stats Cards */}
        <Grid container spacing={2} sx={{ mb: 3 }}>
          {stats.map((stat, index) => (
            <Grid item xs={4} key={index}>
              <Paper sx={{ p: 2, textAlign: 'center' }}>
                <Typography variant="h4" sx={{ fontWeight: 700, color: 'primary.main' }}>
                  {stat.value}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  {stat.label}
                </Typography>
              </Paper>
            </Grid>
          ))}
        </Grid>

        {/* Menu Sections */}
        {menuSections.map((section, sectionIndex) => (
          <Card key={sectionIndex} sx={{ mb: 2 }}>
            <CardContent sx={{ p: 0 }}>
              <Typography variant="h6" sx={{ p: 2, pb: 1, fontWeight: 600 }}>
                {section.title}
              </Typography>
              <List>
                {section.items.map((item, itemIndex) => (
                  <React.Fragment key={itemIndex}>
                    <ListItemButton onClick={item.action}>
                      <ListItemIcon>{item.icon}</ListItemIcon>
                      <ListItemText
                        primary={item.title}
                        secondary={item.subtitle}
                      />
                    </ListItemButton>
                    {itemIndex < section.items.length - 1 && <Divider />}
                  </React.Fragment>
                ))}
              </List>
            </CardContent>
          </Card>
        ))}

        {/* Quick Settings */}
        <Card sx={{ mb: 3 }}>
          <CardContent>
            <Typography variant="h6" sx={{ mb: 2, fontWeight: 600 }}>
              Quick Settings
            </Typography>
            <FormControlLabel
              control={
                <Switch
                  checked={notificationsEnabled}
                  onChange={(e) => setNotificationsEnabled(e.target.checked)}
                />
              }
              label="Push Notifications"
            />
          </CardContent>
        </Card>

        {/* Logout Section */}
        <Box sx={{ mt: 4, pt: 3, borderTop: '1px solid rgba(0,0,0,0.12)' }}>
          <Typography variant="h6" sx={{ mb: 2, fontWeight: 600, color: 'text.secondary' }}>
            Account Actions
          </Typography>
          <Button
            fullWidth
            variant="contained"
            color="error"
            startIcon={<Logout />}
            onClick={() => {
              // Clear user session
              localStorage.clear()
              navigate('/login')
            }}
            sx={{
              mb: 2,
              py: 1.5,
              fontSize: '16px',
              fontWeight: 600,
              borderRadius: 2,
              boxShadow: 2,
              '&:hover': {
                boxShadow: 4
              }
            }}
          >
            Sign Out
          </Button>
        </Box>
      </Container>

      {/* Bottom Navigation */}
      <CustomBottomBar
        currentIndex={currentBottomIndex}
        onTap={setCurrentBottomIndex}
        variant={BottomBarVariant.STANDARD}
      />
    </Box>
  )
}

export default ProfileScreen
