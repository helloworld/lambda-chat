document.getElementById("hident4").innerHTML="This text was added by the Javascript part of the homepage widget.";$(function(){$("#js-commentForm").submit(function(event){event.preventDefault();var message=$("#js-createCommentTextarea").val();if(!message){alert("Please fill out the comment form first.");return};$.ajax({url:'http://localhost:3000/comments',type:'POST',contentType:"application/json",data:JSON.stringify({message:message}),success:function(data){console.log(data);var newNode=$("<li></li>");newNode.text(data.message);console.log(data);$("#js-commentList").append(newNode)},error:function(data){console.log("Error creating comment: "+data)}})})})