module TasksHelper
  def get_status_label(task)
    if task.open?
      'Start Task'
    elsif task.in_progress?
      'Complete Task'
    else
      'Completed' 
    end
  end

  def get_action_path(task)
    if task.open?
      in_progress_task_path
    else
      complete_task_path 
    end
  end
end
