require 'test_helper'

class FlashHelperTest < ActionView::TestCase
  include ApplicationHelper

  test 'should render notice flash message' do
    flash[:notice] = 'This is a notice message.'
    rendered = render_flash_message(:notice)

    assert_match 'This is a notice message.', rendered
    assert_match 'bg-green-300', rendered
    assert_match 'border-green-400', rendered
    assert_match 'data-flash-type="notice"', rendered
  end

  test 'should render alert flash message' do
    flash[:alert] = 'This is an alert message.'
    rendered = render_flash_message(:alert)

    assert_match 'This is an alert message.', rendered
    assert_match 'bg-red-300', rendered
    assert_match 'border-red-400', rendered
    assert_match 'data-flash-type="alert"', rendered
  end

  test 'should not render flash message if none exists' do
    rendered = render_flash_message(:notice)
    assert_empty rendered

    rendered = render_flash_message(:alert)
    assert_empty rendered
  end

  private

  def render_flash_message(type)
    flash_message = flash[type]
    return '' unless flash_message

    render partial: 'application/flash', locals: { flash_type: type, message: flash_message }
  end
end
