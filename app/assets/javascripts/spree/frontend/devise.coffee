$ ->
  return unless $('body.devise').length

  if $('.alert').length
    currentHeight = $('body.devise .content .panel').height()
    $('body.devise .content .panel').height(currentHeight + 80)
