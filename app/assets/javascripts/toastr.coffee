toastr.options = {
  closeButton: true,
  debug: false,
  progressBar: true,
  positionClass: 'toast-top-right',
  onclick: null,
  showDuration: '300',
  hideDuration: '1000',
  timeOut: '5000',
  extendedTimeOut: '1000',
  showEasing: 'swing',
  hideEasing: 'linear',
  showMethod: 'fadeIn',
  hideMethod: 'fadeOut'
}

@SuccessAlert = (msg) ->
  toastr.success(msg, '')

@WarningAlert = (msg) ->
  toastr.warning(msg, '')

@ErrorAlert =(msg) ->
  toastr.error(msg, '')


