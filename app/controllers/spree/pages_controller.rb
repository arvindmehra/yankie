class Spree::PagesController < Spree::StoreController
  include HighVoltage::StaticPage

  layout 'spree_application'
end
