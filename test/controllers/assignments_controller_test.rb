require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @assignment = assignments(:one) # Assuming you have a fixture for assignments
  end

  test 'should get index' do
    get assignments_path
    assert_response :success
  end

  test 'should get new' do
    get new_assignment_path
    assert_response :success
  end

  test 'should create assignment' do
    assert_difference('Assignment.count') do
      post assignments_path,
           params: { assignment: { user_id: @user.id, area: 'Downtown', business_name: 'Cafe', wave_one: true,
                                   notes: 'Test assignment' } }
    end
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment was successfully created.', response.body
  end

  test 'should get edit' do
    get edit_assignment_path(@assignment)
    assert_response :success
  end

  test 'should update assignment' do
    patch assignment_path(@assignment), params: { assignment: { area: 'Uptown', notes: 'Updated notes' } }
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment was successfully updated.', response.body
  end

  test 'should destroy assignment' do
    assert_difference('Assignment.count', -1) do
      delete assignment_path(@assignment)
    end
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment was deleted successfully.', response.body
  end

  test 'should show assignment' do
    get assignment_path(@assignment)
    assert_response :success
  end
end
