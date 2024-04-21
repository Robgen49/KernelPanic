import classNames from 'classnames';
import cls from './Team.module.scss';
import { Member } from '../../modules/SignUp/SignUp';
import { Member as MemberComponent } from '../../modules/Member/Member';
import { Backdrop, Box, CircularProgress, Typography } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { fetchMyTeam } from '../../api/getMyTeam';

export interface TeamProps {
   id: number;
   teamName: string;
   logo: string;
   email: string;
   login: string;
   password: string;
   teammates: Member[];
}

export const Team = ({ id, teamName, logo, teammates }: TeamProps) => {
   const [myTeamId, setTeamId] = useState<number>(null);
   const [showLoader, setShowLoader] = useState(true);
   useEffect(() => {
      fetchMyTeam().then((data) => data.json()).then((data) => {
         setTeamId(Number(data.id));
         setShowLoader(false);
      })
   }, [])

   const navigate = useNavigate();
   if (logo.slice(0, 4) !== "data") {
      logo = `data:image/jpeg;base64,${logo}`
   }

   return (

      <div onClick={() => { if (id !== myTeamId) navigate('profile/' + id); else navigate('profile') }} className={cls.wrapper}>
         <Backdrop sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }} open={showLoader}>
            <CircularProgress color="secondary" />
         </Backdrop>
         <div className={cls.title}>
            <Typography color="text.secondary">
               {teamName}
            </Typography>
         </div>
         <div className={cls.image}>
            <img className={cls.img} src={logo} alt="team" />
         </div>
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
            {teammates.map((member, index) => <MemberComponent key={index} fio={member.full_name} avatar={member.photo} />)}
         </Box>
      </div>
   );
};