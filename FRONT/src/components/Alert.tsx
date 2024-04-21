import Snackbar from '@mui/material/Snackbar';
import Alert from '@mui/material/Alert';
import { Slide, SlideProps } from '@mui/material';

export interface ToastProps {
   open: boolean;
   handleClose: () => void;
   message: string;
   result: "success" | "error" | "warning" | "info";
}

function SlideTransition(props: SlideProps) {
   return <Slide {...props} direction="left" />;
}

export const Toast = ({ open, handleClose, message, result }: ToastProps) => {

   return (
      <div>
         <Snackbar TransitionComponent={SlideTransition} anchorOrigin={{ vertical: 'top', horizontal: 'right' }} open={open} autoHideDuration={4000} onClose={handleClose}>
            <Alert
               onClose={handleClose}
               severity={result}
               variant="filled"
               sx={{ width: '100%' }}
            >
               {message}
            </Alert>
         </Snackbar>
      </div>
   );
}