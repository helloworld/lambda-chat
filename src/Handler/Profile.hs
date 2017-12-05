{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Profile where

import Import
import Text.Julius (RawJS (..))

getProfileR :: Handler Html
getProfileR = do
    (_, user) <- requireAuthPair
    let email = userIdent user
    let display = case userDisplay user of { Nothing -> email ; Just x -> x }
    defaultLayout $ do
        let (displayFormId, displayTextareaId) = formIds
        aDomId <- newIdent
        setTitle . toHtml $ userIdent user <> "'s User page"
        $(widgetFile "profile")

postProfileR :: Handler Value
postProfileR = do
  user <- requireAuthId
  --maybeId <- runDB $ get404 user
  TextRequest display <- (requireJsonBody :: Handler TextRequest)
  a <- runDB $ (update user [UserDisplay =. Just display])
  returnJson display

formIds :: (Text, Text)
formIds = ("js-displayForm", "js-displayTextarea")
