# YAAF-demo

This is a Rails application using the [https://github.com/rootstrap/yaaf](https://github.com/rootstrap/yaaf) gem to create form objects.

## Registration Form

#### Description

It creates an user after submitting the registration form and adds a default role to the user.

#### It uses

- Devise to handle user authentication (the form is used as the resource)
- Rolify to manage user roles.

[See the form](app/forms/registration_form.rb)
