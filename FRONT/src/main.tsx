import React from 'react'
import ReactDOM from 'react-dom/client'
import { Box, CircularProgress, CssBaseline, ThemeProvider, createTheme, rgbToHex } from '@mui/material'
import { RouterProvider } from 'react-router-dom'
import { router } from './routes/routes.tsx'
import './main.css'

const theme = createTheme({
  palette: {
    primary: {
      main: '#2F80ED',
    },
    secondary: {
      main: '#7a27e0',
    }
  },
  typography: {
    fontFamily: [
      'Montserrat'
    ].join(','),
  },
});

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <RouterProvider fallbackElement={<Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', width: '100vw' }} ><CircularProgress color='secondary' /></Box>} router={router} />
    </ThemeProvider>
  </React.StrictMode>,
)


