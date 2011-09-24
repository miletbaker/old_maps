class GoAdminTabsBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    class_attr = item_options[:class].present? ? 'tab ' + item_options[:class] : 'tab';
    unless item_options[:right].nil?
      class_attr << " right" and item_options if item_options[:right] == true
      item_options.delete(:right)
    end
    unless item_options[:background].nil?
      class_attr << " none" if item_options[:background] == false
      item_options.delete(:background)
    end
    class_attr << " selected" if current_tab?(tab)
    item_options[:class] = class_attr
    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end
end