import './App.css';
import HomeFeedPage from './pages/HomeFeedPage';
import UserFeedPage from './pages/UserFeedPage';
import {
  createBrowserRouter,
  RouterProvider
} from "react-router-dom";

const router = createBrowserRouter([
  {
    path: "/",
    element: <HomeFeedPage />
  },
  {
    path: "/@:handle",
    element: <UserFeedPage />
  }
]);

function App() {
  return (
    <RouterProvider router={router} />
  );
}

export default App;
