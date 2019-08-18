$(function(){
  function buildHTML(message){
    var addImage = (message.image_url) ? `<img class = "lower-message__image", src="${message.image_url}">` : "";
    var addContent = (message.content) ? `${message.content}` : "";
    var html = 
      `<div class="message">
        <div class="message__upper-info">
          <div class="message__upper-info__talker">
            ${message.user_name}
          </div>
          <div class="message__upper-info__date">
            ${message.created_at}
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
});
