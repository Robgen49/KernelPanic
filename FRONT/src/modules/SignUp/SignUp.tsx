import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Link from '@mui/material/Link';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { NavLink, useNavigate } from 'react-router-dom';
import DropImage from '../../components/DropImage/DropImage';
import { AddMemer } from '../AddMember/AddMemer';
import { Member } from '../Member/Member';
import { fetchRegistration } from '../../api/registration';
import { Toast } from '../../components/Alert';
import { IconButton, useMediaQuery } from '@mui/material';
import AddCircleOutlineIcon from '@mui/icons-material/AddCircleOutline';


export interface Member {
   full_name?: string,
   photo?: string,
   stack_tech?: string,
   direction?: string,
   assessment?: string,
   difficulties?: string,
   id?: number,
}

export interface uploadTeam {
   teamName: string,
   email: string,
   login: string,
   password: string,
   logo: string | null,
   teammates: Member[]
}

export default function SignUp() {
   const [file, setFile] = React.useState<string | null>(null);
   const [members, setMembers] = React.useState<Member[]>([]);
   const [isModalOpen, setIsModalOpen] = React.useState(false);
   const [errorAlertOpen, setErrorAlertOpen] = React.useState(false);
   const [emptyMemberPhotoAlert, setEmptyMemberPhotoAlert] = React.useState(false);
   const navigation = useNavigate();
   const isMobile = useMediaQuery('(max-width: 640px)');
   const [showTeammatesAlert, setShowTeammatesAlert] = React.useState(false);
   const [showBannerAlert, setShowBannerAlert] = React.useState(false);

   const handleChange = (file: string) => {
      setFile(file);
   };

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      if (file === null) {
         setShowBannerAlert(true);
         return;
      }
      if (members.length < 2) {
         setShowTeammatesAlert(true);
         return;
      }

      fetchRegistration({
         teamName: data.get('title') as string,
         email: data.get('email') as string,
         login: data.get('login') as string,
         password: data.get('password') as string,
         logo: file,
         teammates: members
      }).then((data) => data.json()).then((data) => {
         navigation('/auth/login', { state: { successAlertOpen: true } });
      }).catch(() => {
         setErrorAlertOpen(true);
      })
   };

   return (
      <Container sx={{ height: '100vh', display: 'flex', flexDirection: 'column' }} component="main" maxWidth="xs">
         <Toast open={showBannerAlert} handleClose={() => setShowBannerAlert(false)} message={'Добавьте баннер команды!'} result={'error'} />
         <Toast open={showTeammatesAlert} handleClose={() => setShowTeammatesAlert(false)} message={'Добавьте хотя бы двух участников!'} result={'error'} />
         <Toast open={errorAlertOpen} handleClose={() => setErrorAlertOpen(false)} message={'Что-то пошло не так('} result={'error'} />
         <Toast open={emptyMemberPhotoAlert} handleClose={() => setEmptyMemberPhotoAlert(false)} message={'Добавьте фото!'} result={'error'} />
         <AddMemer setErrorAlertOpen={setEmptyMemberPhotoAlert} open={isModalOpen} handleClose={() => setIsModalOpen(false)} setMembers={setMembers} />
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
               Регистрация
            </Typography>
            <Box component="form" onSubmit={handleSubmit} sx={{ mt: 3 }}>
               <Box minWidth={isMobile ? 300 : 400} maxWidth={'50vw'} display={'flex'} flexDirection={'column'} gap={2}>
                  <Box>
                     <TextField
                        autoComplete="given-name"
                        name="title"
                        required
                        fullWidth
                        id="title"
                        label="Название команды"
                        autoFocus
                     />
                  </Box>
                  <Box>
                     <TextField
                        required
                        fullWidth
                        id="email"
                        label="Электронная почта"
                        name="email"
                        autoComplete="email"
                        type='email'
                     />
                  </Box>
                  <Box>
                     <TextField
                        required
                        fullWidth
                        id="login"
                        label="Логин"
                        name="login"
                     />
                  </Box>
                  <Box>
                     <TextField
                        required
                        fullWidth
                        id="password"
                        label="Пароль"
                        name="password"
                        type='password'
                        autoComplete="password"
                     />
                  </Box>
                  <Box>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'} >
                        <Typography>
                           Участники
                        </Typography>
                        <IconButton onClick={() => setIsModalOpen(true)} ><AddCircleOutlineIcon /></IconButton>
                     </Box>
                  </Box>
                  {members.length > 0 &&
                     <Box sx={{
                        overflow: 'auto hidden',
                        paddingBottom: 3,
                        '&::-webkit-scrollbar': { height: 10, WebkitAppearance: 'none' },
                        '&::-webkit-scrollbar-thumb': {
                           borderRadius: 8,
                           border: '2px solid',
                           borderColor: '#fff',
                           backgroundColor: 'rgba(0 0 0 / 0.5)',
                        },
                     }} display={'flex'} flexDirection={'row'} gap={2} maxWidth={450}>
                        {members.map((member: Member, index: number) => <Member key={index} fio={member.full_name} avatar={member.photo && member.photo instanceof File ? URL.createObjectURL(member.photo) : member.photo} />)}
                     </Box>
                  }
                  <Box>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'}>
                        <Typography>
                           Баннер
                        </Typography>
                        <Box sx={{ width: '50%' }} >
                           <DropImage allowEdit name='banner' onImageUpload={handleChange} />
                        </Box>
                     </Box>
                  </Box>
               </Box>
               <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                  <Button
                     color="secondary"
                     type="submit"
                     variant="contained"
                     sx={{ mt: 3, mb: 2 }}
                  >
                     Создать команду
                  </Button>
               </Box>
               <Box justifyContent="flex-end">
                  <Box>
                     <Link component={NavLink} to="/auth/login" variant="body2">
                        Уже есть аккаунт? Войти
                     </Link>
                  </Box>
               </Box>
            </Box>
         </Box>
      </Container >
   );
}