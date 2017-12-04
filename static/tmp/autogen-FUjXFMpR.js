
document.onreadystatechange = () => {
  if (document.readyState === 'complete') {
    $('input').keypress(function (e) {
           if (e.which != 13) return;
           var $val = $(this).val();
           var $el = $("li.message").last().append(`<div class="message">${$val}</div>`)
           $(this).val("")

         

       });
  }
};
