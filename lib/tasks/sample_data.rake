require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    Department.create!(:name => "Ludvig",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Cast_Lambert_big.jpg",
      :description=>"small barn")
    Department.create!(:name => "Reodor",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Characters_Theodore.jpg",
      :description=>"3-6 years")
    Department.create!(:name => "Solan",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Figurer_SolanStor.jpg",
      :description=>"3-6 years")

    User.create!(:name => "The Parent",
      :email => "theparent@home.no",
      :password => "theparent",
      :password_confirmation => "theparent")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@home.no"
      password  = "password"
      User.create!(:name => name,
        :email => email,
        :password => password,
        :password_confirmation => password)
    end
  end
end

