import React, { useEffect, useId, useState } from 'react';
import styles from './DropImage.module.scss';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { Box } from '@mui/material';
interface DropImageProps {
   onImageUpload: (file: string) => void;
   name: string;
   imagePreviewOutside?: string;
   allowEdit?: boolean;
}

const DropImage: React.FC<DropImageProps> = ({ onImageUpload, name, imagePreviewOutside, allowEdit }: DropImageProps) => {
   const [imagePreview, setImagePreview] = useState<string | null>(imagePreviewOutside || '');

   useEffect(() => {
      setImagePreview(imagePreviewOutside || '');
   }, [imagePreviewOutside]);

   const handleFileDrop = (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
      const file = event.dataTransfer.files[0];
      handleImage(file);
   };

   const handleImageSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
      const file = event.target.files ? event.target.files[0] : null;
      if (file) {
         handleImage(file);
      }
   };

   const handleImage = (file: File) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
         const image = reader.result as string;
         setImagePreview(image);
         onImageUpload(image);
      };
   };

   const preventDefault = (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
      event.stopPropagation();
   };

   const id = useId();

   return (
      <>
         {allowEdit ?

            <div
               className={styles.dropArea}
               onDrop={handleFileDrop}
               onDragOver={preventDefault}
               onDragEnter={(event: React.DragEvent<HTMLDivElement>) => {
                  const div = event.target as HTMLDivElement;
                  div.classList.add(styles.dragEnter)
               }}
               onDragLeave={(event: React.DragEvent<HTMLDivElement>) => {
                  const div = event.target as HTMLDivElement;
                  div.classList.remove(styles.dragEnter)
               }}
            >
               <input
                  type="file"
                  accept="image/*"
                  name={name}
                  style={{ display: 'none' }}
                  onChange={handleImageSelect}
                  id={id}
               />
               <label style={{ width: '100%', height: '100%', display: 'flex', justifyContent: 'center', alignItems: 'center' }} htmlFor={id}>
                  {imagePreview ? <Box sx={{ maxWidth: 400, display: 'flex', justifyContent: 'center', alignItems: 'center' }}><img className={styles.img} src={imagePreview} alt="Uploaded" /> </Box> :
                     <Box sx={{ maxWidth: 400, display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                        <CloudUploadIcon sx={{ fontSize: 50 }} color="primary" />
                     </Box>
                  }
               </label>
            </div >
            :
            <div style={{ width: '100%', height: '100%', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
               {imagePreview && <Box sx={{ maxWidth: 400, display: 'flex', justifyContent: 'center', alignItems: 'center' }}> <img className={styles.img} src={imagePreview} alt="Uploaded" /></Box>}
            </div>
         }
      </>

   );
};

export default DropImage;
