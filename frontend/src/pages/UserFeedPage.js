import './UserFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';
import { useParams } from 'react-router-dom';
import React from "react";

export default function UserFeedPage() {
  const [activities, setActivities] = React.useState([]);

  const params = useParams();
  const title = `@${params.handle}`;

  const loadData = async () => {
    try {
      const backend_url = `${process.env.REACT_APP_BACKEND_URL}/api/activities/${title}`
      const res = await fetch(backend_url, {
        method: "GET"
      });
      let resJson = await res.json();
      if (res.status === 200) {
        setActivities(resJson)
      } else {
        console.log(res)
      }
    } catch (err) {
      console.log(err);
    }
  };

  React.useEffect(()=>{
    loadData();
  }, [])

  return (
    <article>
      <ActivityFeed title={title} activities={activities} />
    </article>
  );
}