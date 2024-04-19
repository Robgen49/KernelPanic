import { createBrowserRouter } from "react-router-dom";
import { Auth } from "../pages/Auth/Auth";
import { Home } from "../pages/Home/Home";
import Error from "../pages/Error/Error";

export const router = createBrowserRouter([
   {
      path: "/",
      element: <Home/>,
      errorElement: <Error />,
      children: [
         {
            path: "auth/",
            element: <Auth />,
         },
      ],
   },
   {
      path: ""
   }])
