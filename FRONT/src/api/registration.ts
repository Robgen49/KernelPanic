import { uploadTeam } from "../modules/SignUp/SignUp"
export const fetchRegistration = async (team: uploadTeam) => {
   return fetch(`http://213.171.6.223:8080/api/auth/signup`, {
      method: "POST",
      headers: {
         "Content-Type": "application/json"
      },
      body: JSON.stringify(team)
   })
}