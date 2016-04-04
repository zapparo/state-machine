package sm 
{
	/**
	 * ...
	 * @author Ionut Ghenade
	 */
	
	public class State
	{
		public var name:String;
		
		// a list of events that can transition into this state
		public var from:Vector.<String>;
		
		// state transition callbacks
		public var enter:Function;
		public var update:Function;
		public var exit:Function;		
		
		public function State(name:String, from:Vector.<String> = null, enter:Function = null, update:Function = null, exit:Function = null)
		{
			this.name = name;			
			this.from = from;
			this.enter = enter;
			this.update = update;
			this.exit = exit;
		}
		
		public function toString():String { return "STATE: " + this.name; }
	}

}