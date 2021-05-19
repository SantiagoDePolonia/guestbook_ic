import guestbook from 'ic:canisters/guestbook';

guestbook.insert(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
