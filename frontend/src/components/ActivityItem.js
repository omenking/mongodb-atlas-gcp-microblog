import './ActivityItem.css';

export default function ActivityItem(props) {
  return (
    <div className='activity_item'>
      <div className='heading'>
        <div className="handle">{props.handle}</div>
        <div className="posted_at">{props.posted_at}</div>
      </div>
      <div className="message">{props.message}</div>
    </div>
  );
}