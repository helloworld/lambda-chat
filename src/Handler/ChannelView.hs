{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.ChannelView where

import Import

getChannelViewR :: ChannelId -> Handler Html
getChannelViewR commentid = do
    (_, user) <- requireAuthPair
    maid <- maybeAuthId
    let email = userIdent user
    let display = case userDisplay user of { Nothing -> email ; Just x -> x }
    defaultLayout $ do
        setTitle . toHtml $ userIdent user <> "'s User page"
        $(widgetFile "channel-view")
