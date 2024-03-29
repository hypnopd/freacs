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

puts "Creation of WannaWin2 company"
wannawin2 = Company.create! :name => "WannaWin2"
puts "Company WannaWin2 created"

#USERS
#default admin
puts "Creation of Admin user"
admin = User.create! :email => "admin@admin.com",
                     :password => "admin11",
                     :password_confirmation => "admin11",
                     :confirmed_at => DateTime.now,
                     :role => User::ROLES[:admin],
                     :company_id => default_company.id,
                     :parent => self
admin.update_attribute :parent, admin
puts "Created Admin user: " << admin.email

#default creator user
puts "Creation of Creator user"
creator = User.create! :email => "cret@cret.com",
                       :password => "cret11",
                       :password_confirmation => "cret11",
                       :confirmed_at => DateTime.now,
                       :role => User::ROLES[:creator],
                       :company_id => default_company.id
creator.update_attribute :parent, admin
puts "Created Creator user: " << creator.email

#default competitor user
puts "Creation of Competitor user"
competitor = User.create! :email => "comp@comp.com",
                          :password => "comp11",
                          :password_confirmation => "comp11",
                          :confirmed_at => DateTime.now,
                          :role => User::ROLES[:competitor],
                          :company_id => wannawin.id
competitor.update_attribute :parent, creator
puts "Created Competitor user: " << competitor.email

#default competitor user
puts "Creation of Competitor user"
competitor = User.create! :email => "comp2@comp2.com",
                          :password => "comp22",
                          :password_confirmation => "comp22",
                          :confirmed_at => DateTime.now,
                          :role => User::ROLES[:competitor],
                          :company_id => wannawin2.id
competitor.update_attribute :parent, creator
puts "Created Competitor user: " << competitor.email

#default creator_viewer user
puts "Creation of Creator_viewer user"
creator_viewer = User.create! :email => "vcrt@vcrt.com",
                              :password => "vcrt11",
                              :password_confirmation => "vcrt11",
                              :confirmed_at => DateTime.now,
                              :role => User::ROLES[:creator_viewer],
                              :company_id => default_company.id
creator_viewer.update_attribute :parent, creator
puts "Created Creator_viewer user: " << creator_viewer.email

#default competitor_viewer user
puts "Creation of Competitor_viewer user"
competitor_viewer = User.create! :email => "vcomp@vcomp.com",
                                 :password => "vcomp11",
                                 :password_confirmation => "vcomp11",
                                 :confirmed_at => DateTime.now,
                                 :role => User::ROLES[:competitor_viewer],
                                 :company_id => wannawin.id
competitor_viewer.update_attribute :parent, competitor
puts "Created Competitor_viewer user: " << competitor_viewer.email

#create default auction
puts Auction.create!(:name => "test", :phase => Auction::PHASES[:init]) ? "'Test' auction created!" : "Smth went wrong when created 'Test' auction"