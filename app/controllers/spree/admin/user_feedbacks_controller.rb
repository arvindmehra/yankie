module Spree
  module Admin
    class UserFeedbacksController < ResourceController
      before_action :load_user_feedback, only: [:change_state]

      helper_method :user_feedback_url

      def index
        @user_feedbacks = Spree::UserFeedback
                          .all
                          .page(params[:page])
                          .per(params[:per_page] || Spree::Config[:admin_products_per_page])
      end

      def change_state
        @user_feedback.send(params[:new_state]) if @user_feedback.state_events.include?(params[:new_state].to_s.to_sym)
        redirect_to admin_user_feedbacks_path
      end

      private

      def load_user_feedback
        @user_feedback = Spree::UserFeedback.find params[:id]
      end

      def user_feedback_url(*args)
        admin_user_feedback_path(args)
      end
    end
  end
end
