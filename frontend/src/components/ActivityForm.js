import './ActivityForm.css';
import React from "react";
import process from 'process';

export default function ActivityForm(props) {
  const [count, setCount] = React.useState(0);
  const [message, setMessage] = React.useState('');

  const classes = []
  classes.push('count')
  if (240-count < 0){
    classes.push('err')
  }

  const onsubmit = async (event) => {
    event.preventDefault();
    try {
      const backend_url = `${process.env.REACT_APP_BACKEND_URL}/api/activities`
      console.log('onsubmit payload', message)
      const res = await fetch(backend_url, {
        method: "POST",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          message: message
        }),
      });
      let activity = await res.json();
      if (res.status === 200) {
        props.setActivities(current => [activity,...current]);
      } else {

        console.log(res)
      }
    } catch (err) {
      console.log(err);
    }
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