namespace :db do
  desc "Fill database with default user"
  task populate: :environment do
    @user = User.new(name: "Administrator",
                 email: "admin@admin.com",
                 username: "admin",
                 password: "admin",
                 password_confirmation: "admin")
    @user.save
  end
end
