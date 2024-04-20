import { Navbar } from '../../components/Navbar/Navbar';
import { Box } from '@mui/material';
import { useState } from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination, Parallax } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';
import './parallax.css';
import { Team, TeamProps } from '../../components/Team/Team';
import useWindowDimensions from '../../hooks/useWindowDimensions';


export const Home = () => {

   const dimensions = useWindowDimensions();

   const [currentIndex, setCurrentIndex] = useState(0);

   const members = [
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
      {
         fio: 'Иванов Иван Иванович',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s',
         description: 'Описание',
      },
   ]

   const [teams, setItems] = useState<TeamProps[]>([
      { title: 'Авиатек', img: 'https://aviationweek.com/sites/default/files/styles/crop_freeform/public/2021-12/PHOTO2021-BEST-Aldo_Wicki.jpg?itok=sLkNUOuT', members: members },
      { title: 'Энкриптед', img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s', members: members },
      { title: 'Фрипик', img: 'https://img.freepik.com/premium-photo/wide-angle-shot-of-a-single-tree-growing-under-a-clouded-sky-during-a-sunset-surrounded-by-grass_1033124-10.jpg', members: members },
      { title: '4', img: 'https://img.freepik.com/premium-photo/wide-angle-shot-of-a-single-tree-growing-under-a-clouded-sky-during-a-sunset-surrounded-by-grass_1033124-10.jpg', members: members },
      { title: '5', img: 'https://aviationweek.com/sites/default/files/styles/crop_freeform/public/2021-12/PHOTO2021-BEST-Aldo_Wicki.jpg?itok=sLkNUOuT', members: members },
      { title: '6', img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s', members: members },
      { title: '7', img: 'https://aviationweek.com/sites/default/files/styles/crop_freeform/public/2021-12/PHOTO2021-BEST-Aldo_Wicki.jpg?itok=sLkNUOuT', members: members },
      { title: '8', img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_Huo2vi-aVrM4k-Zvmv8Fb6ikn9SXMW3GTcrGBgGvg&s', members: members },
      { title: '9', img: 'https://img.freepik.com/premium-photo/wide-angle-shot-of-a-single-tree-growing-under-a-clouded-sky-during-a-sunset-surrounded-by-grass_1033124-10.jpg', members: members },
   ]);


   return (
      <Box height={'100vh'} display={'flex'} flexDirection={'column'}>
         <Navbar />
         <Box sx={{ flexGrow: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
            <Swiper
               modules={[Navigation, Pagination, Parallax]}
               navigation
               parallax={true}
               pagination={{ clickable: true }}
               slidesPerView={dimensions.width < 600 ? 1 : dimensions.width < 1200 ? 2 : dimensions.width < 1800 ? 3 : 4}
               onActiveIndexChange={(event) => setCurrentIndex(event.activeIndex)}
            >
               <div
                  slot="container-start"
                  className="parallax-bg"
                  style={{
                     backgroundImage: `url(${teams[currentIndex].img})`,
                     'filter': 'blur(20px)',
                  }}
                  data-swiper-parallax="-23%"
               ></div>
               {teams.map((item, index) => (
                  <SwiperSlide key={index}>
                     <Team title={item.title} img={item.img} members={item.members} />
                  </SwiperSlide>
               ))}
            </Swiper>
         </Box>
      </Box>
   );
};