Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_yield_foot_html",
                     :replace_contents => "[data-hook='admin_footer_scripts']",
                     :text => "<%= yield :foot %>"
                    )