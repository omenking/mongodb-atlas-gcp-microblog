import './HomeFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';

export default function HomeFeedPage() {
  const activities = [
    {uuid: '95203', handle: 'andrewbrown', posted_at: '2050-11-20 18:32:47 +0000', message: "This is my post"},
    {uuid: '57393', handle: 'andrewbrown', posted_at: '2050-10-20 09:22:47 +0000', message: "Lets get this posting started"},
    {uuid: '16984', handle: 'andrewbrown', posted_at: '2050-09-20 14:32:47 +0000', message: "Lets make some more posts"},
    {uuid: '52342', handle: 'andrewbrown', posted_at: '2050-09-10 18:32:47 +0000', message: "Posts are great"},
    {uuid: '32424', handle: 'andrewbrown', posted_at: '2050-09-08 18:32:47 +0000', message: "How is it going?"}
  ];

  return (
    <ActivityFeed activities={activities} />
  );
}