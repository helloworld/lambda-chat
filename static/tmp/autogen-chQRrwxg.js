var commentid = $("#commentid").text().trim()

document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    $('input').keypress(function (e) {
           if (e.which != 13) return;
           var $val = $(this).val();
           var $el = $("li.message").last().append(`<div class="message">${$val}</div>`)
           $(this).val("")

           $.ajax({
            url: '${MessageNew}',
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify({
              message: $val,
            }),
            success: function (data) {
              console.log(data);
            },
            error: function (data) {
              console.log("Error creating comment: " + data);
            },
          });

       });
  }
};
