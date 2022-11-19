import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";

function App() {
  return (
    <Router>
       <Switch>
          <Route path="/"><HomeFeedPage /></Route>
          <Route path="/@:handle"><UserFeedPage /></Route>
        </Switch>
    </Router>
  );
}

export default App;
