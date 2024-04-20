import React from 'react';
import {Typography, Button } from '@mui/material';
import cls from './Error.module.scss'


interface ErrorProps {
   message?: string;
}

const Error: React.FC<ErrorProps> = ({ message }) => {

   const handleRefresh = () => {
      window.location.reload();
   };

   return (
      <div className={cls.root}>
         <Typography sx={{mb: 0, fontSize: 32}}>
            Упс! Что-то пошло не так.
         </Typography>
         {message && message.length > 0 && <Typography sx={{ mb: 5, fontSize: 24 }}>
            {message}
         </Typography>}
      </div>
   );
};

export default Error;
