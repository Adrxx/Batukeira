module ApplicationHelper

  def echo_spacers(number)
    result = ''
    number.times { result+='<div class="mnt-pm-spacer"></div>' }
    result.html_safe
  end

  def num_to_month(num)
    monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    monthNames[num-1]
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

  def error_if_exists(object,name)
    str = ''
    object.errors[name].each do |m|
      str += "<div class='error-message'>#{m}</div>"
    end
    str
  end

  def full_field(form,name,title,placeholder)
    str = ''
    str += form.label(name, title)
    str += form.text_field(name, class: 'u-full-width', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end

  def full_password_field(form,name,title,placeholder)
    str = ''
    str += form.label(name, title)
    str += form.password_field(name, class: 'u-full-width', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end

  def full_text_area(form,name,title,placeholder)
    str = ''
    str += form.label(name, title)
    str += form.text_area(name, class: 'u-full-width', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end

  def full_numeric_field(form,name,title,placeholder)
    str = ''
    str += form.label(name, title)
    str += form.text_field(name, class: 'u-full-width mnt-pm-numeric-input', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end

  def photo_if_exists(c)
    if c.photos.empty?
      image_url('delete_icon.png')
    else
      c.photos.first.photo_file.url(:thumb)
    end
  end

  def full_field_batukeira(form,name,placeholder)
    str = ''
    str += form.text_field(name, class: 'campo', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end

  def full_text_batukeira(form,name,placeholder)
    str = ''
    str += form.text_area(name, class: 'campo area', placeholder: placeholder)
    str += error_if_exists(form.object,name)
    str.html_safe
  end



end
