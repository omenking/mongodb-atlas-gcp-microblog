import './ActivityItem.css';

export default function ActivityItem(props) {
  return (
    <div class='activity_item'>
      <div class='heading'>
        <div class="handle">{props.handle}</div>
        <div class="posted_at">{props.posted_at}</div>
      </div>
      <div class="message">{props.message}</div>
    </div>
  );
}