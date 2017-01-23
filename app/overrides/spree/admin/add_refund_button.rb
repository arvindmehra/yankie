Deface::Override.new(
  virtual_path: "spree/admin/orders/_line_items",
  replace_contents: "[data-hook='cart_line_item_delete']",
  name: "add_refund_button",
  text: "<%= possible_change_state_buttons(item) %>"
)
