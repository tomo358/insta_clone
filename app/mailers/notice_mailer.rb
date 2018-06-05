class NoticeMailer < ApplicationMailer
  def notice_mail(notice)
    @notice = notice

    mail to:@notice.user.email, subject:"お問い合わせの確認メール"
  end
end
