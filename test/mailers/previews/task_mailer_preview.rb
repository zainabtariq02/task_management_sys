# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview
def task_mail_preview
    TaskMailer.task_status_email(User.first,Task.first)
  end

end
