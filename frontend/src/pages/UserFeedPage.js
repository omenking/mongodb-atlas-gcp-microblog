import './UserFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';
import { useParams } from 'react-router-dom';

export default function UserFeedPage(props) {
  const params = useParams();
  const title = `@${params.handle}`;

  return (
    <article>
      <ActivityFeed title={title} activities={props.activities} />
    </article>
  );
}