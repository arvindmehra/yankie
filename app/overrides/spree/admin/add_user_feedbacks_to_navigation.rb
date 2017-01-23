Deface::Override.new(
  virtual_path: "spree/layouts/admin",
  insert_bottom: "[data-hook='admin_tabs']",
  name: "add_user_feedbacks_to_navigation",
  text: "<%= render 'spree/admin/user_feedbacks/main_menu_item' %>"
)
