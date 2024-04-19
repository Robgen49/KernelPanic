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
         <Typography variant="h4" className={cls.errorMessage}>
            Упс! Что-то пошло не так.
         </Typography>
         <Typography variant="body1" className={cls.errorMessage}>
            {message}
         </Typography>
         <Button
            variant="contained"
            color="primary"
            className={cls.button}
            onClick={handleRefresh}
         >
            Перезагрузить страницу
         </Button>
      </div>
   );
};

export default Error;
