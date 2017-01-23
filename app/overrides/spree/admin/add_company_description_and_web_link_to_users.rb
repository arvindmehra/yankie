Deface::Override.new(
  virtual_path: "spree/admin/users/_form",
  insert_bottom: "[data-hook='admin_user_form_password_fields']",
  name: "add_company_description_and_web_link_to_users",
  text: "<%= render 'extra_field', f: f %>"
)
