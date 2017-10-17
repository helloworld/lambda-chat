# λ-chat
> A chat messaging service implemented in Haskell (Yesod) and React.

HM is an implementation of a messaging service implemented using the [Yesod Web Framework](https://www.yesodweb.com/) for Haskell and [React](https://reactjs.org/). 

Application Features:
- Supports channels for parallel conversations
- @mentions to alert users
- Threads to allow branched conversations within channel 

Development Features: 
- Uses [yesod-websockets](https://hackage.haskell.org/package/yesod-websockets) to allow realtime, low-latency communication
- Written in ES6, transpiled using Babel (https://babeljs.io/)
- JavaScript statically type checked with Flow (https://flow.org/)

## Development setup

**Requirements**

- Install Haskell Stack for Haskell, GHC, and Stack (https://haskell-lang.org/get-started)

To clone and install dependencies, run:

```sh
git clone https://github.com/helloworld/lambda-chat
stack install
```

## Testing

To execute linting, type checking, and run tests, run:

```sh
npm run test
```

