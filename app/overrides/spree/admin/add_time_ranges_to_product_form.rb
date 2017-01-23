Deface::Override.new(
  virtual_path: "spree/admin/products/_form",
  insert_after: "[data-hook='admin_product_form_meta']",
  name: "add_time_ranges_to_admin_product_form",
  text: "<%= render 'time_ranges', f: f %>"
)
