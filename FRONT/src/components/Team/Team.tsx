import classNames from 'classnames';
import cls from './Team.module.scss';
import { Member } from '../../modules/SignUp/SignUp';
import { Member as MemberComponent } from '../../modules/Member/Member';
import { Box, Typography } from '@mui/material';

export interface TeamProps {
   title: string;
   img: string;
   members: Member[];
}

export const Team = ({ title, img, members }: TeamProps) => {

   return (
      <div className={cls.wrapper}>
         <div className={cls.title}>
            <Typography color="text.secondary">
               {title}
            </Typography>
         </div>
         <div className={cls.image}>
            <img className={cls.img} src={img} alt="team" />
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
            {members.map((member, index) => <MemberComponent key={index} fio={member.fio} avatar={member.image && member.image instanceof File ? URL.createObjectURL(member.image) : member.image} />)}
         </Box>
      </div>
   );
};