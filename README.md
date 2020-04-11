# yaaf-demo

![CI](https://github.com/rootstrap/yaaf-examples/workflows/CI/badge.svg)

This is a Rails application using the [https://github.com/rootstrap/yaaf](https://github.com/rootstrap/yaaf) gem to create form objects.

## Devise & Simple Form - Registration Form

#### Description

It creates an user after submitting the registration form and adds a default role to the user.

#### It uses

- Devise to handle user authentication (the form is used as the resource)
- Rolify to manage user roles.

[See the form](app/forms/registration_form.rb)

## Nested forms - Bulk Invite Form

#### Description

It creates several invites after submitting the form.

[See the form](app/forms/bulk_invites_form.rb)

## Multiple models - Payment Form

#### Description

It creates a payment and updates several other models

[See the form](app/forms/payment_form.rb)
