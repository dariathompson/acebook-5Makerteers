# AceBook

Project to build Facebook clone is deployed via Heroku: [click here](https://social-acebook.herokuapp.com/users/sign_in)

## Getting Started

Ensure you have the following setup on your machine:
- Bundle
- PostgreSQL

`git clone` this repository and `cd` into the directory.

Install dependencies:

```
$ bundle install
```

Create and migrate the database:

```
$ rails db:create
$ rails db:migrate
```

To run the project, start up the server:

```
$ rails server
```

Then navigate to `localhost:3000` in your browser