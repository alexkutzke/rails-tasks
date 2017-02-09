class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]
  before_action :authenticate_user!
  load_and_authorize_resource :list
  load_and_authorize_resource :task, :through => :list

  # GET /tasks/new
  def new
    @task = Task.new
    @task.list = @list
    @task.user = current_user
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.list = @list
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to lists_url, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'Task was successfully destroyed.' }
    end
  end

  def done
    @task.done = @task.done ? false : true
    @task.save!

    respond_to do |format|
      format.html {redirect_to lists_url}
      format.js
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
      @list = List.find(params[:list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :done, :list_id)
    end
end
