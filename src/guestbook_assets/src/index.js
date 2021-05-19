import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as guestbook_idl, canisterId as guestbook_id } from 'dfx-generated/guestbook';

const agent = new HttpAgent();
const guestbook = Actor.createActor(guestbook_idl, { agent, canisterId: guestbook_id });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  const greeting = await guestbook.insert(name);

  document.getElementById("greeting").innerText = greeting;
});
