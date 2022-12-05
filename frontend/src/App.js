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
    loader: async ({ request, params }) => {
      return fetch(
        `/fake/api/teams/${params.teamId}.json`,
        { signal: request.signal }
      );
    },

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
