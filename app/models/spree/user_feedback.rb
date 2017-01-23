class Spree::UserFeedback < ActiveRecord::Base
  belongs_to :service_provider, class_name: 'Spree::User', foreign_key: :service_provider_id
  belongs_to :user

  with_options presence: true do
    validates :text
    validates :stars, inclusion: { in: [1, 2, 3, 4, 5], allow_blank: true }
    validates :service_provider, uniqueness: { scope: :user_id }
    validates :user
    validates :state
  end

  after_destroy :update_rating

  state_machine :state, initial: :on_review do
    state :on_review
    state :rejected
    state :approved

    event :reject do
      transition [:on_review] => :rejected
    end

    event :approve do
      transition [:on_review] => :approved
    end

    after_transition any => :approved do |user_feedback, _transition|
      # Update rating!
      ::RatingsUpdater.perform_async(user_feedback.service_provider.id)
    end
  end

  # Because of stupid state machine. There is no default scopes.
  state_machine.states.map do |state|
    scope state.name, -> { where(state: state.name.to_s) }
  end

  private

  def update_rating
    ::RatingsUpdater.perform_async(service_provider.id)
  end
end
