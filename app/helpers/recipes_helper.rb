module RecipesHelper
  def add_ingredient_button(name, association, target)
    content_tag(:span, "<a href=\"#\">#{name}</a>".html_safe,
      class: 'add_child',
      :"data-association" => association,
      target: target)
  end

  def remove_ingredient_button(name)
    content_tag(:span, "<a href=\"#\">Remove</a>".html_safe,
      class: 'remove_child')
  end

  def new_fields_template(f, association, options={})
    options[:object] ||= f.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s + '_fields'
    options[:template] ||= association.to_s + '_fields'
    options[:f] ||= :f

    tmpl = content_tag(:div, id: "#{options[:template]}") do
      tmpl = f.fields_for(association, options[:object], child_index: "new_#{association}") do |b|
        render(partial: options[:partial], locals: {f: b})
      end
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, ' '
    "<script> var #{options[:template]} = '#{tmpl.to_s}' </script>".html_safe
  end
end
