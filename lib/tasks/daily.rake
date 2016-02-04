namespace :daily do
  desc "Daily Notification"
  task :notify => :environment do
    User.all.each do |user|
      Daily.notify(user).deliver
    end
  end
end
