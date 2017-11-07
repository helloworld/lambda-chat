{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE MultiParamTypeClasses          #-}
{-# LANGUAGE CPP #-} -- to control production versus debug

import Yesod
import Yesod.Static
import Text.Hamlet (shamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Char (toLower)
import Data.List (sort)

data App = App

data Person = Person
    { name :: String
    ,  age :: Int
    }

mkYesod "App" [parseRoutes|
/ HomeR GET
/chat1 FuncR GET
/chat2 FacebookR GET
|]

instance Yesod App

styles = [lucius| 
    .container {
        width: 500px;
        margin: 0 auto;
        margin-top: 30px;
    }

    ul.chat_container {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    ul.chat_container li {
        display: block;
        clear: both;
        float: left;
    }

    li {
        width: 100%;
        margin-bottom: 10px;
    }

    li .message {
        display: inline-block;
        clear: both;
        margin: 2px 0px;
        background-color: red;
        padding: 5px 10px;
        border-radius: 13px;
        color: white;
    }

    li.me .message{
        float: right;
        background-color: #0084ff;
    }

    .user {
        color: #888;
        clear: both;
        font-size: 13px;
        margin-left: 2px;
        margin-bottom: 0px;
    }

    li.me .user {
        float:right;
        margin-right: 6px;
    }
    
    input {
        margin-top: 20px;
        width: 100%;
        padding: 20px;
    }
|]

chatjs = [julius|

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

   
|]

getHomeR = defaultLayout $ do
    setTitle "Lambda Chat"
    toWidget styles
    addScriptRemote "https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
    addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.js"
    addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css"
    toWidget
        [hamlet|
            <div class="container">
                <h1 class="header">𝝺-chat
                <div class="ui divider">
                <h3 class="ui blue header">Chat Rooms:
                <table class="ui basic celled table">
                    <thead>
                        <tr>
                            <th>Name
                            <th>Participants
                            <th>Link
                    <tbody>
                    <tr>
                        <td>
                            <h4 class="ui header">
                                <div class="content"> Functors and homomorphisms, oh my <div class="sub header">CMSC498V 
                        <td> 22 
                        <td> <a href=@{FuncR} class="ui green button">Join
                    <tr>
                        <td>
                            <h4 class="ui header">
                                <div class="content"> Facebook Recruiter <div class="sub header">Sarai 
                        <td> 22 
                        <td> <a href=@{FacebookR} class="ui green button">Join
        |]
    toWidgetBody
        [julius|
            console.log("This is included in the body itself");
        |]

getFuncR = defaultLayout $ do
    setTitle "Functors and homomorphisms, oh my"
    toWidget styles
    addScriptRemote "https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
    addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.js"
    addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css"
    toWidget
        [hamlet|
            <div class="container">
                <h1 class="header">𝝺-chat
                <div class="ui divider">

                <h3 class="ui header">Functors and homomorphisms, oh my
                <div class="ui red divider">

              
                <ul class="chat_container">
                    <li class="message">
                        <div class="user">Sashank
                        <div class="message">Hey!
                        <div class="message">Did you do the homework yet?
                    
                    <li class="message me">
                        <div class="user">Rex
                        <div class="message">Yes. 
                    
                    <li class="message">
                        <div class="user">Kevin
                        <div class="message">How long does it take?
                    
                    <li class="message">
                        <div class="user">Michael
                        <div class="message">Are foldMap and pmap interchangeable? They look really similar to me. 
                    
                    <li class="message me">
                        <div class="user">Rex
                        <div class="message">We are trying to emulate parallelization, so it's best to use pmap (which has already been defined in the homework for us to use). 
                        <div class="message">@Kevin prob 5 - 10 min
                    
                

                <input type="" placeholder="message (⏎ to send)" name="">

            
        |]
    toWidgetBody chatjs

getFacebookR = defaultLayout $ do
    setTitle "Functors and homomorphisms, oh my"
    toWidget styles
    addScriptRemote "https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
    addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.js"
    addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css"
    toWidget
        [hamlet|
            <div class="container">
                <h1 class="header">𝝺-chat
                <div class="ui divider">

                <h3 class="ui header">Sarai
                <div class="ui red divider">

              
                <ul class="chat_container">
                    <li class="message">
                        <div class="user">Sarai
                        <div class="message">Hey! So sorry, my house burned down. We'll get you your offer back in around 1 - 2 months. 
                    
                    
                    <li class="message me">
                        <div class="user">Rex
                        <div class="message">Oh. 
                    
                

                <input type="" placeholder="message (⏎ to send)" name="">

            
        |]
    toWidgetBody chatjs



main :: IO ()
main = warp 3000 App