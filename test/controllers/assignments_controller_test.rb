require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @assignment = assignments(:one)
  end

  test 'should get index' do
    get assignments_path
    assert_response :success
    assert_select 'turbo-frame#assignments_table' do
      assert_select 'table#myTable'
    end
  end

  test 'should get new' do
    get new_assignment_path
    assert_response :success
    assert_select 'form' # Check for a form element
  end

  test 'should create assignment' do
    assert_difference('Assignment.count', 1) do
      post assignments_path,
           params: { assignment: { user_id: @user.id, area: 'Downtown', business_name: 'Moons Cafe',
                                   wave_one: true, wave_two: true, wave_three: false, other: false, notes: 'Testing' } }
    end
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment was successfully created.', response.body
  end

  test 'should not create assignment with invalid data' do
    assert_no_difference('Assignment.count') do
      post assignments_path,
           params: { assignment: { user_id: nil, area: '', business_name: '', wave_one: nil } }
    end
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should get edit' do
    get edit_assignment_path(@assignment)
    assert_response :success
    assert_select 'form' # Check for a form element
  end

  test 'should update wave_two attribute with Turbo Stream' do
    assignment = assignments(:one) # Ensure this fixture is valid and exists

    # Simulate a PATCH request with Turbo Stream format
    patch assignment_path(assignment),
          params: { assignment: { wave_two: true } },
          headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

    # Check that the response is a Turbo Stream (status 200)
    assert_response :success
    assert_equal 'text/vnd.turbo-stream.html', response.media_type

    # Reload the assignment to confirm the change in the database
    assignment.reload
    assert_equal true, assignment.wave_two

    # Verify the Turbo Stream contains the expected replacement for the assignments table
    assert_includes response.body, '<turbo-stream action="replace" target="assignments_table">'
  end

  test 'should not update assignment with invalid data' do
    patch assignment_path(@assignment), params: { assignment: { area: '' } }
    assert_response :unprocessable_entity
    assert_template :edit
    assert_not_equal '', @assignment.reload.area
  end

  test 'should destroy assignment' do
    assert_difference('Assignment.count', -1) do
      delete assignment_path(@assignment)
    end
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment was deleted successfully.', response.body
  end

  test 'should update wave attributes with Turbo Stream' do
    patch update_wave_assignment_path(@assignment, format: :turbo_stream),
          params: { assignment: { wave_one: true, wave_two: false } }
    assert_response :success
    assert_match 'turbo-stream', response.content_type
    assert_equal true, @assignment.reload.wave_one
    assert_equal false, @assignment.reload.wave_two
  end

  test 'should handle non-existent assignment gracefully' do
    non_existent_id = -1
    get assignment_path(non_existent_id)
    assert_redirected_to assignments_path
    follow_redirect!
    assert_match 'Assignment not found', response.body
  end

  test 'should handle unauthorized access' do
    sign_out @user
    get assignments_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match 'You need to sign in or sign up before continuing.', response.body
  end
end
