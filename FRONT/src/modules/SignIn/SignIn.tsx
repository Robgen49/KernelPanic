import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { NavLink, useLocation, useNavigate } from 'react-router-dom';
import { Toast } from '../../components/Alert';
import { fetchLogin } from '../../api/login';
import { setToken } from '../../utils/setToken';
import { Backdrop, CircularProgress } from '@mui/material';

export default function SignIn() {
   const location = useLocation();
   const isSuccessAlertOpen = location?.state?.successAlertOpen || false;
   const [successAlertOpen, setSuccessAlertOpen] = React.useState(isSuccessAlertOpen);
   const [errorAlertOpen, setErrorAlertOpen] = React.useState(false);
   const navigation = useNavigate();
   const [loading, setLoading] = React.useState(false)

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      setLoading(true)
      fetchLogin({
         login: data.get('email') as string,
         password: data.get('password') as string,
      }).then((data) =>
         data.json()
      ).then((data) => {
         setToken(data.token);
         setLoading(false)
         navigation('/', { state: { successAlertOpen: true } });
      }).catch(() => {
         setErrorAlertOpen(true);
         setLoading(false)
      })
   };



   return (
      <Container sx={{ height: '100vh', display: 'flex', flexDirection: 'column' }} component="main" maxWidth="xs">
         <Toast open={errorAlertOpen}
            handleClose={() => setErrorAlertOpen(false)}
            message={'Неправильный логин или пароль'} result={'error'} />
         <Toast open={successAlertOpen}
            handleClose={() => setSuccessAlertOpen(false)}
            message={'Вы успешно зарегистрировались!'} result={'success'} />
         <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={loading}
            onClick={() => setLoading(false)}
         >
            <CircularProgress color="secondary" />
         </Backdrop>
         <Box
            sx={{
               marginTop: 8,
               display: 'flex',
               flexDirection: 'column',
               alignItems: 'center',
               flexGrow: 1,
            }}
         >
            <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
               <LockOutlinedIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
               Войти
            </Typography>
            <Box component="form" onSubmit={handleSubmit} sx={{ mt: 1 }}>
               <TextField
                  margin="normal"
                  required
                  fullWidth
                  id="email"
                  label="Логин"
                  name="email"
                  autoComplete="email"
                  autoFocus
               />
               <TextField
                  margin="normal"
                  required
                  fullWidth
                  name="password"
                  label="Пароль"
                  type="password"
                  id="password"
                  autoComplete="current-password"
               />
               <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                  <Button
                     type="submit"
                     color="secondary"
                     variant="contained"
                     sx={{ mt: 3, mb: 3, width: '33%' }}
                  >
                     Вход
                  </Button>
               </Box>
               <Grid container>
                  <Grid item>
                     <Link component={NavLink} to="/auth/registration" variant="body2">
                        {"Нет аккаунта? Регистрация"}
                     </Link>
                  </Grid>
               </Grid>
            </Box>
         </Box>
      </Container>
   );
}