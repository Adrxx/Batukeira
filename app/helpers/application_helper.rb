module ApplicationHelper

  def echo_spacers(number)
    result = ''
    number.times { result+='<div class="spacer"></div>' }
    result.html_safe
  end
  
end
