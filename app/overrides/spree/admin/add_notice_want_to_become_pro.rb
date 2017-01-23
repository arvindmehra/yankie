Deface::Override.new(
  virtual_path: "spree/admin/shared/_header",
  insert_bottom: "nav .row",
  name: "add_notice_want_to_become_pro",
  text: "<%= render 'spree/admin/subscribe_requests/notice' %>"
)
