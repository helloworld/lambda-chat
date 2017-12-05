var commentid = $('#commentid')
  .text()
  .trim()
var userid = $('#userid')
  .text()
  .trim()
var username = $('#username').text()

commentid = parseInt(commentid)
userid = parseInt(userid.replace('Just', ''))

var loaded_count = 0;
var last_id;

function load_messages() {
  $.get('/message/' + commentid, function(data) {
    console.log("Pulling")
    for (var i = loaded_count; i < data.length; i++) {
      if (last_id == data[i].userId) {
        $('li.message')
          .last()
          .append(`<div class="message">${data[i].message}</div>`)
      } else {
        var html = `<li class="message ${data[i].userId == userid ? "me" : ""}">
                      <div class="user">${data[i].username}</div>
                      <div class="message">${data[i].message}</div>
                    </li> `

        $('.chat_container').append(html)
        last_id = data[i].userId
      }
    }

    loaded_count = data.length;
    setTimeout(function() {
      console.log("laskdfj")
      load_messages();
    }, 400)
  })
}

function set_event_handlers() {
  $('input').keypress(function(e) {
    if (e.which != 13) return
    var message = $(this).val()
    var $el = $('li.message')
      .last()
      .append(`<div class="message">${message}</div>`)
    $(this).val('')

    $.ajax({
      url: '/message',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        message: message,
        comm: commentid,
        username: username,
      }),
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        console.log('Error creating comment: ' + data)
      },
    })
  })
}

$(document).ready(function() {
  load_messages()
  set_event_handlers()
})
