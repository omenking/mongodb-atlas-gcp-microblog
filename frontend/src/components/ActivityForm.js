import './ActivityForm.css';
import React from "react";

export default function ActivityForm() {
  const [count, setCount] = React.useState(0);

  return (
    <form className='activity_form'>
      <textarea
        placeholder="what would you like to say?"
        onChange={e => setCount(e.target.value.length)}
      />
      <div class='submit'>
        <div className='count'>{240-count}</div>
        <button type='submit'>Submit</button>
      </div>
    </form>
  );
}