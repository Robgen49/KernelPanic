import { getToken } from "../utils/getToken"

export const fetchMyTeam = async () => {
   return fetch(`http://213.171.6.223:8080/api/team/currentTeam`, {
      method: "GET",
      headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer " + getToken(),
      }
   }) 
}