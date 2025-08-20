# Nodes

## Setup

to create node go to `Configure Jenkins` -> `Nodes`
- click on `+ New node`
  1. `permanent agent` & Continue
  2. `Number of executors` INFO: How many jobs it can run parallel
  3. `Remote root directory` INFO: Node/runner path (root path were jenkins is allowed to create files and run commands)
  4. `Labels` INFO: e.g.: use label windows to group all windows machines, same for linux etc.
  5. `Launch Method` INFO: Connecting to controller, Via SSH
  6. `Availability` INFO: Chose when slave node is available

## Make your Node to use a specific Node

When creating an Item you can chose the option: `Restrict where this project can be run` in general section
- e.g. `Label Expression`: `ubuntu_24_agent`