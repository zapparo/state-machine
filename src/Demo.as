package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import sm.State;
	import sm.StateMachine;
	/**
	 * ...
	 * @author Ionut Ghenade
	 */
	public class Demo extends Sprite
	{
		private var _sm:StateMachine;
		
		public function Demo() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, update);
			
			
			_sm = new StateMachine("Demo", true);
			var stateMachine:StateMachine = new StateMachine("State Machine");
			stateMachine.add(state1);
			stateMachine.add(state2);
			
			_sm.changeToState(state1.name);
			
			var decidingState:State = new State("Deciding", new <String>["Decision A", "Decision B"], deciding);			
			var decisionAState:State = new State("Decision A", new <String>["Deciding"], null, runningDecisionA);
			var decisionBState:State = new State("Decision B", new <String>["Deciding"], null, runningDecisionB);
			
			_sm.add(decidingState);
			_sm.add(decisionAState);
			_sm.add(decisionBState);
			
			_sm.changeToState(decidingState.name);
		}
		
		private function update(e:Event):void 
		{
			_sm.update();			
		}
		
		public function deciding():void
		{			
			Math.random() > 0.5 ? _sm.changeToState("Decision A") : _sm.changeToState("Decision B");
		}
		
		public function runningDecisionA():void
		{
			// we can't actually change to this state because "Decision B" only allows this transition from "Deciding"
			_sm.changeToState("Decision B");
			
			Math.random() > 0.85 ? _sm.changeToState("Deciding") : trace("running decision A");
		}
		
		public function runningDecisionB():void
		{
			Math.random() > 0.85 ? _sm.changeToState("Deciding") : trace("running decision B");
		}		
	}

}