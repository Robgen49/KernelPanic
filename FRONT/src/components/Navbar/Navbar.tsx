import { AppBar, Box, Breadcrumbs, Container, Drawer, Link, List, ListItem, ListItemButton, Typography, useMediaQuery } from "@mui/material";
import cls from './Navbar.module.scss';
import { NavLink, useLocation } from "react-router-dom";
import LogoutIcon from '@mui/icons-material/Logout';
import { useState } from "react";
import MenuIcon from '@mui/icons-material/Menu';
import ListItemIcon from '@mui/material/ListItemIcon';



export const Navbar = () => {
   const route = useLocation();
   const isShowExit = useMediaQuery('(max-width: 700px)');
   const isMobile = useMediaQuery('(max-width: 640px)');

   const [open, setOpen] = useState(false);

   const toggleDrawer = (newOpen: boolean) => () => {
      setOpen(newOpen);
   };
   const iconMobileStyle = { flex: 1, display: 'flex', justifyContent: 'flex-end' } 
   const listItemButtonStyle = { display: 'flex', justifyContent: 'space-between' }

   return (
      <div className={cls.root}>
         <AppBar sx={{ maxHeight: '100px' }} color='transparent' position="static">
            <Container maxWidth="xl">
               <Box sx={{ overflow: 'hidden', display: 'flex', justifyContent: 'space-between' }} >
                  <div className={cls.logo} />
                  <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', justifyContent: 'center' }} >
                     {isMobile ? <>
                        <MenuIcon sx={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}
                           onClick={toggleDrawer(true)} />
                        <Drawer open={open} onClose={toggleDrawer(false)}>
                           <List>
                              <ListItem disablePadding>
                                 <ListItemButton sx={listItemButtonStyle} component={NavLink} to={'/'}>
                                    <Typography>Все команды</Typography>
                                    <ListItemIcon sx={iconMobileStyle}>
                                    </ListItemIcon>
                                 </ListItemButton>
                              </ListItem>
                              <ListItem disablePadding>
                                 <ListItemButton sx={listItemButtonStyle} component={NavLink} to={'/profile'}>
                                    <Typography>Моя команда</Typography>
                                    <ListItemIcon sx={iconMobileStyle}>
                                    </ListItemIcon>
                                 </ListItemButton>
                              </ListItem>
                              <ListItem disablePadding>
                                 <ListItemButton sx={listItemButtonStyle} component={NavLink} to={'/auth/login'} onClick={() => localStorage.clear()}>
                                    <Typography>Выход</Typography>
                                    <ListItemIcon sx={iconMobileStyle}>
                                       <LogoutIcon />
                                    </ListItemIcon>
                                 </ListItemButton>
                              </ListItem>
                           </List>
                        </Drawer> </> :
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
                              to={'/auth/login'}
                              underline="hover"
                              color="inherit">
                              {!isShowExit && 'Выход'}
                              <LogoutIcon />
                           </Link>
                        </Breadcrumbs>
                     }
                  </div>
               </Box>
            </Container>
         </AppBar>
      </div>
   );
};