var commentid = $("#commentid").text().trim()
var userid = $("#userid").text().trim()
var username = $("#username").text()

commentid = parseInt(commentid)
userid = parseInt(userid.replace("Just", ""))

document.onreadystatechange = () => {

  $.get("/message/" + commentid, function(data) {
    for (var i = 0; i < data.length; i++) {
      console.log(data[i])
      var html = `<li class="message">
            <div class="user">${data[i].userid}</div>
            <div class="message">${data[i].message}</div>
            </li> `

      $(".chat_container").append(html)
    }
  })


  if (document.readyState === 'complete') {
    $('input').keypress(function (e) {
           if (e.which != 13) return;
           var message = $(this).val();
           var $el = $("li.message").last().append(`<div class="message">${message}</div>`)
           $(this).val("")

           $.ajax({
                 url: '/message',
                 type: 'POST',
                 contentType: "application/json",
                 data: JSON.stringify({
                   message: message,
                   comm: commentid,
                 }),
                 success: function (data) {
                   console.log(data);
                   // var html = `
                   //   <tr>
                   //       <td>
                   //           <h4 class="ui header">
                   //               <div class="content"> ${data.message}
                   //           </h4>
                   //           <div class="sub header">CMSC498V</div>
                   //       </td>
                   //       <td> 22 </td>
                   //       <td> <a href="/" class="ui green button">Join</a> </td>
                   //   </tr>
                   // `
                 },
                 error: function (data) {
                   console.log("Error creating comment: " + data);
                 },
               });

       });
  }
};
