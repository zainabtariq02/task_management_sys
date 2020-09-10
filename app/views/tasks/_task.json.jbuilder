json.extract! task, :id, :title, :details, :assignee_user_id, :reviewer_user_id, :created_by_user_id, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
