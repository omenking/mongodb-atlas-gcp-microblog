## Indexing

- You need to have populated data first before indexing
- Turning on Indexing for MongoDB Atlas
  - Click into Cluster -> Go to Search - Create Index -> Click through dont think lol

  ```
bundle exec ruby config/seed.rb
  ```

export MONGO_ATLAS_URL=
export MONGO_DATABASE=

gp env MONGO_ATLAS_URL=
gp env MONGO_DATABASE=

## DB and Network Access

- Security -> Project
  - Database Access > If you need to reset password
  - Network Access > Add IP Add Address > Access From Anywhere


export MONGO_ATLAS_URL="mongodb+srv://andrewbrown:qZQESwhCzFwUdILl@cruddur.jsj5hcw.mongodb.net/?retryWrites=true&w=majority"
export MONGO_DATABASE="cruddur"