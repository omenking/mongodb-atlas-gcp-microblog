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


## Create needed components

Things that we need from a component level:
- ActivityItem (think a tweet)
- ActivitFeed (a list of activity)
- ActivityForm (a popup to write an activity)
- CreateActivityButton (a button that will open the popup to write an activity)
