import { createBrowserRouter } from "react-router-dom";
import { Home } from "../pages/Home/Home";
import Error from "../pages/Error/Error";
import SignIn from "../modules/SignIn/SignIn";
import SignUp from "../modules/SignUp/SignUp";
import { Profile } from "../pages/Profile/Profile";

export const router = createBrowserRouter([
   {
      path: "/",
      element: <Home />,
      errorElement: <Error />,
   },
   {
      path: "/auth/login",
      element: <SignIn />
   },
   {
      path: "/auth/registration",
      element: <SignUp />
   }, 
   {
      path: "/profile",
      element: <Profile allowEdit />,
   },
   {
      path: "/profile/:id",
      element: <Profile allowEdit={false} />,
   }
])
