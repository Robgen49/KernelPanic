import { AppBar, Box, Breadcrumbs, Container, Link, Typography, useMediaQuery } from "@mui/material";
import cls from './Navbar.module.scss';
import { NavLink, useLocation } from "react-router-dom";
import LogoutIcon from '@mui/icons-material/Logout';
import Divider from '@mui/material/Divider';


export const Navbar = () => {
   const route = useLocation();
   const isMobile = useMediaQuery('(max-width: 700px)');
   const isTablet = useMediaQuery('(max-width: 640px)');
   return (
      <div className={cls.root}>
         <AppBar sx={{ maxHeight: '100px' }} color='transparent' position="static">
            <Container maxWidth="xl">
               <Box sx={{ overflow: 'hidden', display: 'flex', justifyContent: 'space-between' }} >
                  <div className={cls.logo} />
                  <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', justifyContent: 'center' }} >
                     <Breadcrumbs aria-label="breadcrumb">
                        {route.pathname === '/' ? <Typography color="text.primary">Все команды</Typography>
                           : <Link component={NavLink} to={'/'} underline="hover" color="inherit">
                              Все команды
                           </Link>}
                        {route.pathname === '/profile' ? <Typography color="text.primary">Моя команда</Typography> : <Link
                           component={NavLink} to={'/profile'}
                           underline="hover"
                           color="inherit"
                        >
                           Моя команда
                        </Link>}
                        <Link
                           display={'flex'}
                           gap={1}
                           sx={{ alignItems: 'center' }}
                           onClick={() => localStorage.clear()}
                           component={NavLink}
                           to={'/login'}
                           underline="hover"
                           color="inherit">
                           {!isMobile && 'Выход' }
                           <LogoutIcon />
                        </Link>
                     </Breadcrumbs>

                  </div>
               </Box>
            </Container>
         </AppBar>
      </div>
   );
};