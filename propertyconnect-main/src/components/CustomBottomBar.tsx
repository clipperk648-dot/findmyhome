import React from 'react'
import { useNavigate, useLocation } from 'react-router-dom'
import {
  BottomNavigation,
  BottomNavigationAction,
  Paper,
  Box,
} from '@mui/material'
import {
  Home,
  HomeOutlined,
  Search,
  SearchOutlined,
  Favorite,
  FavoriteBorder,
  Person,
  PersonOutline,
} from '@mui/icons-material'

export enum BottomBarVariant {
  STANDARD = 'standard',
  LANDLORD = 'landlord',
  SEEKER = 'seeker',
}

interface CustomBottomBarProps {
  currentIndex: number
  onTap: (index: number) => void
  variant?: BottomBarVariant
}

const CustomBottomBar: React.FC<CustomBottomBarProps> = ({
  currentIndex,
  onTap,
  variant = BottomBarVariant.STANDARD,
}) => {
  const navigate = useNavigate()
  const location = useLocation()

  const getNavigationItems = () => {
    switch (variant) {
      case BottomBarVariant.LANDLORD:
        return [
          { icon: <HomeOutlined />, selectedIcon: <Home />, label: 'Properties', route: '/browse' },
          { icon: <SearchOutlined />, selectedIcon: <Search />, label: 'Add Listing', route: '/create-listing' },
          { icon: <PersonOutline />, selectedIcon: <Person />, label: 'Tenants', route: '/browse' },
          { icon: <PersonOutline />, selectedIcon: <Person />, label: 'Analytics', route: '/browse' },
        ]
      case BottomBarVariant.SEEKER:
        return [
          { icon: <SearchOutlined />, selectedIcon: <Search />, label: 'Search', route: '/browse' },
          { icon: <FavoriteBorder />, selectedIcon: <Favorite />, label: 'Favorites', route: '/browse' },
          { icon: <HomeOutlined />, selectedIcon: <Home />, label: 'Map View', route: '/browse' },
          { icon: <PersonOutline />, selectedIcon: <Person />, label: 'Profile', route: '/profile' },
        ]
      case BottomBarVariant.STANDARD:
      default:
        return [
          { icon: <HomeOutlined />, selectedIcon: <Home />, label: 'Home', route: '/' },
          { icon: <SearchOutlined />, selectedIcon: <Search />, label: 'Search', route: '/browse' },
          { icon: <FavoriteBorder />, selectedIcon: <Favorite />, label: 'Favorites', route: '/browse' },
          { icon: <PersonOutline />, selectedIcon: <Person />, label: 'Profile', route: '/profile' },
        ]
    }
  }

  const handleNavigation = (index: number, route: string) => {
    onTap(index)
    if (location.pathname !== route) {
      navigate(route, { replace: true })
    }
  }

  const items = getNavigationItems()

  return (
    <Paper
      sx={{
        position: 'fixed',
        bottom: 0,
        left: 0,
        right: 0,
        zIndex: 1000,
        borderRadius: 0,
        boxShadow: '0 -2px 8px rgba(0,0,0,0.1)',
        display: { xs: 'block', md: 'none' },
      }}
      elevation={3}
    >
      <Box sx={{ pb: 'env(safe-area-inset-bottom)' }}>
        <BottomNavigation
          value={currentIndex}
          onChange={(_, newValue) => {
            const item = items[newValue]
            handleNavigation(newValue, item.route)
          }}
          sx={{
            height: 80,
            '& .MuiBottomNavigationAction-root': {
              minWidth: 'auto',
              '& .MuiBottomNavigationAction-label': {
                fontSize: '12px',
                fontWeight: 500,
              },
            },
          }}
        >
          {items.map((item, index) => (
            <BottomNavigationAction
              key={index}
              label={item.label}
              icon={currentIndex === index ? item.selectedIcon : item.icon}
            />
          ))}
        </BottomNavigation>
      </Box>
    </Paper>
  )
}

export default CustomBottomBar
