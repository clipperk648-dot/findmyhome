import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  List,
  ListItem,
  ListItemAvatar,
  ListItemText,
  Avatar,
  AppBar,
  Toolbar,
  IconButton,
  Card,
  Divider,
  Chip,
  Button,
  Menu,
  MenuItem,
  Tabs,
  Tab,
} from '@mui/material'
import {
  ArrowBack,
  MoreVert,
  Home,
  Favorite,
  TrendingUp,
  Notifications,
  CheckCircle,
  Info,
  Warning,
  Circle,
} from '@mui/icons-material'

import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

interface Notification {
  id: string
  title: string
  message: string
  timestamp: string
  read: boolean
  type: 'property' | 'favorite' | 'price' | 'system' | 'reminder'
  icon: string
  actionUrl?: string
  priority: 'high' | 'medium' | 'low'
}

const NotificationsScreen: React.FC = () => {
  const navigate = useNavigate()
  const [currentTab, setCurrentTab] = useState(0)
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)
  const [currentBottomIndex, setCurrentBottomIndex] = useState(2)

  const notifications: Notification[] = [
    {
      id: '1',
      title: 'New Property Match',
      message: 'A new apartment in Downtown Seattle matches your saved search criteria.',
      timestamp: '5 minutes ago',
      read: false,
      type: 'property',
      icon: 'home',
      actionUrl: '/property/123',
      priority: 'high'
    },
    {
      id: '2',
      title: 'Price Drop Alert',
      message: 'The Luxury Family House you favorited has dropped in price by ₦25,000,000.',
      timestamp: '1 hour ago',
      read: false,
      type: 'price',
      icon: 'trending_down',
      actionUrl: '/property/456',
      priority: 'high'
    },
    {
      id: '3',
      title: 'Property Saved to Favorites',
      message: 'Modern Downtown Apartment has been added to your favorites.',
      timestamp: '3 hours ago',
      read: true,
      type: 'favorite',
      icon: 'favorite',
      priority: 'low'
    },
    {
      id: '4',
      title: 'Viewing Reminder',
      message: 'Don\'t forget your property viewing tomorrow at 2:00 PM for Cozy Studio Loft.',
      timestamp: '1 day ago',
      read: false,
      type: 'reminder',
      icon: 'schedule',
      actionUrl: '/calendar',
      priority: 'medium'
    },
    {
      id: '5',
      title: 'System Update',
      message: 'Findmyhome has been updated with new features and improvements.',
      timestamp: '2 days ago',
      read: true,
      type: 'system',
      icon: 'system_update',
      priority: 'low'
    },
    {
      id: '6',
      title: 'New Message',
      message: 'Sarah Johnson sent you a message about your property listing.',
      timestamp: '3 days ago',
      read: true,
      type: 'property',
      icon: 'message',
      actionUrl: '/messages/1',
      priority: 'medium'
    },
    {
      id: '7',
      title: 'Market Report Available',
      message: 'Your monthly market report for Seattle area is now available.',
      timestamp: '1 week ago',
      read: true,
      type: 'system',
      icon: 'analytics',
      actionUrl: '/reports',
      priority: 'low'
    }
  ]

  const tabLabels = ['All', 'Unread', 'Properties', 'System']

  const getFilteredNotifications = () => {
    switch (currentTab) {
      case 1: // Unread
        return notifications.filter(n => !n.read)
      case 2: // Properties
        return notifications.filter(n => ['property', 'favorite', 'price', 'reminder'].includes(n.type))
      case 3: // System
        return notifications.filter(n => n.type === 'system')
      default: // All
        return notifications
    }
  }

  const getNotificationIcon = (notification: Notification) => {
    const iconProps = {
      sx: {
        color: notification.read ? 'text.secondary' : getPriorityColor(notification.priority),
        fontSize: 24
      }
    }

    switch (notification.type) {
      case 'property':
        return <Home {...iconProps} />
      case 'favorite':
        return <Favorite {...iconProps} />
      case 'price':
        return <TrendingUp {...iconProps} />
      case 'system':
        return <Info {...iconProps} />
      case 'reminder':
        return <Warning {...iconProps} />
      default:
        return <Notifications {...iconProps} />
    }
  }

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high':
        return '#f44336'
      case 'medium':
        return '#ff9800'
      default:
        return '#4caf50'
    }
  }

  const getPriorityLabel = (priority: string) => {
    switch (priority) {
      case 'high':
        return 'High'
      case 'medium':
        return 'Medium'
      default:
        return 'Low'
    }
  }

  const markAllAsRead = () => {
    // Implementation to mark all as read
    setAnchorEl(null)
  }

  const clearAll = () => {
    // Implementation to clear all notifications
    setAnchorEl(null)
  }

  const handleNotificationClick = (notification: Notification) => {
    if (notification.actionUrl) {
      navigate(notification.actionUrl)
    }
  }

  const unreadCount = notifications.filter(n => !n.read).length
  const filteredNotifications = getFilteredNotifications()

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa', pb: 12 }}>
      {/* Header */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Box sx={{ flexGrow: 1 }}>
            <Typography variant="h6">Notifications</Typography>
            {unreadCount > 0 && (
              <Typography variant="body2" sx={{ opacity: 0.8 }}>
                {unreadCount} unread notification{unreadCount > 1 ? 's' : ''}
              </Typography>
            )}
          </Box>
          <IconButton
            color="inherit"
            onClick={(e) => setAnchorEl(e.currentTarget)}
          >
            <MoreVert />
          </IconButton>
        </Toolbar>
      </AppBar>

      {/* Menu */}
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={() => setAnchorEl(null)}
      >
        <MenuItem onClick={markAllAsRead}>Mark all as read</MenuItem>
        <MenuItem onClick={clearAll}>Clear all</MenuItem>
      </Menu>

      <Container maxWidth="md" sx={{ py: 2 }}>
        {/* Tabs */}
        <Card sx={{ mb: 2 }}>
          <Tabs
            value={currentTab}
            onChange={(_, newValue) => setCurrentTab(newValue)}
            variant="fullWidth"
          >
            {tabLabels.map((label, index) => (
              <Tab
                key={index}
                label={
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    {label}
                    {index === 1 && unreadCount > 0 && (
                      <Chip
                        label={unreadCount}
                        size="small"
                        color="primary"
                        sx={{ minWidth: 20, height: 20, fontSize: '10px' }}
                      />
                    )}
                  </Box>
                }
              />
            ))}
          </Tabs>
        </Card>

        {/* Notifications List */}
        {filteredNotifications.length === 0 ? (
          <Card sx={{ p: 4, textAlign: 'center' }}>
            <Notifications sx={{ fontSize: 64, color: 'text.secondary', mb: 2 }} />
            <Typography variant="h6" color="text.secondary" sx={{ mb: 1 }}>
              No notifications
            </Typography>
            <Typography variant="body2" color="text.secondary">
              {currentTab === 1 ? 'All caught up! You have no unread notifications.' : 'You\'ll see notifications here when they arrive.'}
            </Typography>
          </Card>
        ) : (
          <Card>
            <List sx={{ p: 0 }}>
              {filteredNotifications.map((notification, index) => (
                <React.Fragment key={notification.id}>
                  <ListItem
                    button
                    onClick={() => handleNotificationClick(notification)}
                    sx={{
                      py: 2,
                      backgroundColor: !notification.read ? 'rgba(25, 118, 210, 0.04)' : 'transparent',
                      borderLeft: !notification.read ? '4px solid' : '4px solid transparent',
                      borderLeftColor: !notification.read ? getPriorityColor(notification.priority) : 'transparent',
                    }}
                  >
                    <ListItemAvatar>
                      <Avatar sx={{ backgroundColor: 'transparent' }}>
                        {getNotificationIcon(notification)}
                      </Avatar>
                    </ListItemAvatar>
                    
                    <ListItemText
                      primary={
                        <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', mb: 0.5 }}>
                          <Typography
                            variant="subtitle1"
                            component="span"
                            sx={{
                              fontWeight: !notification.read ? 600 : 400,
                            }}
                          >
                            {notification.title}
                          </Typography>
                          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                            {!notification.read && (
                              <Circle sx={{ color: 'primary.main', fontSize: 8 }} />
                            )}
                            <Typography variant="caption" component="span" color="text.secondary">
                              {notification.timestamp}
                            </Typography>
                          </Box>
                        </Box>
                      }
                      secondary={
                        <Box>
                          <Typography
                            variant="body2"
                            component="span"
                            color="text.secondary"
                            sx={{
                              fontWeight: !notification.read ? 500 : 400,
                              mb: 1,
                              display: 'block',
                            }}
                          >
                            {notification.message}
                          </Typography>
                          <Chip
                            label={getPriorityLabel(notification.priority)}
                            size="small"
                            sx={{
                              backgroundColor: getPriorityColor(notification.priority),
                              color: 'white',
                              fontSize: '10px',
                              height: 20,
                            }}
                          />
                        </Box>
                      }
                      primaryTypographyProps={{ component: 'div' }}
                      secondaryTypographyProps={{ component: 'div' }}
                    />
                  </ListItem>
                  {index < filteredNotifications.length - 1 && <Divider />}
                </React.Fragment>
              ))}
            </List>
          </Card>
        )}

        {/* Mark All Read Button */}
        {unreadCount > 0 && currentTab !== 1 && (
          <Box sx={{ mt: 2, textAlign: 'center' }}>
            <Button
              variant="outlined"
              startIcon={<CheckCircle />}
              onClick={markAllAsRead}
            >
              Mark All as Read
            </Button>
          </Box>
        )}
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

export default NotificationsScreen
