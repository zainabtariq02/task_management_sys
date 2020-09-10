class TaskMailer < ApplicationMailer
  default from: 'testu5184@example.com'

  def task_status_email(user_id, task)
    @user   = User.find(user_id)
    @task   = task
    subject = "Task no. #{@task.id} status changed to #{@task.state}"
    mail(to: @user.email, subject: subject)
  end

end
