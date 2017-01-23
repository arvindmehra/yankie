Deface::Override.new(
  virtual_path: "spree/admin/variants/_form",
  insert_after: "[data-hook='admin_variant_form_additional_fields']",
  name: "add_coords_to_admin_variant_form",
  text: "<%= render 'coords', f: f %>"
)
