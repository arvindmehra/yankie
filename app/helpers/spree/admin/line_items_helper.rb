module Spree
  module Admin
    module LineItemsHelper
      def possible_change_state_buttons(line_item)
        if can? :change_state, line_item
          [
            link_to_refund(line_item),
            link_to_approve(line_item),
            link_to_complete(line_item)
          ].compact.join.html_safe
        end
      end

      def link_to_complete(line_item)
        if line_item.state_events.include?(:complete)
          link_to_with_icon('folder-close', Spree.t('complete'), change_state_admin_line_item_path(line_item, event: 'complete'), method: :put, class: 'btn btn-primary btn-sm', title: Spree.t('complete'), no_text: true)
        end
      end

      def link_to_approve(line_item)
        if line_item.state_events.include?(:approve)
          link_to_with_icon('approve', Spree.t('approve'), change_state_admin_line_item_path(line_item, event: 'approve'), method: :put, class: 'btn btn-success btn-sm', title: Spree.t('approve'), no_text: true)
        end
      end

      def link_to_refund(line_item)
        if line_item.state_events.include?(:reject)
          link_to_with_icon('refund', Spree.t('refund'), change_state_admin_line_item_path(line_item, event: 'reject'), method: :put, class: 'btn btn-danger btn-sm', title: Spree.t('refund'), no_text: true)
        end
      end
    end
  end
end

# line_item.state_events.map do |line_item_event|
