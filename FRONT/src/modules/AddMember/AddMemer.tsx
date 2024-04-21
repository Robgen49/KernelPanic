import Box from '@mui/material/Box';
import Modal from '@mui/material/Modal';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import { Grid, TextField, useMediaQuery } from '@mui/material';
import DropImage from '../../components/DropImage/DropImage';
import { useState } from 'react';
import { Member } from '../SignUp/SignUp';
import { Toast } from '../../components/Alert';

interface AddMemerProps {
   className?: string;
   open: boolean;
   handleClose: () => void;
   setMembers: React.Dispatch<React.SetStateAction<Member[]>>;
   setErrorAlertOpen: React.Dispatch<React.SetStateAction<boolean>>
}

export const AddMemer = ({ open, handleClose, setMembers, setErrorAlertOpen }: AddMemerProps) => {
   const [file, setFile] = useState<string>();
   const handleChange = (file: string) => {
      setFile(file);
   };

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      if (file === null || file?.length === 0 || !file) {
         setErrorAlertOpen(true);
         return;
      }
      setMembers(members => [...members, {
         full_name: data.get('full_name') as string,
         photo: file,
         assessment: data.get('assessment') as string,
         difficulties: data.get('difficulties') as string,
         stack_tech: data.get('stack_tech') as string,
         direction: data.get('direction') as string
      }])
      handleClose()
   };

   const isMobile = useMediaQuery('(max-width: 420px)');

   const style = {
      position: 'absolute' as 'absolute',
      top: '50%',
      left: '50%',
      transform: 'translate(-50%, -50%)',
      width: isMobile ? 300 : 400,
      bgcolor: 'background.paper',
      border: '2px solid #000',
      boxShadow: 24,
      p: 4,
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

            <Box component="form" onSubmit={handleSubmit} sx={{ mt: 3, display: 'flex', flexDirection: 'column', gap: 2 }}>
               <Grid container spacing={2}>
                  <Grid item xs={12} sm={12}>
                     <Box display={'flex'} alignItems={'center'} justifyContent={'space-between'}>
                        <Typography>
                           Фото участника
                        </Typography>
                        <Box sx={{ width: '50%' }} >
                           <DropImage allowEdit={true} name='photo' onImageUpload={handleChange} />
                        </Box>
                     </Box>
                  </Grid>
                  <Grid item xs={12} sm={12}>
                     <TextField
                        autoComplete="given-name"
                        name="full_name"
                        required
                        fullWidth
                        id="title"
                        label="ФИО участника"
                     />
                  </Grid>
                  <Grid item xs={12}>
                     <TextField
                        required
                        fullWidth
                        id="stack_tech"
                        label="Стек технологий"
                        name="stack_tech"
                     />
                  </Grid>
                  <Grid item xs={12}>
                     <TextField
                        required
                        fullWidth
                        id="direction"
                        label="Направление"
                        name="direction"
                     />
                  </Grid>
                  <Grid item xs={12}>
                     <TextField
                        required
                        fullWidth
                        id="assessment"
                        InputLabelProps={{ sx: { fontSize: isMobile ? 10 : 14 } }}
                        label="Оцените свой вклад в данной работе"
                        name="assessment"
                     />
                  </Grid>
                  <Grid item xs={12}>
                     <TextField
                        required
                        fullWidth
                        InputLabelProps={{ sx: { fontSize: isMobile ? 10 : 14 } }}
                        id="difficulties"
                        label="С какими трудностями столкнулись"
                        name="difficulties"
                     />
                  </Grid>
               </Grid>
               <Button type='submit' variant='contained' color='secondary'>Добавить</Button>

            </Box>
         </Box>
      </Modal>
   );
};