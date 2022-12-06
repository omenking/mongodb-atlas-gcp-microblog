import './HomeFeedPage.css';
import ActivityFeed from '../components/ActivityFeed';
import ActivityForm from '../components/ActivityForm';
import React from "react";

export default function HomeFeedPage() {
  const [activities, setActivities] = React.useState([]);
  const loadData = async () => {
    try {
      const backend_url = `${process.env.REACT_APP_BACKEND_URL}/api/activities/home`
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
      <ActivityForm setActivities={setActivities} />
      <ActivityFeed title="Home" activities={activities} />
    </article>
  );
}