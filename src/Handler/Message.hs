module Handler.Message where

import Import

getMessageR :: CommentId -> Handler Value
getMessageR slug = do
    allMessages <- runDB $ getAllMessages
    returnJson allMessages

-- postMessageR :: CommentId -> Handler Value
-- postMessageR slug = do
--     -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
--     -- (The ToJSON and FromJSON instances are derived in the config/models file).
--     message <- (requireJsonBody :: Handler Message)

--     -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
--     maybeCurrentUserId <- maybeAuthId
--     let message' = message { messageUserId = maybeCurrentUserId }

--     insertedMessage <- runDB $ insertEntity message'
--     returnJson insertedMessage

postMessageR :: CommentId -> Handler Value
postMessageR slug = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    comment <- (requireJsonBody :: Handler Message)

    -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
    maybeCurrentUserId <- maybeAuthId
    let comment' = comment { messageUserId = maybeCurrentUserId }

    insertedComment <- runDB $ insertEntity comment'
    returnJson insertedComment


getAllMessages :: DB [Entity Message]
getAllMessages = selectList [] [Asc MessageId]
