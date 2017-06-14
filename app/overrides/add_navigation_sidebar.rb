Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_navigation_sidebar",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<% if can? :admin, Spree::Admin::Navigation %>
                                <ul class='nav nav-sidebar'>
                                  <%= main_menu_tree Spree.t(:navigation), icon: 'tasks', sub_menu: 'navigation_sub', url: '#sidebar-navigations' %>
                                </ul>
                              <% end %>"
                    )