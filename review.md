# Delete vs. Destroy

# HTTP Verbs vs. CRUD Names

| HTTP VERBS | CRUD (Rails Controller Action Names) |
| ---------- | ------------------------------------ |
| GET        | Read (Show, Index, New, Edit)        |
| POST       | Create (Create)                      |
| DELETE     | Delete (Destroy)                     |
| PATCH      | Update (Update)                      |
| PUT        | Update (Update)                      |

# Steps to Setup Authentication

1. Create a User model with a minimum of `email` and `password_digest` columns.
2. Add `has_secure_password` to the User model.
3. Create a `UsersController` to support creating users. This is for the Sign Up
   page.
4. Create a `SessionController` to support the Sign In page and the Sign Out.
5. When a user Signs Up or Signs In, set their `user_id` in the `session` hash
   in `users#create` and `session#create`.
6. In the `ApplicationController`, implement the `current_user` to get the user
   from the `user_id` in the `session`.
7. In the `ApplicationController`, implement the `authenticate_user!` method.
   This method is used with `before_action` in our controllers to prevent users
   that are not signed from accessing certain routes. For example:
   `before_action :authenticate_user!, only: [:create]`
8. Use `before_action :authenticate_user!` where appropriate or where you need
   restrict user access to your actions.
