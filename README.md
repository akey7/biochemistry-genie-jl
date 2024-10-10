# biochemistry-genie-jl
Biochemistry simulations to learn the Julia Genie framework.

## Setup

```
julia --project=.
julia> ]
(biochemistry-genie-jl) pkg> instantiate
```

## Development Tip!

To log from within the Julia code, use the `@info` macro as in `@info "This is a message!"`.

## How to launch the server

This will launch the app on port 8080:

```
julia --project=.
using GenieFramework; Genie.config.server_port = 8080; Genie.loadapp(); up()
```

Preferably, during development, use an incognito mode window so the browser's cache of development files can be cleared easily.
