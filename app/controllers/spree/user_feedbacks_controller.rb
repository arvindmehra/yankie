module Spree
  class UserFeedbacksController < Spree::StoreController
    def create
      @user_feedback = build_user_feedback(user_feedback_params)

      flash['warning'] = @user_feedback.errors.full_messages.join('; ') unless @user_feedback.save

      redirect_to root_path
    end

    private

    def user_feedback_params
      @user_feedback_params ||= params.require(:user_feedback).permit(:text, :stars, :service_provider_id)
    end

    def build_user_feedback(params)
      if spree_current_user
        spree_current_user.user_feedbacks.build params
      else
        raise 'Guests cannot make a feedback.'
        # Spree::UserFeedback.new(params)
      end
    end
  end
end
