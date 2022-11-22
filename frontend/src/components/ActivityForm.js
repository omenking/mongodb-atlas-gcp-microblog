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

  const onsubmit = (event) => {
    console.log('submitting', message);
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