import './ActivityFeed.css';
import './Activityitem'
import ActivityItem from './ActivityItem';

export default function ActivityFeed(props) {
  return (
    <div class='activity_feed'>
      {props.activities.map(activity => {
        <ActivityItem />
      })}
    </div>
  );
}