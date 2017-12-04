var commentid = $("#commentid").text().trim()

document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    $('input').keypress(function (e) {
           if (e.which != 13) return;
           var message = $(this).val();
           var $el = $("li.message").last().append(`<div class="message">${$val}</div>`)
           $(this).val("")

           $.ajax({
                 url: '/message',
                 type: 'POST',
                 contentType: "application/json",
                 data: JSON.stringify({
                   message: message,
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
