$(document).on('turbolinks:load', function() {
  function addNewMessagesHTML(comment){
    var html = `<div class="message" data-message-id="${comment.id}"><p class="name-write--name">${comment.name}</p>
    <p class="name-write--date">${comment.date}</p>
    `

    if (comment.text != null) {
    html = html + `<p class="name-write--small">${comment.text}</p>
    `
    }
    if (comment.image.url != null) {
    html = html + `<p><img src="${comment.image.url}" alt="image"></p>
    `
    }

    html = html + '</div>'
    $('.right-mid').append(html)
  }

  var interval =  setInterval(function(){
  if (window.location.href.match(/\/groups\/\d+\/messages/)) {
    $.ajax({
      url: location.href.json,
      dataType: 'json',
    })
    .done(function(data){
    var divmessage =$('.message')
    var html = ''
    var id = $($('.message')[divmessage.length-1]).data('messageId');
    if (data.messages.length != 0) {
      data.messages.forEach(function(message){
        if (message.id > id || id == null) {
          addNewMessagesHTML(message);
        }
      });
    }

    })
    .fail(function(){
      alert('エラーが発生しました。');
    })
  } else {
    clearInterval(interval);
  }
  },5000);
});
