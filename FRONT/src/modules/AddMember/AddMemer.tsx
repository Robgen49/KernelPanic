import Box from '@mui/material/Box';
import Modal from '@mui/material/Modal';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import { Grid, TextField } from '@mui/material';
import DropImage from '../../components/DropImage/DropImage';
import { useState } from 'react';
import { Member } from '../SignUp/SignUp';

const style = {
   position: 'absolute' as 'absolute',
   top: '50%',
   left: '50%',
   transform: 'translate(-50%, -50%)',
   width: 400,
   bgcolor: 'background.paper',
   border: '2px solid #000',
   boxShadow: 24,
   p: 4,
};

interface AddMemerProps {
   className?: string;
   open: boolean;
   handleClose: () => void;
   setMembers: React.Dispatch<React.SetStateAction<Member[]>>;
}

export const AddMemer = ({open, handleClose, setMembers}: AddMemerProps) => {
   const [file, setFile] = useState<File>();
   const handleChange = (file: File) => {
      setFile(file);
   };

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      console.log(data.get('image'))
      setMembers(members => [...members, {
         fio: data.get('fio') as string,
         image: data.get('image') as File,
         description: data.get('description') as string,
      }])
      handleClose()
   };

   return (
      <Modal
         open={open}
         onClose={handleClose}
      >
         <Box sx={style}>
            <Typography id="keep-mounted-modal-title" variant="h6" component="h2">
               Добавление участника
            </Typography>

            <Box component="form" noValidate onSubmit={handleSubmit} sx={{ mt: 3, display: 'flex', flexDirection: 'column', gap: 2 }}>
               <Grid container spacing={2}>
                  <Grid item xs={12} sm={12}>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'}>
                        <Typography>
                           Фото участника
                        </Typography>
                        <Box sx={{ width: '50%' }} >
                           <DropImage name='image' onImageUpload={handleChange} />
                        </Box>
                     </Box>
                  </Grid>
                  <Grid item xs={12} sm={12}>
                     <TextField
                        autoComplete="given-name"
                        name="fio"
                        required
                        fullWidth
                        id="title"
                        label="ФИО участника"
                        autoFocus
                     />
                  </Grid>
                  <Grid item xs={12}>
                     <TextField
                        required
                        fullWidth
                        id="description"
                        label="Краткое резюме"
                        name="email"
                        autoComplete="email"
                     />
                  </Grid>
               </Grid>
               <Button type='submit' variant='contained' color='secondary'>Добавить</Button>

            </Box>
         </Box>
      </Modal>
   );
};