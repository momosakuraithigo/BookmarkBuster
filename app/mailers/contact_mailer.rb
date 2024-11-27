class ContactMailer < ApplicationMailer
    default from: 'from@example.com'  # デフォルトの送信元アドレス
  
    def contact_email(contact)
      @contact = contact
      mail(
        to: 'admin@example.com',  # 管理者のメールアドレス
        subject: "【BookmarkBuster】お問い合わせがありました"
      )
    end
  end