import './UserFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';
import { useParams } from 'react-router-dom';

export default function UserFeedPage() {
  const get_title = (value) => {
    const params = useParams();
    return `@${params.handle}`
  };

  const activities = [
    {uuid: '95203', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "This is my post"},
    {uuid: '57393', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "Lets get this posting started"},
    {uuid: '16984', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "Lets make some more posts"},
    {uuid: '52342', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "Posts are great"},
    {uuid: '32424', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "How is it going?"}
  ];

  return (
    <article>
      <ActivityFeed title={get_title()} activities={activities} />
    </article>
  );
}