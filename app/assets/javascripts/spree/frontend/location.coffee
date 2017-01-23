$ ->

  return unless $('body').data('hook').length

  latitude  = $('body > .wrapper').data('latitude')
  longitude = $('body > .wrapper').data('longitude')
  country   = $('body > .wrapper').data('country')

  if latitude.length != 0 && latitude != undefined && longitude.length != 0 && longitude != undefined && country.length != 0 && country != undefined
    # Set approved location by user
    # console.log(document.cookie);
    saveUserLocationToCookies latitude, longitude, country
    document.cookie = 'location_confirmed=' + false+";path=/"
  else
    if getCookieValueFor('location_confirmed') == '' || getCookieValueFor('user_latitude') == '' || getCookieValueFor('user_longitude') == '' || getCookieValueFor('user_country') == ''
      document.cookie = 'location_confirmed=' + false+";path=/"
      # Try to detect user location
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(successGPSLocation, errorGPSLocation);
    else
      showLocation null


@saveUserLocationToCookies = (latitude, longitude, country) ->
  # localStorage.setItem('user_latitude', latitude)
  # localStorage.setItem('user_longitude', longitude)
  # localStorage.setItem('user_country', longitude)

  reloadPage = false

  if getCookieValueFor('user_latitude') == ''
    reloadPage = true

    document.cookie = 'user_latitude=' + latitude+";path=/"
    document.cookie = 'user_longitude=' + longitude+";path=/"
    document.cookie = 'user_country=' + country+";path=/"

  if reloadPage
    location.reload()

  return

@successGPSLocation = (position) ->
  if $.cookie("user_latitude").length > 0 && $.cookie("user_longitude").length > 0
    showLocation({latitude: $.cookie("user_latitude"), longitude: $.cookie("user_longitude")})
  else
    # saveUserLocationToCookies(position.coords.latitude, position.coords.longitude, null)
    showLocation(position.coords)

@errorGPSLocation = (_error) ->
  showLocation null

@showLocation = (coords) ->
  $.ajax
    type: 'GET'
    dataType: 'script'
    url: '/users/show_map'
    data: coords

do ->
  cookies = undefined

  getCookieValueFor = (key) ->
    b = document.cookie.match('(^|;)\\s*' + key + '\\s*=\\s*([^;]+)')

    if b then b.pop() else ''

  window.getCookieValueFor = getCookieValueFor

  return
