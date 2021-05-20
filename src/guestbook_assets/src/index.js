import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as guestbook_idl, canisterId as guestbook_id } from 'dfx-generated/guestbook';

const agent = new HttpAgent();
const guestbook = Actor.createActor(guestbook_idl, { agent, canisterId: guestbook_id });

setLoading(true);

guestbook.getJson()
  .then(guestbook_raw => {
    insertList(guestbook_raw);
    setLoading(false);
  });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  setLoading(true);
  const name = document.getElementById("name").value.toString();
  const guestbook_raw = await guestbook.insert(name);
  insertList(guestbook_raw)
  setLoading(false);
});


function insertList(guestbook_raw) {
  const guestbook_json = JSON.parse(guestbook_raw);

  const guestbookList = guestbook_json.reverse().reduce((ac, name) => {
    return ac + "\n<li>" + name + "</li>"
  }, "");

  document.getElementById("greeting").innerHTML = guestbookList;
}

function setLoading(val = true) {
  const loading = document.getElementById("LOADING");

  if(val) {
    loading.style.display = "block";
  } else {
    loading.style.display = "none";
  }
}
