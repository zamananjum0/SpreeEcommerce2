Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "debug_param_admin",
                     :insert_before => "[data-hook='admin_footer_scripts']",
                     :partial => "spree/admin/shared/debug")