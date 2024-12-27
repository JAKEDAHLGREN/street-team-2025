module ApplicationHelper
  def render_flash
    flash.map do |key, msg|
      render partial: 'application/flash', locals: { flash_type: key, message: msg }
    end.join.html_safe
  end
end
