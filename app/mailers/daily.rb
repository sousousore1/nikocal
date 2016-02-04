class Daily < ApplicationMailer
  default from: '"ニコニコカレンダー" <niko.niko.calender@gmail.com>'
  def notify
    mail  to: "s.saito@gloops.com", subject: "本日のスタンプを入力しよう"
  end

  # def notify user
  #   mail to: user.email, subject: "本日のスタンプを入力しよう"
  # end
end
