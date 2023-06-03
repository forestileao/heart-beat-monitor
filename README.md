# AcmeHeartBeat

## Introducing the Solution for HBM+ (Heart-beat Monitor - Plus)

Solution Architecture:
The solution for HBM+ has been developed following a context-based architecture, adhering to the principles of Domain-Driven Design (DDD). The architecture was designed to meet the requirements of the problem while ensuring scalability, modularity, and maintainability of the system.

The solution architecture consists of three main layers:

1. Presentation Layer:
   In this layer, we have the HBM+ API, responsible for receiving client requests and providing corresponding responses. The API is built using a web framework Phoenix (Elixir), which simplifies the creation of the JSON API. The API receives requests, validates the data, invokes the appropriate services, and returns responses to clients.

2. Service Layer:
   The service layer contains the business logic of HBM+. It is responsible for receiving data from the API, applying the business rules, invoking the necessary services, and returning the results. This layer implements services related to heart rate monitoring, such as calculating the current value, obtaining data within a specific range, analyzing patterns, and other domain-specific functionalities of HBM+.

3. Data Layer:
   The data layer handles the persistence and access of data in HBM+. Since there is no mention of a database requirement in the problem, a separate data layer was not necessary. However, if data persistence is required in the future, a suitable database, such as a relational database like PostgreSQL or a NoSQL database, can be integrated into the data layer to handle data storage and retrieval operations.

## Explanation of the Developed Code:
The code developed for HBM+ follows best programming practices, emphasizing separation of concerns and utilizing well-structured functions and modules. The problem requirements are addressed through functions and modules that implement the business logic, such as calculating the current heart rate value and retrieving data within a specific interval.

In addition, automated tests were created to ensure the correct functioning of the system's features. These tests ensure code quality and enable safe modifications, preventing regressions and unexpected issues.

Demonstration of the Functioning Prototype:
The prototype of HBM+ has been developed based on the aforementioned architecture and is fully operational. Through the HBM+ API, it is possible to make requests to retrieve the current heart rate value and retrieve heart rate data within a specific interval.

For example, accessing the `api/v1/monitor` route of the API returns the current heart rate value. Similarly, accessing the `api/v1/monitor/range?from=timestamp1&to=timestamp2` route allows retrieving heart rate data recorded within the specified time interval.


## Start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Dashboard
  The App dashboard can be accessed on `http://localhost:4000/dev/dashboard`, only on dev enviroment.

  <img src="https://i.imgur.com/8HQqOfA.png" alt="dashboard image">

## Routes:

  - GET [/api/v1/monitor]: Get the current value of the HeartBeat
  - GET [/api/v1/monitor/range?from=timestamp1&to=timestamp2]: Get the value of heartbeat on a specific timestamp range

## Socket:

  Also, was implemented a websocket on route `ws://localhost:4000`

  To implement it on yout javascript front-end, use the 'phoenix-channels' npm package:

  ```js
  const {Socket} = require('phoenix-channels')
  let socket = new Socket("ws://localhost:4000/socket")
  
  socket.connect()
  
  
  let channel = socket.channel("monitor:lobby")
  channel.join()
      .receive("ok", rest => { console.log("Connected") })
  
  const push = channel.push("heart_beat")
  
  push.receive("ok", resp => console.log(resp))
  // { heart_beat: 0.17961332544535868 }
  ```

## Tests

  Controllers and Monitor Service tests were implemented on `/tests` directory.
  Run them with:
  
  ```sh
  mix test
  ```