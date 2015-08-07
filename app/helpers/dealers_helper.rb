module DealersHelper
  def hidden_icon(hidden)
    if hidden
      "<span class='icon-visibility_off'></span>".html_safe
    end
  end
end
