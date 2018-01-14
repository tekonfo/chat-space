$(function(){
  function buildHTML(comment){
    var html = `<p class="name-write--name">${comment.user_name}</p>
    <p class="name-write--date">${comment.updated_time}</p>
    <p class="name-write--small">${comment.text}</p>
    `
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.right-mid').append(html)
      $('#message_text').val('')
      $('.bottom-content__form__image__field').val('')
      $('.right-foot__image--display').val('')
      debugger;
      $("html,body").animate({scrollTop: $('.name-write--small')[$('.name-write--small').length-1].getBoundingClientRect().top})
      // $(".name-write--name").each(function(index,elem){
      //   $("html,body").animate({scrollTop:$(elem).offset().top});
      // });

    })
    .fail(function(){
      alert('メッセージを入力してください');
    })
  })
});
