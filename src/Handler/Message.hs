module Handler.Message where

import Import

getMessageR :: Int -> Handler Value
getMessageR slug = do
    allMessages <- runDB $ selectList [MessageComm ==. slug] []
    returnJson allMessages

-- postMessageR :: ChannelId -> Handler Value
-- postMessageR slug = do
--     -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
--     -- (The ToJSON and FromJSON instances are derived in the config/models file).
--     message <- (requireJsonBody :: Handler Message)

--     -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
--     maybeCurrentUserId <- maybeAuthId
--     let message' = message { messageUserId = maybeCurrentUserId }

--     insertedMessage <- runDB $ insertEntity message'
--     returnJson insertedMessage

postMessageR :: Int -> Handler Value
postMessageR slug = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    comment <- (requireJsonBody :: Handler Message)

    -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
    maybeCurrentUserId <- maybeAuthId
    let comment' = comment { messageUserId = maybeCurrentUserId }

    insertedChannel <- runDB $ insertEntity comment'
    returnJson insertedChannel
