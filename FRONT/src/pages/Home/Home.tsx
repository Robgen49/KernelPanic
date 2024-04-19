import classNames from 'classnames';
import cls from './Home.module.scss';

interface HomeProps {
   className?: string;
}

export const Home = (props: HomeProps) => {

const { className } = props

   return (
      <div className={classNames(className, cls.Home)}>
         Home
      </div>
   );
};