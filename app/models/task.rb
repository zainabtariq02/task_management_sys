class Task < ApplicationRecord
  include ActiveModel::Transitions
 
  validates :title, :details, presence: true

  belongs_to :assignee_user, class_name: 'User'
  belongs_to :reviewer_user, class_name: 'User'
  belongs_to :created_by_user, class_name: 'User'

  state_machine initial: :open do
    state :open
    state :in_progress
    state :complete

    event :in_progress, success: :send_status_emails do
      transitions to: :in_progress, from: [:open]
    end

    event :complete, success: :send_status_emails do
      transitions to: :complete, from: [:in_progress]
    end
  end

  def send_status_emails
    recipients = [assignee_user.id, reviewer_user.id, created_by_user.id].uniq
    recipients.each do |user_id|
      TaskMailer.delay.task_status_email(user_id, self)
    end
  end
end
