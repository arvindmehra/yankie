Deface::Override.new(
  virtual_path: "spree/layouts/admin",
  insert_bottom: "[data-hook='admin_tabs']",
  name: "add_subscribe_requests_to_navigation",
  text: "<%= render 'spree/admin/subscribe_requests/main_menu_item' %>"
)
