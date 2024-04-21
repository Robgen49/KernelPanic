import { Member } from "../modules/SignUp/SignUp";
import { getToken } from "../utils/getToken";

export const fetchUpdateMyMember = async (member: Member) => {
   return fetch(`http://213.171.6.223:8080/api/person/update`, {
      method: "PATCH",
      headers: {
         "Content-Type": "application/json",
         "Authorization": `Bearer ${getToken()}`,
      },
      body: JSON.stringify(member)
   })
}