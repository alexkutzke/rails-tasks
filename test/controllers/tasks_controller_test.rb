require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @task = tasks(:one)
    sign_in users(:one)
  end

  teardown do
    sign_out users(:one)
  end

  test "should get new" do
    get new_list_task_url(lists(:one))
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post list_tasks_url(@task.list), params: { task: { done: @task.done, list_id: @task.list_id, title: @task.title } }
    end

    assert_redirected_to lists_url
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete list_task_url(@task.list,@task)
    end

    assert_redirected_to lists_url
  end
end
