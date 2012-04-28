# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#COMPANIES
#default company of creators and admins
puts "Creation of Foobar company"
default_company = Company.create! :name => "FooBar"
puts "Company Foobar created"

puts "Creation of WannaWin company"
wannawin = Company.create! :name => "WannaWin"
puts "Company WannaWin created"

#USERS
#default admin
puts "Creation of Admin user"
admin = User.create! :email => "admin@admin.com",
                     :password => "admin11",
                     :password_confirmation => "admin11",
                     :confirmed_at => DateTime.now,
                     :role => User::ROLES[:admin],
                     :company_id => default_company
#default creator user
puts "Creation of Creator user"
creator = User.create! :email => "creator@creator.com",
                       :password => "creator11",
                       :password_confirmation => "creator11",
                       :confirmed_at => DateTime.now,
                       :role => User::ROLES[:creator],
                       :company_id => default_company
creator.update_attribute :parent, admin
puts "Created Creator user: " << creator.email

#default competitor user
puts "Creation of Competitor user"
competitor = User.create! :email => "comp@comp.com",
                          :password => "comp11",
                          :password_confirmation => "comp11",
                          :confirmed_at => DateTime.now,
                          :role => User::ROLES[:competitor],
                          :company_id => wannawin
competitor.update_attribute :parent, admin
puts "Created Competitor user: " << competitor.email

#default creator_viewer user
puts "Creation of Creator_viewer user"
creator_viewer = User.create! :email => "viewercr@viewercr.com",
                              :password => "viewercr11",
                              :password_confirmation => "viewercr11",
                              :confirmed_at => DateTime.now,
                              :role => User::ROLES[:creator_viewer],
                              :company_id => default_company
creator_viewer.update_attribute :parent, admin
puts "Created Creator_viewer user: " << creator_viewer.email

#default competitor_viewer user
puts "Creation of Competitor_viewer user"
competitor_viewer = User.create! :email => "viewercomp@viewercomp.com",
                                 :password => "viewercomp11",
                                 :password_confirmation => "viewercomp11",
                                 :confirmed_at => DateTime.now,
                                 :role => User::ROLES[:competitor_viewer],
                                                      :company_id => wannawin
competitor_viewer.update_attribute :parent, admin
puts "Created Competitor_viewer user: " << competitor_viewer.email
