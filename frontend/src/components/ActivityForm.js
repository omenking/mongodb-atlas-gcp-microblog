import './ActivityForm.css';
import React from "react";

export default function ActivityForm() {
  const [count, setCount] = React.useState(0);
  const [message, setMessage] = React.useState('');

  const classes = []
  classes.push('count')
  if (240-count < 0){
    classes.push('err')
  }

  const onsubmit = async (event) => {
    console.log('submitting', message);
    try {
      let res = await fetch("https://localhost:4567/api/activities", {
        method: "POST",
        body: JSON.stringify({
          message: message
        }),
      });
      let resJson = await res.json();
      if (res.status === 200) {
        console.log(res,resJson)
      } else {
        console.log(res)
      }
    } catch (err) {
      console.log(err);
    }
    event.preventDefault();
  }

  const textarea_onchange = (event) => {
    setCount(event.target.value.length);
    setMessage(event.target.value);
  }

  return (
    <form 
      className='activity_form'
      onSubmit={onsubmit}
    >
      <textarea
        type="text"
        placeholder="what would you like to say?"
        value={message}
        onChange={textarea_onchange} 
      />
      <div className='submit'>
        <div className={classes.join(' ')}>{240-count}</div>
        <button type='submit'>Submit</button>
      </div>
    </form>
  );
}