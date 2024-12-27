require "test_helper"

class Admin::AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_assignments_index_url
    assert_response :success
  end
end
