# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "The Parent"
  user.email                 "parent@home.no"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "parent#{n}@home.no"
end

Factory.define :staff, :class => User  do |staff|
  staff.name                  "The Staff"
  staff.email                 "staff@home.no"
  staff.password              "foobar"
  staff.password_confirmation "foobar"
  staff.staff                 true
end

Factory.define :department do |department|
  department.name                  "The Department"
  department.img_uri               "http://some.where/img.jpg"
end

# By using the symbol ':child', we get Factory Girl to simulate the Child model.
Factory.define :child do |child|
  child.name                  "The Child"
  child.department_id         "1"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :child
end
