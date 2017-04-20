$(document).on 'page:change', ->
  window.dataConfirmModal.setDefaults
    title: '提示'
    commit: '确定'
    cancel: '取消'