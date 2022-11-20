import './ActivityItem.css';
import { Link } from "react-router-dom";
import { DateTime } from 'luxon';

export default function ActivityItem(props) {

  const format_created_at = (value) => {
    // format: 2050-11-20 18:32:47 +0000
    const created = DateTime.fromISO(value)
    const now     = DateTime.now()
    const diff_mins = now.diff(created, 'minutes').toObject().minutes;
    const diff_hours = now.diff(created, 'hours').toObject().hours;

    if (diff_hours > 24.0){
      return created.toFormat("LLL L");
    } else if (diff_hours < 24.0 && diff_hours > 1.0) {
      return `${Math.floor(diff_hours)}h`;
    } else if (diff_hours < 1.0) {
      return `${Math.round(diff_mins)}m`;
    }
  };

  return (
    <div className='activity_item'>
      <div className='heading'>
        <Link className="handle" to={`/@`+props.activity.handle}>@{props.activity.handle}</Link>
        <div className="created_at">{format_created_at(props.activity.created_at)}</div>
      </div>
      <div className="message">{props.activity.message}</div>
    </div>
  );
}