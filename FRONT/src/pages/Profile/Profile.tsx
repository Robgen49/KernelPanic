import { Box, Button, CircularProgress, Container, Tab, Tabs, TextField, Typography } from '@mui/material';
import { Navbar } from '../../components/Navbar/Navbar';
import { useEffect, useState } from 'react';
import { TeamProps } from '../../components/Team/Team';
import DropImage from '../../components/DropImage/DropImage';
import { Member } from '../../modules/SignUp/SignUp';
import useMediaQuery from '@mui/material/useMediaQuery';
import { useLocation, useNavigate } from 'react-router-dom';
import { Toast } from '../../components/Alert';
import { fetchTeamById } from '../../api/getTeamById';
import { getToken } from '../../utils/getToken';
import { fetchUpdateMyTeam, updateTeam } from '../../api/updateMyTeam';
import { fetchMyTeam } from '../../api/getMyTeam';

interface ProfileProps {
   allowEdit: boolean;
}

export const Profile = ({ allowEdit }: ProfileProps) => {
   const location = useLocation();
   const id = location.pathname.split('/').pop();
   const [loader, setLoader] = useState(true);
   const [editMode, setEditMode] = useState(false);
   const [team, setTeam] = useState<updateTeam>({} as TeamProps);
   const [currentMember, setCurrentMember] = useState<Member>({} as Member);
   const [successAlertOpen, setSuccessAlertOpen] = useState(false);
   const [errorAlertOpen, setErrorAlertOpen] = useState(false);

   const navigate = useNavigate();

   useEffect(() => {
      if (getToken() === null) {
         navigate('/auth/login');
      }
      else {
         fetchTeamById(Number(id)).then((data) => data.json()).then((data: TeamProps) => {
            setTeam({ id: data.id, teamName: data.teamName, logo: data.logo, teammates: data.teammates });
            setCurrentMember(data.teammates[0]);
            setLoader(false);
         }).catch(() => { throw Error('Team not found') })
      }
   }, [])

   const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
      event.preventDefault();
      fetchUpdateMyTeam({ id: team.id, teamName: team.teamName, logo: team.logo, teammates: [currentMember] })
         .then((data) => data.json())
         .then((data) => {
            setSuccessAlertOpen(true);
         })
         .catch(() => {
            setErrorAlertOpen(true);
         })
   }

   const mediaQuery = useMediaQuery('(max-width: 600px)');

   if (loader)
      return <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}><CircularProgress color='secondary' /></Box>

   return (
      <Box height={'100vh'} display={'flex'} flexDirection={'column'}>
         <Navbar />
         <Toast
            open={successAlertOpen}
            handleClose={() => setSuccessAlertOpen(false)}
            message={'Успешно обновлено'} result={'success'} />
         <Toast
            open={errorAlertOpen}
            handleClose={() => setErrorAlertOpen(false)}
            message={'Ошибка при обновлении'}
            result={'error'} />
         <Container component="form" onSubmit={handleSubmit} sx={{ flexGrow: 1 }} >
            <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2, justifyContent: 'center', alignItems: 'center' }} >
               {editMode ? <TextField
                  color='secondary'
                  required
                  sx={{ mt: 4 }}
                  name='title'
                  value={team.teamName}
                  label="Название команды"
                  onInput={(e) => setTeam(
                     {
                        ...team, teamName: (e.target as HTMLInputElement).value
                     })} />
                  :
                  <Typography color='secondary' mt={4} mb={4} variant="h3" fontWeight={600} >{team.teamName}</Typography>}
               <Box sx={{ mb: 4 }}>
                  <DropImage
                     allowEdit={editMode}
                     name='img'
                     imagePreviewOutside={team.logo}
                     onImageUpload={(file) => setTeam({ ...team, logo: file })} />
               </Box>
            </Box>
            <Tabs
               value={currentMember.id}
               onChange={(event: React.SyntheticEvent<Element, Event>, value: string) => {
                  setTeam({ ...team, teammates: team.teammates.map(member => member.id?.toString() === value ? currentMember : member) });
                  setCurrentMember(team.teammates.find(member => member.id === value));
               }}
               textColor="secondary"
               indicatorColor="secondary"
               aria-label="secondary tabs example"
               variant='fullWidth'
               sx={{ mb: 2 }}
            >
               {team.teammates.map((member, index) => <Tab key={index} value={member.id} label={member.full_name} />)}
            </Tabs>
            <Box display={'flex'} flexDirection={mediaQuery ? 'column' : 'row'} gap={2} >
               <Box sx={{ width: mediaQuery ? '100%' : '50%' }}>
                  <DropImage
                     allowEdit={editMode}
                     name='image'
                     imagePreviewOutside={currentMember.photo}
                     onImageUpload={(file) => setCurrentMember({ ...currentMember, photo: file })}
                  />
               </Box>
               <Box flex={1} display={'flex'} flexDirection={'column'} gap={2}  >
                  <Box display={'flex'} flexDirection={'column'} gap={2} mb={mediaQuery ? 2 : 0}>

                     {editMode ?
                        <TextField
                           autoComplete="given-name"
                           name="fio"
                           required
                           fullWidth
                           id="fio"
                           label="ФИО участника"
                           value={currentMember.full_name}
                           onInput={(e) => {
                              setCurrentMember({ ...currentMember, full_name: (e.target as HTMLInputElement).value })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           ФИО участника: <Typography fontWeight={600} color='secondary'>{currentMember.full_name}</Typography>
                        </Typography>
                     }

                     {editMode ?
                        <TextField
                           required
                           fullWidth
                           id="stack_tech"
                           label="Стек технологий"
                           name="stack_tech"
                           multiline
                           value={currentMember.stack_tech}
                           onInput={(e) => {
                              setCurrentMember({ ...currentMember, stack_tech: (e.target as HTMLInputElement).value })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           Стек технологий: <Typography fontWeight={600} color='secondary'>{currentMember.stack_tech}</Typography>
                        </Typography>
                     }

                     {editMode ?
                        <TextField
                           required
                           fullWidth
                           id="direction"
                           label="Направление"
                           name="direction"
                           multiline
                           value={currentMember.direction}
                           onInput={(e) => {
                              setCurrentMember({ ...currentMember, direction: (e.target as HTMLInputElement).value })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           Направление: <Typography fontWeight={600} color='secondary'>{currentMember.direction}</Typography>
                        </Typography>
                     }

                     {editMode ?
                        <TextField
                           required
                           fullWidth
                           id="assessment"
                           label="Оцените свой вклад в данной работе"
                           name="assessment"
                           multiline
                           value={currentMember.assessment}
                           onInput={(e) => {
                              setCurrentMember({ ...currentMember, assessment: (e.target as HTMLInputElement).value })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           Оцените свой вклад в данной работе: <Typography fontWeight={600} color='secondary'>{currentMember.assessment}</Typography>
                        </Typography>
                     }

                     {editMode ?
                        <TextField
                           required
                           fullWidth
                           id="difficulties"
                           label="С какими трудностями вы столкнулись"
                           name="difficulties"
                           multiline
                           value={currentMember.difficulties}
                           onInput={(e) => {
                              setCurrentMember({ ...currentMember, difficulties: (e.target as HTMLInputElement).value })
                           }}
                        />
                        :
                        <Typography color='text.secondary' >
                           С какими трудностями вы столкнулись: <Typography fontWeight={600} color='secondary'>{currentMember.difficulties}</Typography>
                        </Typography>
                     }
                  </Box>
                  {allowEdit &&
                     <Box>
                        <Button type={!editMode ? 'submit' : 'button'} sx={{ mb: mediaQuery ? 2 : 0 }} variant='contained' color='secondary' onClick={() => setEditMode(!editMode)} >
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