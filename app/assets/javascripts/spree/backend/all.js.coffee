#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require jquery.cookie
#= require spree/backend

#= require_tree .

#= require cocoon

$ ->
  $('#variant_locations, #product_time_ranges').on 'cocoon:after-insert', (e, insertedItem) ->
    $('#variant_locations .select2').slice(-2).select2()
    $('#product_time_ranges .select2').slice(-2).select2()

    $('.datepicker').datepicker
      showOn: 'focus'
      dateFormat: Spree.translations.date_picker


  subscribe_request_use_address_input = $('input#subscribe_request_use_address')

  subscribe_request_use_address = ->
    if !subscribe_request_use_address_input.is(':checked')
      $('#delivery').show()
    else
      $('#delivery').hide()
    return

  subscribe_request_use_address_input.click ->
    subscribe_request_use_address()
    return

  subscribe_request_use_address()

  subscribe_request_have_already_input = $('input#subscribe_request_have_already_account')

  subscribe_request_have_already_account = ->
    if subscribe_request_have_already_input.is(':checked')
      $('.have-alreay').show()
      $('.do-not-have').hide()

      $('#addresses input, #addresses select').val('')
    else
      $('.have-alreay').show()
      # $('.have-alreay').hide()
      # $('.do-not-have').show()
    return

  subscribe_request_have_already_input.click ->
    subscribe_request_have_already_account()
    return

  subscribe_request_have_already_account()
