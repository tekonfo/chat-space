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

  var interval = setInterval(function(){
  if (window.location.href.match(/\/groups\/\d+\/messages/)) {
    $.ajax({
      url: location.href.json,
      dataType: 'json',
    })
    .done(function(data){
    var divmessage = $('.message')
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

   function buildHTML(user){
    var html = `
      <div class="chat-group-user clearfix">
      <p class="chat-group-user__name">${user.name}</p>
      <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
      </div>`
    return html;
  }

    function clickHTML(user){
    var html = `
      <div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
      <input name='group[user_ids][]' type='hidden' value="${user.attr("data-user-id")}">
      <p class='chat-group-user__name'>${user.attr("data-user-name")}</p>
      <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
      </div>`
    return html;
  }

  $("#user-search-field").on("keyup", function() {
    var input = $(this).val();
    var user_ids = [];
    $(".js-chat-member").each(function(){
      value = $($(this).children()[0])
      user_ids.push(value.val());
    });
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input ,user_ids: user_ids},
      dataType: 'json',
    })

    .done(function(data) {
      var result = $("#user-search-result")
      result.empty();
      if (data.length !== 0) {
        data.forEach(function(data){
        var show_user_html = buildHTML(data);
        result.append(show_user_html);
          });
        }
      })
    .fail(function(){
      alert('検索に失敗しました');
    })
    });
  $(document).on("click",".user-search-add", function() {
    $input = $(this);
    var add_user_html = clickHTML($input);
    $("#search-users").append(add_user_html);
    $input.parent().remove();
    $.ajax({
      type: 'GET',
      url: '/users',
      dataType: 'json',
    })
    .done(function(data) {
    })
    .fail(function(){
      alert('追加に失敗しました');
    })
    });
    $(document).on("click",".js-remove-btn", function() {
    $(this).parent().remove();
    });
});
  });

