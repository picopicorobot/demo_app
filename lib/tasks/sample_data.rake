namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # admin = User.create!(name: "Example User",
    #              email: "example@railstutorial.jp",
    #              password: "foobar",
    #              password_confirmation: "foobar",
    #              admin: true)
    # User.create!(name: "Example1 User",
    #              email: "example1@railstutorial.jp",
    #              password: "foobar",
    #              password_confirmation: "foobar")
    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.jp"
    #   password  = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end

    users = User.limit(6).order("id desc")
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each do |user|
        user.microposts.create!(content: content)
      end
    end
  end
end
