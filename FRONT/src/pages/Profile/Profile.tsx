import { Box, Button, Container, Tab, Tabs, TextField, Typography } from '@mui/material';
import { Navbar } from '../../components/Navbar/Navbar';
import { useState } from 'react';
import { TeamProps } from '../../components/Team/Team';
import DropImage from '../../components/DropImage/DropImage';
import { Member } from '../../modules/SignUp/SignUp';
import useMediaQuery from '@mui/material/useMediaQuery';


interface ProfileProps {
   allowEdit: boolean;
}

export const Profile = ({ allowEdit }: ProfileProps) => {
   const [editMode, setEditMode] = useState(false);
   const [team, setInfo] = useState<TeamProps>({
      title: 'Test Team',
      img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
      members: [
         {
            fio: "Генрих Роберт Артурович",
            description: 'Frontend Dev',
            image: 'https://img.freepik.com/premium-photo/wide-angle-shot-of-a-single-tree-growing-under-a-clouded-sky-during-a-sunset-surrounded-by-grass_1033124-10.jpg'
         },
         {
            fio: "Прощалыкин Николай Константинович",
            description: 'Ios Dev',
            image: 'https://aviationweek.com/sites/default/files/styles/crop_freeform/public/2021-12/PHOTO2021-BEST-Aldo_Wicki.jpg?itok=sLkNUOuT'
         },

      ]

   });

   const [currentMember, setCurrentMember] = useState<Member>(team.members[0]);

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      const data = new FormData(event.currentTarget);
      setInfo({
         ...team, members: [...team.members, {
            fio: data.get('fio') as string,
            image: data.get('image') as File,
            description: data.get('description') as string,
         }]
      })
   }

   const mediaQuery = useMediaQuery('(max-width: 600px)');

   return (
      <Box height={'100vh'} display={'flex'} flexDirection={'column'}>
         <Navbar />
         <Container sx={{ flexGrow: 1 }} >
            <Box component="form" onSubmit={handleSubmit} noValidate sx={{ display: 'flex', flexDirection: 'column', gap: 2, justifyContent: 'center', alignItems: 'center' }} >
               {editMode ? <TextField
                  color='secondary'
                  sx={{ mt: 4, mb: 4 }}
                  name='title'
                  value={team.title}
                  label="Название команды"
                  onInput={(e) => setInfo(
                     {
                        ...team, title: (e.target as HTMLInputElement).value

                     })} />
                  :
                  <Typography color='secondary' mt={4} mb={4} variant="h3" fontWeight={600} >{team.title}</Typography>}
               <Box sx={{ mb: 4 }}>
                  <DropImage
                     allowEdit={editMode}
                     name='img'
                     imagePreviewOutside={team.img}
                     onImageUpload={(file) => setInfo({ ...team, img: URL.createObjectURL(file) })} />
               </Box>
            </Box>
            <Tabs
               value={currentMember.fio}
               onChange={(event: React.SyntheticEvent<Element, Event>, value: any) => setCurrentMember(team.members.find(member => member.fio === value))}
               textColor="secondary"
               indicatorColor="secondary"
               aria-label="secondary tabs example"
               variant='fullWidth'
               sx={{ mb: 2 }}
            >
               {team.members.map((member, index) => <Tab key={index} value={member.fio} label={member.fio} />)}
            </Tabs>
            <Box display={'flex'} flexDirection={mediaQuery ? 'column' : 'row'} gap={2} >
               <Box sx={{ width: mediaQuery ? '100%' : '50%' }}>
                  <DropImage
                     allowEdit={editMode}
                     name='image'
                     imagePreviewOutside={currentMember.image instanceof File ? URL.createObjectURL(currentMember.image) : currentMember.image}
                     onImageUpload={(file) => setInfo({ ...team, members: [...team.members, { ...currentMember, image: URL.createObjectURL(file) }] })}
                  />
               </Box>
               <Box flex={1} display={'flex'} flexDirection={'column'} justifyContent={'space-between'}  >
                  <Box display={'flex'} flexDirection={'column'} gap={2} mb={mediaQuery ? 2 : 0}>
                     {editMode ?
                        <TextField
                           autoComplete="given-name"
                           name="fio"
                           required
                           fullWidth
                           id="fio"
                           label="ФИО участника"
                           value={currentMember.fio}
                           onInput={(e) => {
                              const copy = [...team.members];
                              copy.filter(member => member.fio === currentMember.fio)[0].fio = (e.target as HTMLInputElement).value;
                              setInfo({ ...team, members: copy })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           ФИО участника: <Typography fontWeight={600} color='secondary'>{currentMember.fio}</Typography>
                        </Typography>
                     }
                     {editMode ?
                        <TextField
                           required
                           fullWidth
                           id="description"
                           label="Краткое резюме"
                           name="description"
                           multiline
                           value={currentMember.description}
                           onInput={(e) => {
                              const copy = [...team.members];
                              copy.filter(member => member.description === currentMember.description)[0].description = (e.target as HTMLInputElement).value;
                              setInfo({ ...team, members: copy });
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           Краткое резюме: <Typography fontWeight={600} color='secondary'>{currentMember.description}</Typography>
                        </Typography>

                     }

                  </Box>
                  {allowEdit &&
                     <Box>
                        <Button sx={{ mb: mediaQuery ? 2 : 0 }} variant='contained' color='secondary' onClick={() => setEditMode(!editMode)} >
                           {editMode ? 'Сохранить' : 'Редактировать'}
                        </Button>
                     </Box>
                  }
               </Box>
            </Box>
         </Container>
      </Box>
   );
};