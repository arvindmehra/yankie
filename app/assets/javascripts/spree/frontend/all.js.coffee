#= require jquery
#= require jquery_ujs
#= require jquery.cookie
#= require spree/frontend

#= require_tree .
#= require jquery-ui/datepicker

#= require moment
#= require bootstrap-datetimepicker
#= require moment

#= require jquery.fancybox

# dates = {}

available = (dateString) ->
  # date = moment(dateString).format('LL')
  #
  # if dates[date] == undefined
  #   $.ajax
  #     type: 'GET'
  #     dataType: 'script'
  #     url: "/products/#{$('body').attr('id')}/available_days"
  #     data:
  #       date: date
  #     success: (response) ->
  #       $.extend(dates, JSON.parse(response))
  #       return available(dateString)
  # else
  #   return dates[date]
  #
  # console.log(Object.keys(gon.available_days).slice(-1)[0])

  return gon.available_days[moment(dateString).format('GGGG-MM-DD')]


handle_date_picker_fields_for_modal = ->
  $('.modal').on 'shown.bs.modal', (e) ->
    $('.datepicker').datepicker
      showOn: 'focus'
      dateFormat: 'yy/mm/dd'
      beforeShowDay: (date) ->
        if available(date)
          return [true, '', 'There are seats available']
        else
          return [false, '', 'There are no seats available']

    $('#options_completion_date').change () ->
      $.ajax
        type: 'GET'
        dataType: 'script'
        url: "/products/#{$('body').attr('id')}/available_time_for_day"
        data:
          date: $(this).val()
        success: (response) ->
          # Clear the select box
          $('#options_completion_time').val('')
          $("#options_completion_time").empty()

          $.each(JSON.parse(response), (_key, dateString) ->
            timeString = moment(dateString).utc().format("HH:mm")
            $("#options_completion_time").append(new Option(timeString, timeString))
          )

display_active_menu = ->
  value = $('form#global_search #taxon').val()
  $('form#global_search .dropdown-menu li').removeClass('active')
  if value
    $("form#global_search .dropdown-menu li[data-value=#{value}]").addClass('active')

$(document).ready ->
  $('.fancybox').fancybox()

  $('.rating#leave_feedback').click () ->
    $('#form_leave_feedback').modal('toggle')

  handle_date_picker_fields_for_modal()
  $('#datetimepicker').datetimepicker()
  display_active_menu()
  $('form#global_search .dropdown-menu li').click () ->
    $('form#global_search #taxon').val($(this).data('value'))
    # submit form with redirect
    $('form#global_search button.glyphicon.glyphicon-search').click()
