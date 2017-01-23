Spree::OrderContents.class_eval do
  # if we pass raise_error == false, then we'd like to add a product to the line item
  # As we wanna store each service per a line item we must return nil
  def grab_line_item_by_variant(variant, raise_error = false, options = {})
    line_item = order.find_line_item_by_variant(variant, options)

    if !line_item.present? && raise_error
      raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
    end

    # line_item
    # Customize
    raise_error ? line_item : nil
  end
end
