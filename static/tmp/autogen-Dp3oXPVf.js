function hident2(){if(navigator.id){navigator.id.watch({onlogin:function(assertion){if(assertion)document.location="http://localhost:3000/auth/page/browserid/"+assertion},onlogout:function(){}});navigator.id.request({returnTo:'/auth/login?autologin=true'})}else alert("Loading, please try again")}(function(){var bid=document.createElement("script");bid.async=true;bid.src="https://login.persona.org/include.js";var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(bid,s)})()