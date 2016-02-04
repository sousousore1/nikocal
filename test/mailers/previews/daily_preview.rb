# Preview all emails at http://localhost:3000/rails/mailers/daily
class DailyPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/daily/notify
  def notify
    Daily.notify
  end

end
