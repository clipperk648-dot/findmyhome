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
  Badge,
  Chip,
  TextField,
  InputAdornment,
  Fab,
  Card,
  Divider,
} from '@mui/material'
import {
  ArrowBack,
  Search,
  Edit,
  Circle,
} from '@mui/icons-material'

import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

interface Message {
  id: string
  name: string
  avatar: string
  lastMessage: string
  timestamp: string
  unreadCount: number
  propertyTitle?: string
  online: boolean
  type: 'property' | 'support' | 'general'
}

const MessagesScreen: React.FC = () => {
  const navigate = useNavigate()
  const [searchQuery, setSearchQuery] = useState('')
  const [currentBottomIndex, setCurrentBottomIndex] = useState(1)

  const messages: Message[] = [
    {
      id: '1',
      name: 'Sarah Johnson',
      avatar: 'https://images.unsplash.com/photo-1494790108755-2616b95b2b7e?w=100',
      lastMessage: 'Is the apartment still available for viewing this weekend?',
      timestamp: '10:30 AM',
      unreadCount: 2,
      propertyTitle: 'Modern Downtown Apartment',
      online: true,
      type: 'property'
    },
    {
      id: '2',
      name: 'Customer Support',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      lastMessage: 'Thank you for contacting us. How can we help you today?',
      timestamp: 'Yesterday',
      unreadCount: 0,
      online: true,
      type: 'support'
    },
    {
      id: '3',
      name: 'Michael Chen',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      lastMessage: 'The property looks great! Can we schedule a viewing?',
      timestamp: 'Yesterday',
      unreadCount: 1,
      propertyTitle: 'Luxury Family House',
      online: false,
      type: 'property'
    },
    {
      id: '4',
      name: 'Emma Wilson',
      avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      lastMessage: 'Thanks for the quick response about the lease terms.',
      timestamp: '2 days ago',
      unreadCount: 0,
      propertyTitle: 'Cozy Studio Loft',
      online: false,
      type: 'property'
    },
    {
      id: '5',
      name: 'Property Manager',
      avatar: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100',
      lastMessage: 'Your property listing has been approved and is now live.',
      timestamp: '3 days ago',
      unreadCount: 0,
      online: true,
      type: 'general'
    },
    {
      id: '6',
      name: 'David Rodriguez',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      lastMessage: 'Could you provide more details about the parking situation?',
      timestamp: '1 week ago',
      unreadCount: 0,
      propertyTitle: 'Spacious Townhouse',
      online: false,
      type: 'property'
    }
  ]

  const filteredMessages = messages.filter(message =>
    message.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    message.lastMessage.toLowerCase().includes(searchQuery.toLowerCase()) ||
    (message.propertyTitle && message.propertyTitle.toLowerCase().includes(searchQuery.toLowerCase()))
  )

  const getMessageTypeColor = (type: string) => {
    switch (type) {
      case 'support':
        return 'primary'
      case 'property':
        return 'success'
      default:
        return 'default'
    }
  }

  const getMessageTypeLabel = (type: string) => {
    switch (type) {
      case 'support':
        return 'Support'
      case 'property':
        return 'Property'
      default:
        return 'General'
    }
  }

  const totalUnreadCount = messages.reduce((total, message) => total + message.unreadCount, 0)

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa', pb: 12 }}>
      {/* Header */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Box sx={{ flexGrow: 1 }}>
            <Typography variant="h6">Messages</Typography>
            {totalUnreadCount > 0 && (
              <Typography variant="body2" sx={{ opacity: 0.8 }}>
                {totalUnreadCount} unread message{totalUnreadCount > 1 ? 's' : ''}
              </Typography>
            )}
          </Box>
          <IconButton color="inherit" onClick={() => navigate('/messages/new')}>
            <Edit />
          </IconButton>
        </Toolbar>
      </AppBar>

      <Container maxWidth="md" sx={{ py: 2 }}>
        {/* Search Bar */}
        <TextField
          fullWidth
          placeholder="Search conversations..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                <Search />
              </InputAdornment>
            ),
          }}
          sx={{ mb: 2 }}
        />

        {/* Messages List */}
        {filteredMessages.length === 0 ? (
          <Card sx={{ p: 4, textAlign: 'center' }}>
            <Typography variant="h6" color="text.secondary" sx={{ mb: 1 }}>
              No conversations found
            </Typography>
            <Typography variant="body2" color="text.secondary">
              {searchQuery ? 'Try a different search term' : 'Start a conversation to see it here'}
            </Typography>
          </Card>
        ) : (
          <Card>
            <List sx={{ p: 0 }}>
              {filteredMessages.map((message, index) => (
                <React.Fragment key={message.id}>
                  <ListItem
                    button
                    onClick={() => navigate(`/messages/${message.id}`)}
                    sx={{
                      py: 2,
                      backgroundColor: message.unreadCount > 0 ? 'rgba(25, 118, 210, 0.04)' : 'transparent',
                    }}
                  >
                    <ListItemAvatar>
                      <Box sx={{ position: 'relative' }}>
                        <Avatar imgProps={{ referrerPolicy: 'no-referrer' }} src={message.avatar} alt={message.name} />
                        {message.online && (
                          <Circle
                            sx={{
                              position: 'absolute',
                              bottom: 0,
                              right: 0,
                              color: '#4CAF50',
                              fontSize: 16,
                              backgroundColor: 'white',
                              borderRadius: '50%',
                            }}
                          />
                        )}
                      </Box>
                    </ListItemAvatar>
                    
                    <ListItemText
                      primary={
                        <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                          <Typography
                            variant="subtitle1"
                            component="span"
                            sx={{
                              fontWeight: message.unreadCount > 0 ? 600 : 400,
                            }}
                          >
                            {message.name}
                          </Typography>
                          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                            <Typography variant="caption" component="span" color="text.secondary">
                              {message.timestamp}
                            </Typography>
                            {message.unreadCount > 0 && (
                              <Badge
                                badgeContent={message.unreadCount}
                                color="primary"
                                sx={{
                                  '& .MuiBadge-badge': {
                                    minWidth: 18,
                                    height: 18,
                                    fontSize: '11px',
                                  },
                                }}
                              />
                            )}
                          </Box>
                        </Box>
                      }
                      secondary={
                        <Box>
                          {message.propertyTitle && (
                            <Typography variant="caption" component="span" color="primary" sx={{ display: 'block' }}>
                              Re: {message.propertyTitle}
                            </Typography>
                          )}
                          <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', mt: 0.5 }}>
                            <Typography
                              variant="body2"
                              component="span"
                              color="text.secondary"
                              sx={{
                                fontWeight: message.unreadCount > 0 ? 500 : 400,
                                overflow: 'hidden',
                                textOverflow: 'ellipsis',
                                whiteSpace: 'nowrap',
                                maxWidth: '70%',
                              }}
                            >
                              {message.lastMessage}
                            </Typography>
                            <Chip
                              label={getMessageTypeLabel(message.type)}
                              size="small"
                              color={getMessageTypeColor(message.type) as any}
                              variant="outlined"
                              sx={{ fontSize: '10px', height: 20 }}
                            />
                          </Box>
                        </Box>
                      }
                      primaryTypographyProps={{ component: 'div' }}
                      secondaryTypographyProps={{ component: 'div' }}
                    />
                  </ListItem>
                  {index < filteredMessages.length - 1 && <Divider />}
                </React.Fragment>
              ))}
            </List>
          </Card>
        )}

        {/* New Message FAB */}
        <Fab
          color="primary"
          sx={{ position: 'fixed', bottom: 100, right: 16 }}
          onClick={() => navigate('/support/chat')}
        >
          <Edit />
        </Fab>
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

export default MessagesScreen
