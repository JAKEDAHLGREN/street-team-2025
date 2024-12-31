module ApplicationHelper
  def render_flash
    flash_messages = flash.map do |key, msg|
      render partial: 'application/flash', locals: { flash_type: key, message: msg }
    end.join.html_safe

    # Render Devise error messages if they exist
    error_messages = if @resource.errors.any?
                       render(partial: 'devise/shared/error_messages',
                              locals: { resource: @resource })
                     else
                       ''
                     end

    flash_messages + error_messages
  end
end
