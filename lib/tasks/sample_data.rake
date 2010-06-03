require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    # create dummy depts
    puts "Creating Ludvig"
    Department.create!(:name => "Ludvig",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Cast_Lambert_big.jpg",
      :description=>"small barn")
    
    puts "Creating Reodor"
    Department.create!(:name => "Reodor",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Characters_Theodore.jpg",
      :description=>"3-6 years")

    puts "Creating Solan"
    Department.create!(:name => "Solan",
      :img_uri=>"http://www.caprino.no/games/fgpgull/images/Figurer_SolanStor.jpg",
      :description=>"3-6 years")

    #create Admin, Staff, and Parent users
    puts "Creating Admin"
    user = User.create!(:name => "Admin",
      :email => "admin@home.no",
      :password => "adminpw",
      :password_confirmation => "adminpw")
    user.toggle!(:admin)
    user.toggle!(:staff)
    puts "Creating Staff"
    user = User.create!(:name => "Staff",
      :email => "staff@home.no",
      :password => "staffpw",
      :password_confirmation => "staffpw")
    user.toggle!(:staff)

    puts "Creating Child"
    child = Child.create!(:name => "Child",
      :department_id => 1)
    puts "Creating Parent"
    user = User.create!(:name => "Parent",
      :email => "parent@home.no",
      :password => "parentpw",
      :password_confirmation => "parentpw")

    # fill with dummy parents and children
    puts "Creating Sample Kids"
    99.times do |n|
      name  = Faker::Name.name
      email = "parent#{n+1}@home.no"
      password  = "password"
      User.create!(:name => name,
        :email => email,
        :password => password,
        :password_confirmation => password)
      name = Faker::Name.name
      department = 1 + rand(3)
      Child.create!(:name => name,
        :department_id => department)
    end

    #fill with sample updates
    puts "Creating sample updates for kids"
    Child.all(:limit => 6).each do |child|
      50.times do
        child.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end

  end
end

