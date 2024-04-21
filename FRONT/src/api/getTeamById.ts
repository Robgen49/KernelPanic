import { getToken } from "../utils/getToken"

export const fetchTeamById = async (id: number) => {
   return fetch(`http://213.171.6.223:8080/api/team/findById?id=${id}`, {
      method: "GET",
      headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer " + getToken(),
      }
   })
}