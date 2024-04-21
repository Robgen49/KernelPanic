import { getToken } from "../utils/getToken"

export const fetchTeams = async () => {
   return fetch(`http://213.171.6.223:8080/api/team/findAll`, {
      method: "GET",
      headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer " + getToken(),
      }
   })
}