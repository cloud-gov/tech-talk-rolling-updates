# Demo

Demonstrates the use of rolling updates on `push`.

Talk TrackNotes:
- It is not just the downtime
- Two apps creates challenges in logging, event queue, other including service discovery, distributed tracing
- `--strategy rolling` also available on restart and restage


## Prerequisites

The demo is scripted with demo-magic-redux to make it easy and repeatable. To ensure no complication with licenses, clone the following repo locally:

- Demo Magic Redux: https://github.com/omkensey/demo-magic-redux.git


### Configuration

Configuration is provided via the `demo.cfg` file in this directory. Review and update the config to ensure it matches your environment.

## Running the demo

The demo will set itself up by deploying the sample app to save time. Before you are ready to demo:

1. Login and target an org/space
2. Run `demo.sh`. The demo script will first deploy the sample app as the 'blue' version of the app. The script will run a `clear` when the demo is ready (hiding the push output).

