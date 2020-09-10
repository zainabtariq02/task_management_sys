class User < ApplicationRecord
  validates :name, presence: true
  attr_accessor :skip_password_validation

  has_many :tasks_as_assignee, class_name: 'Task', foreign_key: 'assignee_user_id'
  has_many :tasks_as_reviewer, class_name: 'Task', foreign_key: 'reviewer_user_id'
  has_many :tasks_created, class_name: 'Task', foreign_key: 'created_by_user_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable

  before_destroy :can_destroy?, prepend: true
 
  def password_required?
    return false if skip_password_validation

    super
  end

  private

  def can_destroy?
    unless tasks_as_assignee.empty? && tasks_as_reviewer.empty? && tasks_created.empty?
      errors.add(:base, "Can't be destroyed")
      throw :abort
    end
  end
end
