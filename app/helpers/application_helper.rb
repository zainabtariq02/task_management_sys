module ApplicationHelper
  def get_user_role(user)
    if user.admin
      'Admin'
    else
      'Staff'
    end
  end
end


