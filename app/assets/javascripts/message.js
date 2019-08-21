$(function(){
  function buildHTML(message){
    var addImage = (message.image_url) ? `<img class = "lower-message__image", src="${message.image_url}">` : "";
    var addContent = (message.content) ? `${message.content}` : "";
    var html = 
      `<div class="message" data-message-id="${ message.id }">
        <div class="message__upper-info">
          <div class="message__upper-info__talker">
            ${message.name}
          </div>
          <div class="message__upper-info__date">
            ${message.date}
          </div>
        </div>
        <div class="lower-message">
          <p class="lower-message__content">
            ${addContent}
          </p>
            ${addImage}
        </div>
      </div>`;
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
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
      $('.messages').append(html);
      $('.new_message')[0].reset();
      $('.form__submit').prop('disabled', false);
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight });
    })
    .fail(function(){
      alert('エラー');
      $('.form__submit').prop('disabled', false);
    })
  })

  //自動更新
  $(function(){
    setInterval(autoUpdate, 3000);
  });
  function autoUpdate() {
    if (location.href.match(/\/groups\/\d+\/messages/)) {
      var last_message_id = $('.message').last().data('message-id');
      $.ajax({
        url: 'api/messages',
        type: 'GET',
        dataType: 'json',
        data: {id: last_message_id}
      })
      .done(function(messages) {
        if (messages.length !== 0) {
          messages.forEach(function(message) {
          var html = buildHTML(message);
            $('.messages').append(html);
            $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight});
          });
        }
      })
      .fail(function(){
      alert("自動メッセージ取得に失敗しました");
      })
    } else {
      clearInterval(autoUpdate);
    }
  };
});
