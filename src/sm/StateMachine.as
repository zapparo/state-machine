package sm 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Ionut Ghenade
	 */
	public class StateMachine 
	{
		private var _name:String;
		
		private var _states:Dictionary;
		private var _currentStateName:String;
		private var _lastStateName:String;
		
		private var _verbose:Boolean;
		
		public function StateMachine(name:String, verbose:Boolean = false) 
		{
			_name = name;
			_states = new Dictionary();
			_verbose = verbose;
			_lastStateName = "";	
		}
		
		public function add(state:State):void
		{
			if (_states[state.name] == undefined) {	
				_states[state.name] = state;
				if (_verbose ) { trace(this, state.name + " ADDED"); }		
			}
		}
		
		public function removeState(name:String):void
		{
			if (_states[name] == undefined) {
				delete _states[name]; 				
				if (_verbose ) { trace(this, name + " REMOVED"); }
			}
		}
		
		// transition into a new state, if the state machine doesn't have a current state jump into that state
		
		public function changeToState(name:String):void
		{
			if (_states[name] == undefined) { return; }		
			
			if (canChangeToState(name)) {
				
				var oldState:State = _states[_currentStateName];	
				
				if(oldState != null) {
					if (oldState.exit != null) { oldState.exit.call(); }													
					_lastStateName = oldState.name;					
					
					if (_verbose ) { trace(this, _lastStateName + " CHANGED TO " + name); }
				} else {
					if (_verbose ) { trace(this, "JUMPED INTO " + name); }
				}
								
				_currentStateName = name;
				var newState:State = _states[_currentStateName];
				if (newState.enter != null) { newState.enter.call(); }										
					
			} else {
				if (_verbose ) { trace(this, "CAN'T CHANGE TO STATE " + name + " FROM " + _currentStateName); }
			}
		}
		
		private function canChangeToState(name:String):Boolean
		{			
			if (_currentStateName == null) { 
				return true; 				
			} else {
				return _states[name].from.indexOf(_currentStateName) != -1 || _states[name].from == null;
			}
			
			return false;
		}
		
		public function update():void
		{
			if (_currentStateName != null) {
				var state:State = _states[_currentStateName];
				if (state != null) {
					if (state.update != null) { state.update.call(); }
				}
			}
		}
		
		public function toString():String { return "STATE MACHINE[" + _name + "]"; }
	}

}