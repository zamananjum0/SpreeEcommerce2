module Spree::BaseHelper
  def breadcrumbs(taxon, separator="&nbsp;")
    # return "" if current_page?("/") || taxon.nil?
    separator = raw(separator)
    crumbs = [content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: "name"), spree.root_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")]
    if taxon
      crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: "name"), spree.products_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
      crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: "name"), seo_url(ancestor), itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement") } unless taxon.ancestors.empty?
      crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: "name") , seo_url(taxon), itemprop: "url"), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    else
      crumbs << content_tag(:li, content_tag(:span, Spree.t(:products), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    end
    crumb_list = content_tag(:ol, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class: 'breadcrumb crumb_navigation', itemscope: "itemscope", itemtype: "https://schema.org/BreadcrumbList")
    content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-md-12')
  end

  def is_homepage?
    current_page?("/")
  end

  def block_to_cart(text = nil)
    text = text ? h(text) : Spree.t('Shopping cart')
    item_count = 0
    total = 0;
    unless simple_current_order.nil? or simple_current_order.item_count.zero?
      item_count = simple_current_order.item_count
      total = simple_current_order.display_total.to_html
    end

    content = content_tag(:div, text, class: 'cart_title')
    content += content_tag(:div, class: 'cart_details') do
      content_tag(:span, pluralize(item_count, 'item') ) +
      content_tag(:span, "", class: 'border_cart') +
      content_tag(:span, "Total: #{total}", class: "price")
    end
    content += content_tag(:div, class: 'cart_icon') do
      link_to image_tag('shoppingcart.png'), spree.cart_path
    end
    content
  end
end