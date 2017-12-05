module Handler.Channel where

import Import

postChannelR :: Handler Value
postChannelR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    comment <- (requireJsonBody :: Handler Channel)

    -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
    maybeCurrentUserId <- maybeAuthId
    let comment' = comment { channelUserId = maybeCurrentUserId }

    insertedChannel <- runDB $ insertEntity comment'
    returnJson insertedChannel
