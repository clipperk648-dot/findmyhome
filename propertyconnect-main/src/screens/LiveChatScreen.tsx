import React, { useState, useEffect, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  TextField,
  IconButton,
  AppBar,
  Toolbar,
  List,
  ListItem,
  Avatar,
  Paper,
  Chip,
  Button,
  Divider,
} from '@mui/material'
import {
  ArrowBack,
  Send,
  AttachFile,
  EmojiEmotions,
  MoreVert,
} from '@mui/icons-material'

interface ChatMessage {
  id: string
  text: string
  timestamp: string
  sender: 'user' | 'agent'
  senderName: string
  senderAvatar?: string
  type: 'text' | 'system'
}

const LiveChatScreen: React.FC = () => {
  const navigate = useNavigate()
  const [messages, setMessages] = useState<ChatMessage[]>([])
  const [newMessage, setNewMessage] = useState('')
  const [isTyping, setIsTyping] = useState(false)
  const [agentInfo] = useState({
    name: 'Sarah Wilson',
    status: 'online',
    avatar: 'https://images.unsplash.com/photo-1494790108755-2616b95b2b7e?w=100',
    title: 'Customer Support Specialist'
  })
  const messagesEndRef = useRef<HTMLDivElement>(null)

  // Initialize chat with welcome message
  useEffect(() => {
    const welcomeMessages: ChatMessage[] = [
      {
        id: '1',
        text: 'Welcome to Findmyhome Support!',
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        sender: 'agent',
        senderName: 'System',
        type: 'system'
      },
      {
        id: '2',
        text: 'Hi! I\'m Sarah, your customer support specialist. How can I help you today?',
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        sender: 'agent',
        senderName: agentInfo.name,
        senderAvatar: agentInfo.avatar,
        type: 'text'
      }
    ]
    setMessages(welcomeMessages)
  }, [agentInfo])

  // Auto-scroll to bottom when new messages arrive
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  // Simulate agent typing and responses
  const simulateAgentResponse = (userMessage: string) => {
    setIsTyping(true)
    
    setTimeout(() => {
      setIsTyping(false)
      
      // Simple response logic based on keywords
      let response = "Thank you for your message. Let me help you with that."
      
      if (userMessage.toLowerCase().includes('property') || userMessage.toLowerCase().includes('listing')) {
        response = "I'd be happy to help you with property-related questions. Are you looking to rent, buy, or list a property?"
      } else if (userMessage.toLowerCase().includes('problem') || userMessage.toLowerCase().includes('issue')) {
        response = "I understand you're experiencing an issue. Can you provide more details about what's happening so I can assist you better?"
      } else if (userMessage.toLowerCase().includes('payment') || userMessage.toLowerCase().includes('billing')) {
        response = "For billing and payment inquiries, I can help you right away. What specific payment question do you have?"
      } else if (userMessage.toLowerCase().includes('hello') || userMessage.toLowerCase().includes('hi')) {
        response = "Hello! Welcome to Findmyhome. I'm here to help with any questions you might have about our platform."
      }

      const agentMessage: ChatMessage = {
        id: Date.now().toString(),
        text: response,
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        sender: 'agent',
        senderName: agentInfo.name,
        senderAvatar: agentInfo.avatar,
        type: 'text'
      }
      
      setMessages(prev => [...prev, agentMessage])
    }, 1500 + Math.random() * 1000) // Random delay 1.5-2.5 seconds
  }

  const handleSendMessage = () => {
    if (newMessage.trim()) {
      const userMessage: ChatMessage = {
        id: Date.now().toString(),
        text: newMessage,
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        sender: 'user',
        senderName: 'You',
        type: 'text'
      }
      
      setMessages(prev => [...prev, userMessage])
      
      // Simulate agent response
      simulateAgentResponse(newMessage)
      
      setNewMessage('')
    }
  }

  const quickReplies = [
    "I need help with my listing",
    "Payment question",
    "Technical issue",
    "Account problem"
  ]

  const handleQuickReply = (reply: string) => {
    setNewMessage(reply)
  }

  return (
    <Box sx={{ height: '100vh', display: 'flex', flexDirection: 'column', backgroundColor: '#f5f5f5' }}>
      {/* Header */}
      <AppBar position="static" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Avatar src={agentInfo.avatar} imgProps={{ referrerPolicy: 'no-referrer' }} sx={{ mr: 2, width: 32, height: 32 }} />
          <Box sx={{ flexGrow: 1 }}>
            <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
              {agentInfo.name}
            </Typography>
            <Typography variant="caption" sx={{ opacity: 0.8 }}>
              {agentInfo.title} • {isTyping ? 'typing...' : agentInfo.status}
            </Typography>
          </Box>
          <IconButton color="inherit">
            <MoreVert />
          </IconButton>
        </Toolbar>
      </AppBar>

      {/* Chat Messages */}
      <Box sx={{ flexGrow: 1, overflow: 'auto', p: 1 }}>
        <List sx={{ pb: 0 }}>
          {messages.map((message) => (
            <ListItem
              key={message.id}
              sx={{
                flexDirection: 'column',
                alignItems: message.sender === 'user' ? 'flex-end' : 'flex-start',
                px: 1,
                py: 0.5,
              }}
            >
              <Box
                sx={{
                  maxWidth: '70%',
                  mb: 0.5,
                }}
              >
                {message.type === 'system' ? (
                  <Chip
                    label={message.text}
                    size="small"
                    sx={{
                      backgroundColor: 'rgba(0,0,0,0.1)',
                      color: 'text.secondary',
                    }}
                  />
                ) : (
                  <Paper
                    sx={{
                      p: 1.5,
                      backgroundColor: message.sender === 'user' ? 'primary.main' : 'white',
                      color: message.sender === 'user' ? 'white' : 'text.primary',
                      borderRadius: 2,
                      borderTopLeftRadius: message.sender === 'agent' ? 0.5 : 2,
                      borderTopRightRadius: message.sender === 'user' ? 0.5 : 2,
                    }}
                  >
                    <Typography variant="body2">
                      {message.text}
                    </Typography>
                  </Paper>
                )}
              </Box>
              <Typography
                variant="caption"
                color="text.secondary"
                sx={{
                  alignSelf: message.sender === 'user' ? 'flex-end' : 'flex-start',
                }}
              >
                {message.timestamp}
              </Typography>
            </ListItem>
          ))}
          
          {/* Typing indicator */}
          {isTyping && (
            <ListItem sx={{ flexDirection: 'column', alignItems: 'flex-start', px: 1, py: 0.5 }}>
              <Paper
                sx={{
                  p: 1.5,
                  backgroundColor: 'white',
                  borderRadius: 2,
                  borderTopLeftRadius: 0.5,
                }}
              >
                <Typography variant="body2" color="text.secondary">
                  <em>{agentInfo.name} is typing...</em>
                </Typography>
              </Paper>
            </ListItem>
          )}
        </List>
        <div ref={messagesEndRef} />
      </Box>

      {/* Quick Replies */}
      {messages.length <= 2 && (
        <Box sx={{ p: 2, pt: 1 }}>
          <Typography variant="caption" color="text.secondary" sx={{ mb: 1, display: 'block' }}>
            Quick replies:
          </Typography>
          <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap' }}>
            {quickReplies.map((reply, index) => (
              <Chip
                key={index}
                label={reply}
                onClick={() => handleQuickReply(reply)}
                clickable
                size="small"
                variant="outlined"
              />
            ))}
          </Box>
        </Box>
      )}

      <Divider />

      {/* Message Input */}
      <Box sx={{ p: 2, backgroundColor: 'white' }}>
        <Box sx={{ display: 'flex', alignItems: 'flex-end', gap: 1 }}>
          <IconButton size="small">
            <AttachFile />
          </IconButton>
          <TextField
            fullWidth
            multiline
            maxRows={4}
            placeholder="Type your message..."
            value={newMessage}
            onChange={(e) => setNewMessage(e.target.value)}
            onKeyPress={(e) => {
              if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault()
                handleSendMessage()
              }
            }}
            sx={{
              '& .MuiOutlinedInput-root': {
                borderRadius: 3,
              },
            }}
          />
          <IconButton size="small">
            <EmojiEmotions />
          </IconButton>
          <IconButton
            color="primary"
            onClick={handleSendMessage}
            disabled={!newMessage.trim()}
            sx={{
              backgroundColor: newMessage.trim() ? 'primary.main' : 'transparent',
              color: newMessage.trim() ? 'white' : 'primary.main',
              '&:hover': {
                backgroundColor: newMessage.trim() ? 'primary.dark' : 'rgba(25, 118, 210, 0.04)',
              },
            }}
          >
            <Send />
          </IconButton>
        </Box>
      </Box>
    </Box>
  )
}

export default LiveChatScreen
