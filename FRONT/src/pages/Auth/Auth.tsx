import classNames from 'classnames';
import cls from './Auth.module.scss';

interface AuthProps {
   className?: string;
}

export const Auth = (props: AuthProps) => {

const { className } = props

   return (
      <div className={classNames(className, cls.Auth)}>
      Auth
      </div>
   );
};