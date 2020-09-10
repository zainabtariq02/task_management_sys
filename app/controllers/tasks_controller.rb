class TasksController < ApplicationController
  load_and_authorize_resource
  
  # GET /tasks
  # GET /tasks.json
  def index
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new 
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task.created_by_user_id = current_user.id
    @task.assignee_user_id   = current_user.id unless current_user.admin
   
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
       
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      
      else
        format.html { render :edit }
    
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  
  def destroy
    @task.destroy
    respond_to do |format|
      if @task.destroyed?
        format.html { redirect_to tasks_path, notice: 'Task was successfully destroyed.' }
      else
        format.html { redirect_to tasks_path, notice: 'Task could not be destroyed!' }
      end
    end  
  end
  
  def in_progress
    if @task.can_transition? :in_progress
      @task.in_progress!
    
      redirect_to tasks_path, notice: 'Task status has been updated.'
    else
      redirect_to tasks_path, notice: 'Task status could not be updated!'
    end   
  end

  def complete
    if @task.can_transition? :complete
      @task.complete!

      redirect_to tasks_path, notice: 'Task status has been updated'
    else
      redirect_to tasks_path, notice: 'Task is already complete'
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :details, :assignee_user_id, :reviewer_user_id, :created_by_user_id)
    end
    
end
