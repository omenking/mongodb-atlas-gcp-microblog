import './HomeFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';
import ActivityForm from '../components/ActivityForm';
import React from "react";

export default function HomeFeedPage() {
  const [activities, setActivities] = React.useState([]);

  //setActivities([
  //  {uuid: '95203', handle: 'andrewbrown', created_at: '2022-11-20T20:41:18+00:00', message: "This is my post"},
  //  {uuid: '57393', handle: 'themachine', created_at: '2022-11-20T09:41:18+00:00', message: "Lets get this posting started"},
  //  {uuid: '16984', handle: 'federator', created_at: '2022-11-13T20:41:18+00:00', message: "Lets make some more posts"},
  //  {uuid: '52342', handle: 'jojo1212', created_at: '2022-11-10T20:41:18+00:00', message: "Posts are great"},
  //  {uuid: '32424', handle: 'sallycakes', created_at: '2022-08-02T20:41:18+00:00', message: "How is it going?"}
  //]);

  return (
    <article>
      <ActivityForm />
      <ActivityFeed title="Home" activities={activities} />
    </article>
  );
}