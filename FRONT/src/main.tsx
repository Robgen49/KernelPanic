import React from 'react'
import ReactDOM from 'react-dom/client'
import { CssBaseline, ThemeProvider, createTheme } from '@mui/material'
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
      <RouterProvider router={router} />
    </ThemeProvider>
  </React.StrictMode>,
)


