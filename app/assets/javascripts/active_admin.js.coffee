//= require active_admin/base
//= require fancybox


# Sort Product columns
sendSortRequestOfModel = (model_name) ->
  formData = $('#' + model_name + ' tbody').sortable('serialize')
  formData += "&" + $('meta[name=csrf-param]').attr("content") +
    "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"))
  $.ajax
    type: 'post'
    data: formData
    dataType: 'script'
    url: '/admin/' + model_name + '/sort'

jQuery ($) ->
  # home page slides
  if $('body.admin_products.index').length
    $( "#products tbody" ).disableSelection()
    $( "#products tbody" ).sortable
      axis: 'y'
      cursor: 'move'
      cancel: "a,button"
      update: (event, ui) ->
        sendSortRequestOfModel("products")