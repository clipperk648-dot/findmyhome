import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { ThemeProvider } from '@mui/material/styles'
import CssBaseline from '@mui/material/CssBaseline'
import { QueryClient, QueryClientProvider } from 'react-query'

import App from './App'
import { theme } from './theme/AppTheme'

// Restore native fetch if captured by the inline script to avoid wrappers (e.g. FullStory) interfering
try {
  if (typeof window !== 'undefined' && (window as any).__nativeFetch) {
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    window.fetch = (window as any).__nativeFetch
  }
} catch (e) {
  // ignore
}

// Global error handlers to capture fetch/network issues gracefully
if (typeof window !== 'undefined') {
  window.addEventListener('error', (event) => {
    // Prevent noisy logs from external scripts breaking app flow
    // You can extend this to report errors to monitoring services
    // console.error('Global error:', event.error || event.message)
  })

  window.addEventListener('unhandledrejection', (event) => {
    // console.error('Unhandled promise rejection:', event.reason)
  })
}

const queryClient = new QueryClient()

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>
        <ThemeProvider theme={theme}>
          <CssBaseline />
          <App />
        </ThemeProvider>
      </BrowserRouter>
    </QueryClientProvider>
  </React.StrictMode>,
)
