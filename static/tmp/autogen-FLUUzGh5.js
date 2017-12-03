// document.getElementById("hident4").innerHTML = "This text was added by the Javascript part of the homepage widget.";

$(function() {
  $("#js-commentForm").submit(function(event) {
    event.preventDefault();

    var message = $("#js-createCommentTextarea").val();
    // (Browsers that enforce the "required" attribute on the textarea won't see this alert)
    if (!message) {
      alert("Please fill out the comment form first.");
      return;
    }

    // Make an AJAX request to the server to create a new comment
    $.ajax({
      url: 'http://localhost:3000/comments',
      type: 'POST',
      contentType: "application/json",
      data: JSON.stringify({
        message: message,
      }),
      success: function (data) {
        var html = `
          <tr>
              <td>
                  <h4 class="ui header">
                      <div class="content"> ${data.message}
                  </h4>
                  <div class="sub header">CMSC498V</div>
              </td>
              <td> 22 </td>
              <td> <a href="/" class="ui green button">Join</a> </td>
          </tr>
        `
        $("#js-commentList").append(html);
      },
      error: function (data) {
        console.log("Error creating comment: " + data);
      },
    });

  });
});
