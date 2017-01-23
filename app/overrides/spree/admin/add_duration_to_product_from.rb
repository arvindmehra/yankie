Deface::Override.new(
  virtual_path: "spree/admin/products/_form",
  insert_before: "[data-hook='admin_product_form_meta']",
  name: "add_duration_to_product_form",
  text: "<%= f.label :duration, Spree.t(:duration) %>" \
        "<%= f.time_select :duration, {}, class: 'select2' %>"
)
