import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Box,
  Container,
  Typography,
  Card,
  CardContent,
  Grid,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  AppBar,
  Toolbar,
  IconButton,
  Button,
  Accordion,
  AccordionSummary,
  AccordionDetails,
  TextField,
  Paper,
  Avatar,
  Chip,
  Fab,
} from '@mui/material'
import {
  ArrowBack,
  SupportAgent,
  Chat,
  Phone,
  Email,
  Help,
  ExpandMore,
  Send,
  QuestionAnswer,
  School,
  BugReport,
  Feedback,
  Policy,
  Security,
  Payment,
} from '@mui/icons-material'

import CustomBottomBar, { BottomBarVariant } from '../components/CustomBottomBar'

const SupportScreen: React.FC = () => {
  const navigate = useNavigate()
  const [currentBottomIndex, setCurrentBottomIndex] = useState(3)
  const [messageText, setMessageText] = useState('')

  const contactMethods = [
    {
      icon: <Chat sx={{ fontSize: 40, color: '#2196F3' }} />,
      title: "Live Chat",
      description: "Get instant help from our support team",
      availability: "Available 24/7",
      action: () => navigate('/support/chat'),
      buttonText: "Start Chat"
    },
    {
      icon: <Phone sx={{ fontSize: 40, color: '#4CAF50' }} />,
      title: "Phone Support",
      description: "Speak directly with a support specialist",
      availability: "Mon-Fri 8AM-8PM PST",
      action: () => window.open('tel:+1-800-PROPERTY'),
      buttonText: "Call Now"
    },
    {
      icon: <Email sx={{ fontSize: 40, color: '#FF9800' }} />,
      title: "Email Support",
      description: "Send us a detailed message",
      availability: "Response within 4 hours",
      action: () => window.open('mailto:support@findmyhome.com'),
      buttonText: "Send Email"
    }
  ]

  const supportCategories = [
    {
      icon: <Help />,
      title: "General Help",
      description: "Common questions and getting started",
      articles: 15
    },
    {
      icon: <QuestionAnswer />,
      title: "Property Listings",
      description: "How to list, edit, and manage properties",
      articles: 12
    },
    {
      icon: <School />,
      title: "Account & Billing",
      description: "Profile settings, payments, and subscriptions",
      articles: 8
    },
    {
      icon: <Security />,
      title: "Safety & Security",
      description: "Protecting your account and personal data",
      articles: 6
    },
    {
      icon: <BugReport />,
      title: "Technical Issues",
      description: "App problems and troubleshooting",
      articles: 10
    },
    {
      icon: <Policy />,
      title: "Policies & Terms",
      description: "Terms of service, privacy policy, and guidelines",
      articles: 5
    }
  ]

  const faqs = [
    {
      question: "How do I create a property listing?",
      answer: "To create a property listing, go to the 'List Property' section from the main menu. Fill in all required details including photos, description, price, and location. Our team will review and approve your listing within 24 hours."
    },
    {
      question: "What are the fees for listing a property?",
      answer: "Basic listings are free for the first 30 days. Premium listings with featured placement cost $29/month. We also charge a 2% transaction fee only when you successfully rent or sell through our platform."
    },
    {
      question: "How do I verify my identity?",
      answer: "Identity verification is required for all users. Upload a government-issued ID and proof of address. The verification process typically takes 1-2 business days. You'll receive an email confirmation once approved."
    },
    {
      question: "Can I edit my listing after it's published?",
      answer: "Yes, you can edit your listing anytime from your dashboard. Changes to price, description, and photos are updated immediately. Major changes like property type may require re-approval."
    },
    {
      question: "How do I contact potential tenants or buyers?",
      answer: "Use our built-in messaging system to communicate safely with interested parties. We recommend keeping all communications on our platform for security and record-keeping purposes."
    },
    {
      question: "What payment methods do you accept?",
      answer: "We accept all major credit cards, PayPal, and bank transfers. For premium features and transaction fees, payments are processed securely through our payment partners."
    }
  ]

  const quickActions = [
    { title: "Report a Problem", icon: <BugReport />, action: () => navigate('/support/report') },
    { title: "Submit Feedback", icon: <Feedback />, action: () => navigate('/support/feedback') },
    { title: "Request Feature", icon: <Send />, action: () => navigate('/support/feature-request') },
    { title: "Account Security", icon: <Security />, action: () => navigate('/profile/security') },
  ]

  const handleSendMessage = () => {
    if (messageText.trim()) {
      // Implementation for sending quick message
      alert('Message sent! We\'ll get back to you soon.')
      setMessageText('')
    }
  }

  return (
    <Box sx={{ minHeight: '100vh', backgroundColor: '#fafafa', pb: 12 }}>
      {/* Header */}
      <AppBar position="sticky" elevation={1}>
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate(-1)}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            Help & Support
          </Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="lg" sx={{ py: 3 }}>
        {/* Welcome Section */}
        <Card sx={{ mb: 4, backgroundColor: 'primary.main', color: 'white' }}>
          <CardContent sx={{ textAlign: 'center', p: 4 }}>
            <SupportAgent sx={{ fontSize: 60, mb: 2 }} />
            <Typography variant="h4" sx={{ fontWeight: 700, mb: 2 }}>
              How can we help you?
            </Typography>
            <Typography variant="body1" sx={{ opacity: 0.9, mb: 3 }}>
              Our support team is here to assist you 24/7. Choose from the options below or browse our help articles.
            </Typography>
            <Chip 
              label="Average response time: 2 minutes"
              sx={{ backgroundColor: 'rgba(255,255,255,0.2)', color: 'white' }}
            />
          </CardContent>
        </Card>

        {/* Contact Methods */}
        <Typography variant="h5" sx={{ fontWeight: 700, mb: 3 }}>
          Contact Support
        </Typography>
        <Grid container spacing={3} sx={{ mb: 4 }}>
          {contactMethods.map((method, index) => (
            <Grid item xs={12} md={4} key={index}>
              <Card sx={{ height: '100%', textAlign: 'center' }}>
                <CardContent sx={{ p: 3 }}>
                  {method.icon}
                  <Typography variant="h6" sx={{ fontWeight: 600, my: 2 }}>
                    {method.title}
                  </Typography>
                  <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                    {method.description}
                  </Typography>
                  <Typography variant="caption" color="primary" sx={{ display: 'block', mb: 3 }}>
                    {method.availability}
                  </Typography>
                  <Button
                    variant="contained"
                    onClick={method.action}
                    fullWidth
                  >
                    {method.buttonText}
                  </Button>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>

        {/* Quick Message */}
        <Card sx={{ mb: 4 }}>
          <CardContent>
            <Typography variant="h6" sx={{ fontWeight: 600, mb: 2 }}>
              Send us a quick message
            </Typography>
            <Box sx={{ display: 'flex', gap: 2 }}>
              <TextField
                fullWidth
                multiline
                rows={3}
                placeholder="Describe your issue or question..."
                value={messageText}
                onChange={(e) => setMessageText(e.target.value)}
              />
              <Button
                variant="contained"
                onClick={handleSendMessage}
                sx={{ minWidth: 100 }}
                disabled={!messageText.trim()}
              >
                <Send />
              </Button>
            </Box>
          </CardContent>
        </Card>

        {/* Support Categories */}
        <Typography variant="h5" sx={{ fontWeight: 700, mb: 3 }}>
          Browse Help Topics
        </Typography>
        <Grid container spacing={2} sx={{ mb: 4 }}>
          {supportCategories.map((category, index) => (
            <Grid item xs={12} sm={6} md={4} key={index}>
              <Card 
                sx={{ 
                  cursor: 'pointer',
                  transition: 'transform 0.2s',
                  '&:hover': { transform: 'translateY(-2px)' }
                }}
                onClick={() => navigate(`/support/category/${category.title.toLowerCase().replace(/ /g, '-')}`)}
              >
                <CardContent>
                  <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                    <Avatar sx={{ backgroundColor: 'primary.light', mr: 2 }}>
                      {category.icon}
                    </Avatar>
                    <Box>
                      <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                        {category.title}
                      </Typography>
                      <Typography variant="caption" color="primary">
                        {category.articles} articles
                      </Typography>
                    </Box>
                  </Box>
                  <Typography variant="body2" color="text.secondary">
                    {category.description}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>

        {/* Quick Actions */}
        <Typography variant="h5" sx={{ fontWeight: 700, mb: 3 }}>
          Quick Actions
        </Typography>
        <Grid container spacing={2} sx={{ mb: 4 }}>
          {quickActions.map((action, index) => (
            <Grid item xs={6} sm={3} key={index}>
              <Button
                fullWidth
                variant="outlined"
                startIcon={action.icon}
                onClick={action.action}
                sx={{ py: 2, flexDirection: 'column', height: 80 }}
              >
                <Typography variant="caption" sx={{ mt: 1 }}>
                  {action.title}
                </Typography>
              </Button>
            </Grid>
          ))}
        </Grid>

        {/* FAQs */}
        <Typography variant="h5" sx={{ fontWeight: 700, mb: 3 }}>
          Frequently Asked Questions
        </Typography>
        <Card>
          {faqs.map((faq, index) => (
            <Accordion key={index}>
              <AccordionSummary expandIcon={<ExpandMore />}>
                <Typography variant="subtitle1" sx={{ fontWeight: 600 }}>
                  {faq.question}
                </Typography>
              </AccordionSummary>
              <AccordionDetails>
                <Typography variant="body2" color="text.secondary">
                  {faq.answer}
                </Typography>
              </AccordionDetails>
            </Accordion>
          ))}
        </Card>

        {/* Emergency Contact */}
        <Paper sx={{ p: 3, mt: 4, backgroundColor: '#fff3e0' }}>
          <Typography variant="h6" sx={{ fontWeight: 600, mb: 1 }}>
            Emergency Support
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
            For urgent issues affecting your safety or security, contact us immediately:
          </Typography>
          <Button
            variant="contained"
            color="error"
            onClick={() => window.open('tel:+1-800-EMERGENCY')}
          >
            Emergency Hotline: 1-800-EMERGENCY
          </Button>
        </Paper>
      </Container>

      {/* Live Chat FAB */}
      <Fab
        color="primary"
        sx={{ position: 'fixed', bottom: 100, right: 16 }}
        onClick={() => navigate('/support/chat')}
      >
        <Chat />
      </Fab>

      {/* Bottom Navigation */}
      <CustomBottomBar
        currentIndex={currentBottomIndex}
        onTap={setCurrentBottomIndex}
        variant={BottomBarVariant.STANDARD}
      />
    </Box>
  )
}

export default SupportScreen
