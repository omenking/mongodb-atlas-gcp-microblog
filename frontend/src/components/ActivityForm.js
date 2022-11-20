import './ActivityForm.css';
import React from "react";

export default function ActivityForm() {
  const [count, setCount] = React.useState(0);

  const state = {value: ''};

  const classes = []
  classes.push('count')
  if (240-count < 0){
    classes.push('err')
  }

  const onsubmit = (event) => {
    console.log('submitting',state);
    event.preventDefault();
  }

  const textarea_onchange = (event) => {
    setCount(event.target.value.length)
    React.setState({value: event.target.value})
  }

  return (
    <form 
      className='activity_form'
      onSubmit={onsubmit}
    >
      <textarea
        value={state.value}
        placeholder="what would you like to say?"
        onChange={textarea_onchange} 
      />
      <div className='submit'>
        <div className={classes.join(' ')}>{240-count}</div>
        <button type='submit'>Submit</button>
      </div>
    </form>
  );
}