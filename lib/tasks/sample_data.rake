require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    # create dummy depts
    Department.create!(:name => "Ludvig",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Cast_Lambert_big.jpg",
      :description=>"small barn")
    Department.create!(:name => "Reodor",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Characters_Theodore.jpg",
      :description=>"3-6 years")
    Department.create!(:name => "Solan",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Figurer_SolanStor.jpg",
      :description=>"3-6 years")

    #create Admin, Staff, and Parent users
    user = User.create!(:name => "Admin",
      :email => "admin@home.no",
      :password => "adminpw",
      :password_confirmation => "adminpw")
    user.toggle!(:admin)
    user.toggle!(:staff)
    user = User.create!(:name => "Staff",
      :email => "staff@home.no",
      :password => "staffpw",
      :password_confirmation => "staffpw")
    user.toggle!(:staff)

    child = Child.create!(:name => "Child",
      :department_id => 1)
    user = User.create!(:name => "Parent",
      :email => "parent@home.no",
      :password => "parentpw",
      :password_confirmation => "parentpw")

    # fill with dummy parents
    99.times do |n|
      name  = Faker::Name.name
      email = "parent#{n+1}@home.no"
      password  = "password"
      User.create!(:name => name,
        :email => email,
        :password => password,
        :password_confirmation => password)
    end
  end
end

