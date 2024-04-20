import cls from './Member.module.scss';
import { Avatar, Tooltip } from '@mui/material';

interface MemberProps {
   fio: string;
   avatar?: string;
   id?: number;
}

export const Member = ({ fio, avatar }: MemberProps) => {

   return (
      <div className={cls.wrapper}>
         <Tooltip title={fio} placement="bottom" arrow >
            <Avatar src={avatar} sx={{ width: 50, height: 50 }} />
         </Tooltip>
      </div>
   );
};