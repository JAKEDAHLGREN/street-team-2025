require 'test_helper'

class CheckboxControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @assignment = assignments(:one)
  end

  test 'should update wave attribute when checkbox is toggled' do
    # Simulate the checkbox toggle action
    patch assignment_path(@assignment),
          params: { assignment: { wave_two: true } },
          headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

    # Check that the response is a Turbo Stream (status 200)
    assert_response :success
    assert_equal 'text/vnd.turbo-stream.html', response.media_type

    # Reload the assignment to confirm the change in the database
    @assignment.reload
    assert_equal true, @assignment.wave_two

    # Verify the Turbo Stream contains the expected replacement for the assignments table
    assert_includes response.body, '<turbo-stream action="replace" target="assignments_table">'
  end
end
