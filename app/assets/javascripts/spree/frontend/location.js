$(function() {
  var country, latitude, longitude;
  if (!$('body').data('hook').length) {
    return;
  }
  latitude = $('body > .wrapper').data('latitude');
  longitude = $('body > .wrapper').data('longitude');
  country = $('body > .wrapper').data('country');
  if (latitude.length !== 0 && latitude !== undefined && longitude.length !== 0 && longitude !== undefined && country.length !== 0 && country !== undefined) {

    saveUserLocationToCookies(latitude, longitude, country);
    return document.cookie = 'location_confirmed=' + true + ";path=/";
  } else {
    if (getCookieValueFor('location_confirmed') === '' || getCookieValueFor('user_latitude') === '' || getCookieValueFor('user_longitude') === '' || getCookieValueFor('user_country') === '') {
      document.cookie = 'location_confirmed=' +false+ ";path=/";
    }
    if (navigator.geolocation) {
      return navigator.geolocation.getCurrentPosition(successGPSLocation, errorGPSLocation);
    } else {
      return showLocation(null);
    }
  }
});

this.saveUserLocationToCookies = function(latitude, longitude, country) {
  var reloadPage;
  reloadPage = false;
  if (getCookieValueFor('user_latitude') === '') {
    reloadPage = true;
    document.cookie = 'user_latitude=' + latitude + ";path=/";
    document.cookie = 'user_longitude=' + longitude + ";path=/";
    document.cookie = 'user_country=' + country + ";path=/";
  }
  if (reloadPage) {
    location.reload();
  }
};

this.successGPSLocation = function(position) {
  if (getCookieValueFor('location_confirmed')!='false' && $.cookie("user_latitude").length > 0 && $.cookie("user_longitude").length > 0) {
    return showLocation({
      latitude: $.cookie("user_latitude"),
      longitude: $.cookie("user_longitude")
    });
  } else {
    return showLocation(position.coords);
  }
};

this.errorGPSLocation = function(_error) {
  return showLocation(null);
};

this.showLocation = function(coords) {
  return $.ajax({
    type: 'GET',
    dataType: 'script',
    url: '/users/show_map',
    data: coords
  });
};

(function() {
  var cookies, getCookieValueFor;
  cookies = void 0;
  getCookieValueFor = function(key) {
    var b;
    b = document.cookie.match('(^|;)\\s*' + key + '\\s*=\\s*([^;]+)');
    if (b) {
      return b.pop();
    } else {
      return '';
    }
  };
  window.getCookieValueFor = getCookieValueFor;
})();
