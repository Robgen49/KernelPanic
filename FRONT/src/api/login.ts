export const fetchLogin = async ({login, password}: {login: string, password: string}) => {
   return fetch(`http://213.171.6.223:8080/api/auth/signin`, {
      method: "POST",
      headers: {
         "Content-Type": "application/json"
      },
      body: JSON.stringify({login, password})
   })
}