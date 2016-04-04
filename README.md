#State machine

Manage the behaviour of a class without keeping track of the states of an object with multiple boolean attributes using state transitions and callbacks.

## Usage

### State

``` actionscript
// Create a state with transition callbacks and a list of other state names that are allowed to transition into this state.
var state:State = new State("state", new <String> ["otherState", "otherState2"], enterCallback, updateCallback, exitCallback);
```

### State machine

``` actionscript
// Create a state machine with two states
var stateMachine:StateMachine = new StateMachine("State Machine");

stateMachine.add(state1);
stateMachine.add(state2);
			
// set initial state
// if the state machine doesn't have a current state it jumps directly into that state
stateMachine.changeToState(state1.name);

stateMachine.changeToState(state2.name);
```
