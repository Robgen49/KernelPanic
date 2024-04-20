import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Link from '@mui/material/Link';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { NavLink } from 'react-router-dom';
import DropImage from '../../components/DropImage/DropImage';
import { AddMemer } from '../AddMember/AddMemer';
import { Member } from '../Member/Member';


export interface Member {
   fio: string,
   image: File | string,
   description: string,
}

export default function SignUp() {
   const [file, setFile] = React.useState<File | null>(null);
   const [members, setMembers] = React.useState<Member[]>([{ fio: 'Генрих Роберт Артурович' }, { fio: 'Генрих Роберт Артурович' }, { fio: 'Генрих Роберт Артурович' }, { fio: 'Генрих Роберт Артурович' }, { fio: 'Генрих Роберт Артурович' }, { fio: 'Генрих Роберт Артурович' },]);
   const [isModalOpen, setIsModalOpen] = React.useState(false);

   const handleChange = (file: File) => {
      setFile(file);
   };

   console.log(members)

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      console.log({
         email: data.get('email'),
         password: data.get('password'),
      });
   };

   return (
      <Container sx={{ height: '100vh', display: 'flex', flexDirection: 'column' }} component="main" maxWidth="xs">
         <AddMemer open={isModalOpen} handleClose={() => setIsModalOpen(false)} setMembers={setMembers} />
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
            <Box component="form" noValidate onSubmit={handleSubmit} sx={{ mt: 3 }}>
               <Box minWidth={300} maxWidth={'50vw'} display={'flex'} flexDirection={'column'} gap={2}>
                  <Box width={'100%'}>
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
                        autoComplete="password"
                     />
                  </Box>
                  <Box>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'} >
                        <Typography>
                           Участники
                        </Typography>
                        <Button onClick={() => setIsModalOpen(true)} size='small' variant="outlined" >Добавить участника</Button>
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
                        {members.map((member: Member, index: number) => <Member key={index} fio={member.fio} avatar={member.image && member.image instanceof File ? URL.createObjectURL(member.image) : member.image} />)}
                     </Box>
                  }
                  <Box>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'}>
                        <Typography>
                           Баннер
                        </Typography>
                        <Box sx={{ width: '50%' }} >
                           <DropImage name='banner' onImageUpload={handleChange} />
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