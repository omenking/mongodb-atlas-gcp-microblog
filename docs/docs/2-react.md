# Creating a simgple React frontend

## Ensure your are in root folder
Make sure we are in our project folder
```sh
cd $THEIA_WORKSPACE_ROOT
```

## Update Gitignore
Update your .gitignore for node_modules and commit first
```
node_modules
```

## Generate new app
Generate new app out
```sh
cd $THEIA_WORKSPACE_ROOT/frontend
npx create-react-app frontend
```

> I don't like React, I'm using it due to its popularity LOL.

## Run sample app to ensure its working

```
cd frontened
npm start
```

> This frontend start on port `3000`

## Implementing a Router

> React Router docs show version 5 we are using 6 so we have do figure some things out

https://stackoverflow.com/questions/63124161/attempted-import-error-switch-is-not-exported-from-react-router-dom
https://stackoverflow.com/questions/69864165/error-privateroute-is-not-a-route-component-all-component-children-of-rou
https://reactrouter.com/en/main/start/tutorial

Things we need from a page level:
- HomeFeedPage
- UserFeedPage

We'll install and use [React Router](https://v5.reactrouter.com/web/guides/quick-start)

```
npm install --save react-router-dom
```

Proper HTML5 should have a main tag as our root element.

Update your `frontend/public/index.html` as follows:

Replace this:

```html
<div id="root"></div>
```

with this:

```html
<main></main>
```

We'll need to update `frontend/index.js` to mount on `<main>`


Change this:
```js
const root = ReactDOM.createRoot(document.getElementById('root'));
```

to this:

```js
const el_main = document.getElementsByTagName('main')[0];
const root = ReactDOM.createRoot(el_main);
```

- [] Check the app to make sure it still works

```
cd $THEIA_WORKSPACE_ROOT/frontend
mkdir src/pages
touch  src/pages/HomeFeedPage.js
touch  src/pages/HomeFeedPage.css
touch  src/pages/UserFeedPage.js
touch  src/pages/UserFeedPage.css
```

In the HomeFeedPage.js:

```js
import './HomeFeedPage.css';

export default function HomeFeedPage() {
  return (
    <div>Home Feed</div>
  );
}
```

In the UserFeedPage.js:
```js
import './UserFeedPage.css';

export default function UserFeedPage() {
  return (
    <div>User Feed</div>
  );
}
```

We need to update our App.js as follows:

```js
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
```

Test the routes:
```
gp preview $(gp url 3000)/ --external
gp preview $(gp url 3000)/@andrewbrown --external
```

## Create needed components

Things that we need from a component level:
- ActivityItem (think a tweet)
- ActivitFeed (a list of activity)
- ActivityForm (a form to write a activity)

```sh
cd $THEIA_WORKSPACE_ROOT/frontend
mkdir src/components
touch  src/components/ActivityFeed.js
touch  src/components/ActivityItem.js
touch  src/components/ActivityForm.js
touch  src/components/ActivityFeed.css
touch  src/components/ActivityItem.css
touch  src/components/ActivityForm.css
```

```sh
npm install --save luxon
```