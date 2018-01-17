
$(function(){

  function buildHTML(user){
    var html = `
<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${user.name}</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
</div>`
    return html;
  }

  $("#user-search-field").on("keyup", function() {
    var input = $("#user-search-field").val();

    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json',
    })

    .done(function(data) {
      $("#user-search-result").empty();
      if (data.length !== 0) {
        data.forEach(function(data){
        var html = buildHTML(data);
              debugger;
        $("#user-search-result").append(html);
          });
        }
      })


    .fail(function(){
      alert('検索に失敗しました');
    })

    });
  });







