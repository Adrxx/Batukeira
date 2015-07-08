module ApplicationHelper

  def echo_spacers(number)
    result = ''
    number.times { result+='<div class="mnt-pm-spacer"></div>' }
    result.html_safe
  end

  def color_palette()
    '<div class="palette">
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
    <div class="p-color"></div>
  </div>'.html_safe
  end

end
