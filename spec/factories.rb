# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "The Parent"
  user.email                 "parent@home.no"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
