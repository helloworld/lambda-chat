{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Handler.ChannelSpec (spec) where

import TestImport
import Data.Aeson

spec :: Spec
spec = withApp $ do
    describe "valid request" $ do
        it "gives a 200" $ do
            get HomeR
            statusIs 200

            let message = "My message" :: Text
                body = object [ "message" .= message ]
                encoded = encode body

            request $ do
                setMethod "POST"
                setUrl ChannelR
                setRequestBody encoded
                addRequestHeader ("Content-Type", "application/json")

            statusIs 200

            [Entity _id comment] <- runDB $ selectList [ChannelMessage ==. message] []
            assertEq "Should have " comment (Channel message Nothing)

    describe "invalid requests" $ do
        it "400s when the JSON body is invalid" $ do
            get HomeR

            let body = object [ "foo" .= ("My message" :: Value) ]

            request $ do
                setMethod "POST"
                setUrl ChannelR
                setRequestBody $ encode body
                addRequestHeader ("Content-Type", "application/json")

            statusIs 400

