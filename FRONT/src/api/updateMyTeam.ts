import { Member } from "../modules/SignUp/SignUp"
import { getToken } from "../utils/getToken"

export interface updateTeam{
   id: number
   teamName: string
   logo: string
   teammates?: Member[]
}

export const fetchUpdateMyTeam = async (team: updateTeam) => {
   return fetch(`http://213.171.6.223:8080/api/team/update`, {
      method: "PATCH",
      headers: {
         "Content-Type": "application/json",
         "Authorization": `Bearer ${getToken()}`,
      },
      body: JSON.stringify(team)
   })
}