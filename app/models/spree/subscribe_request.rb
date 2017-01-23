module Spree
  class SubscribeRequest < ActiveRecord::Base
    DURATION = 1.year

    enum salutation: {
      dr: 0,
      miss: 1,
      mr: 2,
      mrs: 3,
      ms: 4,
      sir: 5
    }

    enum gender: {
      male: 0,
      female: 1
    }

    enum secret_question: {
      mothers_maiden_name: 0,
      my_favourite_pets_name: 1,
      the_town_where_i_was_born: 2
    }

    before_validation :clone_address, if: :use_address?

    attr_accessor :use_address

    belongs_to :address, foreign_key: :address_id, class_name: 'Spree::Address', dependent: :destroy
    belongs_to :delivery_address, foreign_key: :delivery_address_id, class_name: 'Spree::Address', dependent: :destroy
    belongs_to :service_provider, class_name: 'Spree::User', foreign_key: :service_provider_id
    belongs_to :role_user, dependent: :destroy

    has_one :legal_identification, as: :viewable, dependent: :destroy, class_name: 'Spree::Document'
    has_one :legal_business_document, as: :viewable, dependent: :destroy, class_name: 'Spree::Document'

    accepts_nested_attributes_for :address, reject_if: :all_blank
    accepts_nested_attributes_for :delivery_address, reject_if: :all_blank
    accepts_nested_attributes_for :legal_identification, reject_if: :all_blank
    accepts_nested_attributes_for :legal_business_document, reject_if: :all_blank

    with_options presence: true do
      validates :state
      validates :service_provider

      with_options if: :have_already_account? do
        validates :existing_account_number
        validates :api_key
        validates :api_merchant_code
        validates :api_passphrase
      end

      with_options if: :approved? do
        # validates :existing_account_number
        validates :api_key
        validates :api_merchant_code
        validates :api_passphrase
      end

      with_options unless: :have_already_account? do
        validates :salutation
        validates :firstname, length: { in: 1..254, allow_blank: true }
        validates :surname, length: { in: 1..254, allow_blank: true }
        validates :email, length: { in: 1..254, allow_blank: true }
        validates :birth_date
        validates :mobile_number, length: { in: 1..254, allow_blank: true }
        validates :gender
        validates :secret_question
        validates :secret_answer, length: { in: 1..254, allow_blank: true }
        validates :i_agree, inclusion: { in: [true], allow_blank: true }
        validates :legal_identification
        validates :legal_business_document
        validates :address
        validates :delivery_address
      end
    end

    with_options unless: :have_already_account? do
      validates :initial, length: { in: 1..1, allow_blank: true }
      validates :referred_by, length: { in: 1..254, allow_blank: true }
      validates :phone_number, length: { in: 1..254, allow_blank: true }
      validates :fax_number, length: { in: 1..254, allow_blank: true }
    end

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

      event :to_review do
        transition [:approved, :rejected] => :on_review
      end

      after_transition any => :approved do |subscribe_request, _transition|
        subscribe_request.make_as_pro_service_provider!
      end

      after_transition any => :approved do |subscribe_request, _transition|
        subscribe_request.make_as_pro_service_provider!
      end

      after_transition any => :rejected do |subscribe_request, _transition|
        subscribe_request.make_as_not_pro_service_provider!
      end
    end

    def make_as_pro_service_provider!
      pro_service_provider_role = Spree::Role.find_by! name: 'pro_service_provider'

      self.role_user = service_provider.role_users.find_or_create_by!(role: pro_service_provider_role) do |role_user|
        role_user.until_date = Time.zone.now + DURATION
      end

      service_provider.update!(
        api_key: api_key, api_passphrase: api_passphrase, api_merchant_code: api_merchant_code
      )

      self.approved_at = Time.zone.now
      save!
    end

    def make_as_not_pro_service_provider!
      role_user.try(&:destroy)

      self.rejected_at = Time.zone.now
      save!
    end

    private

    def use_address?
      use_address.to_b
    end

    def clone_address
      if address && delivery_address.nil?
        self.delivery_address = address.clone
      else
        delivery_address.attributes = address.attributes.except('id', 'updated_at', 'created_at')
      end

      true
    end
  end
end
