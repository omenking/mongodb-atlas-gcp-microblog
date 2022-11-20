import './ActivityFeed.css';
import ActivityItem from './ActivityItem';

export default function ActivityFeed(props) {
  return (
    <div class='activity_feed'>
      {props.activities.map(activity => {
       return  <ActivityItem />
      })}
    </div>
  );
}