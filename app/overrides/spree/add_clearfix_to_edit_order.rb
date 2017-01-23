Deface::Override.new(
  virtual_path: "spree/orders/edit",
  insert_after: "[data-hook='cart_container']",
  name: "add_clearfix_to_edit_order",
  text: "<div class='clearfix'></div>"
)

Deface::Override.new(
  virtual_path: "spree/orders/edit",
  add_to_attributes: "[data-hook='cart_container']",
  name: "add_clearfixd_to_edit_order",
  attributes: { class: 'main wrap-padding' }
)
