import './HomeFeedPage.css';
import '../components/ActvityFeed'
import ActivityFeed from '../components/ActivityFeed';

export default function HomeFeedPage() {
  const activities = [
    {id: 1, name: 'Alice', country: 'Austria'},
    {id: 2, name: 'Bob', country: 'Belgium'},
    {id: 3, name: 'Carl', country: 'Canada'},
    {id: 4, name: 'Dean', country: 'Denmark'},
    {id: 5, name: 'Ethan', country: 'Egypt'},
  ];


  return (
    <ActivityFeed activities={activities} />
  );
}