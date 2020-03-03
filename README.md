# Rails TechTest

Application is deployed to  [Heroku](https://frozen-brook-81725.herokuapp.com).

## Installation

Follow these easy steps to install and start the app:

### Set up Rails app

### Clone the repository

```
git clone git@github.com:rashidsp/tech_demo.git
cd tech_demo
```

First, install the gems required by the application:

    bundle install

### Initialize Phrase

Export environment variables `client_id` and `client_secret`;  Provided in Tech test document.

```
export CLIENT_ID=<YOUR_CLIENT_ID> CLIENT_SECRET=<YOUR_CLIENT_ID>
```
Or create `.env` file and add variables using aforementioned keys.


### Start the app

You're ready to localize your app:

    rails server

You can find your app now by pointing your browser to [http://localhost:3000](http://localhost:3000). If everything worked you can go to landing page and click `Connect` button to Login/Signup.

## Deploy your application to Heroku

### With Heroku CLI:

Make sure you are in the directory that contains your Rails app, then create an app on Heroku:

```
heroku create
```

Deploy your code by pushing to Heroku master remote:

```
git push heroku master
```


### Configure Environment variables

```
heroku config:set CLIENT_ID=<YOUR_CLIENT_ID> CLIENT_SECRET=<YOUR_CLIENT_ID>
```

We can now visit the app in our browser with `heroku open`
