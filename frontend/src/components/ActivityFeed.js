import './ActivityFeed.css';
import ActivityItem from './ActivityItem';

export default function ActivityFeed(props) {
  return (
    <div className='activity_feed'>
      {props.activities.map(activity => {
       return  <ActivityItem key={activity.uuid} activity={activity} />
      })}
    </div>
  );
}