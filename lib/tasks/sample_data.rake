require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_admin
    make_staff
    make_parents
    make_depts
    make_children
    make_microposts
    make_relationships
  end
end

def make_depts
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
end

#create Admin, Staff, and Parent users
def make_admin
  puts "Creating Admin"
  user = User.create!(:name => "Admin",
    :email => "admin@home.no",
    :password => "adminpw",
    :password_confirmation => "adminpw")
  user.toggle!(:admin)
  user.toggle!(:staff)
end

def make_staff
  puts "Creating Staff"
  user = User.create!(:name => "Staff",
    :email => "staff@home.no",
    :password => "staffpw",
    :password_confirmation => "staffpw")
  user.toggle!(:staff)
end

def make_parents
  puts "Creating Parent"
  user = User.create!(:name => "Parent",
    :email => "parent@home.no",
    :password => "parentpw",
    :password_confirmation => "parentpw")

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

def make_children
  puts "Creating Child"
  child = Child.create!(:name => "Child",
    :department_id => 1)
  99.times do |n|
    name = Faker::Name.name
    department = 1 + rand(3)
    Child.create!(:name => name,
      :department_id => department)
  end
end





def make_microposts
  #fill with sample updates
  puts "Creating sample updates for kids"
  Child.all(:limit => 6).each do |child|
    50.times do
      child.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end

end

def make_relationships
  puts "making some relationships"
  mum = User.create!(:name => "Mother",
    :email => "mother@home.no",
    :password => "motherpw",
    :password_confirmation => "motherpw")
  dad = User.create!(:name => "Father",
    :email => "father@home.no",
    :password => "fatherpw",
    :password_confirmation => "fatherpw")
  parent = User.create!(:name => "Guardian",
    :email => "guardian@home.no",
    :password => "guardianpw",
    :password_confirmation => "guardianpw")
  kid1 = Child.create!(:name => "Offspring1",
    :department_id => 1)
  kid2 = Child.create!(:name => "Offspring2",
    :department_id => 3)
  kid3 = Child.create!(:name => "Offspring2",
    :department_id => 2)

  parent.follow!(kid3)
  mum.follow!(kid1)
  mum.follow!(kid2)
  dad.follow!(kid1)
  dad.follow!(kid2)


end