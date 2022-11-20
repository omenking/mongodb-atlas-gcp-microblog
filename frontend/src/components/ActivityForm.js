import './ActivityForm.css';
import React from "react";

export default function ActivityForm() {
  const [count, setCount] = React.useState(0);

  const classes = []
  classes.push('count')
  if (240-count < 0){
    classes.push('err')
  }

  return (
    <form className='activity_form'>
      <textarea
        placeholder="what would you like to say?"
        onChange={e => setCount(e.target.value.length)}
      />
      <div className='submit'>
        <div className={classes.join(' ')}>{240-count}</div>
        <button type='submit'>Submit</button>
      </div>
    </form>
  );
}