import { Navbar } from '../../components/Navbar/Navbar';
import { Box, CircularProgress } from '@mui/material';
import { useEffect, useState } from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination, Parallax } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';
import './parallax.css';
import { Team, TeamProps } from '../../components/Team/Team';
import useWindowDimensions from '../../hooks/useWindowDimensions';
import { useLocation, useNavigate } from 'react-router-dom';
import { Toast } from '../../components/Alert';
import { fetchTeams } from '../../api/getTeams';
import { getToken } from '../../utils/getToken';

export const Home = () => {

   const dimensions = useWindowDimensions();

   const location = useLocation();
   const isSuccessAlertOpen = location?.state?.successAlertOpen || false;
   const [successAlertOpen, setSuccessAlertOpen] = useState(isSuccessAlertOpen);
   const [errorAlert, setErrorAlert] = useState(false);
   const [loader, setLoader] = useState(true);
   const [currentIndex, setCurrentIndex] = useState(1);
   const [teams, setTeams] = useState<TeamProps[]>({} as TeamProps[]);
   const navigate = useNavigate();
   useEffect(() => {

      if (getToken() === null) {
         navigate('/auth/login');
      }
      else {
         fetchTeams().then((data) => data.json()).then((data) => {
            setTeams(data);
            setLoader(false);
         }).catch(() => {
            setErrorAlert(true);
         })
      }
   }, [])

   if (!(teams.length > 0)) {
      return (
         <Box height={'100vh'} display={'flex'} justifyContent={'center'} alignItems={'center'}>
            <CircularProgress />
         </Box>
      )
   }
   return (
      <Box height={'100vh'} display={'flex'} flexDirection={'column'}>
         <Navbar />
         <Toast open={errorAlert} handleClose={() => setErrorAlert(false)} message={'Произошла ошибка при загрузке команд!'} result={'error'} />
         <Toast open={successAlertOpen} handleClose={() => setSuccessAlertOpen(false)} message={'Вы успешно вошли!'} result={'success'} />
         <Box sx={{ flexGrow: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
            <Swiper
               modules={[Navigation, Pagination, Parallax]}
               navigation
               parallax={true}
               loop={true}
               pagination={{ clickable: true }}
               slidesPerView={dimensions.width < 780 ? 1 : dimensions.width < 1400 ? 2 : dimensions.width < 1800 ? 3 : 4}
               onActiveIndexChange={(event) =>{console.log(event); setCurrentIndex(event.activeIndex)}}
            >
               <div
                  slot="container-start"
                  className="parallax-bg"
                  style={{
                     backgroundImage: `url(${teams[currentIndex].logo})`,
                     'filter': 'blur(20px)',
                  }}
                  data-swiper-parallax="-23%"
               ></div>
               {teams.map((item, index) => (
                  <SwiperSlide key={index}>
                     <Team {...item} />
                  </SwiperSlide>))}
            </Swiper>
         </Box>
      </Box >
   );
};