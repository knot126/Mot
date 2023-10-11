/*
 * Bjarne Stroustrup wants to kill me OwO
 */

import lexer;

enum MTValueType {
	None,
	Null,
	Integer,
	Rational,
	String,
	Symbol,
	Object,
	NativeFunction,
	ScriptFunction,
}

union MTValueData {
	void *asPointer;
	long asInteger;
	double asRational;
	string asString;
	MTVector2 asVector2;
	MTValue[MTValue] asValueArray;
	MTScope *asScope;
	
	this(void *d) {
		this.asPointer = d;
	}
	
	this(long d) {
		this.asInteger = d;
	}
	
	this(double d) {
		this.asRational = d;
	}
	
	this(string d) {
		this.asString = d;
	}
	
	this(MTVector2 d) {
		this.asVector2 = d;
	}
}

struct MTValue {
	MTValueType type;
	MTValueData data;
	
	this(MTValueType type, MTValueData value = MTValueData()) {
		this.type = type;
		this.value = value;
	}
	
	alias data this;
}

struct MTScope {
	MTValue[string] vars;
	MTScope *parent;
	
	this(MTScope *parent) {
		this.parent = parent;
	}
	
	MTValue get(string name) {
		/*
		 * Search this scope and its parents for the variable.
		 */
		
		if (name in this.vars != null) {
			return this.vars[name];
		}
		
		if (parent) {
			return parent.get(name);
		}
		
		return MTValue(MTValueType.None);
	}
	
	bool has(string name, bool global = true) {
		/*
		 * Check if the current scope has the given value. If global is true,
		 * then the parent and so on will also be checked.
		 */
		
		return (name in this.vars) || (global && this.parent != null && this.parent.has(name, global));
	}
	
	void set(string name, MTValue value, bool global = true) {
		/*
		 * Set a value in the given scope
		 */
		
		// If the parent has `name`, it should be set in the parent
		if (global && this.parent && this.parent.has(name)) {
			this.parent.set(name, value, true);
			return;
		}
		
		this.vars[name] = value;
	}
	
	void setString(string name, string what, bool global = true) {
		this.set(name, MTValueData(MTValueType.String, what), global);
	}
}

struct MTStack {
	
}

/*
 * It would be more accurate to call this MTScriptVM, since it is mainly the
 * virtual mechine that runs the scripts with some functions to load code.
 * 
 * I'm for some reason a bit less confiedent than I was previously about knowing
 * enough to just make a VM but I think I can figure it out. I think I'm going to
 * store variable in a dict by name and not bother with trying to assign them
 * addresses.
 */
class MTScript {
	MTScope globals;
	
	void init() {
		this.globals = MTScope(null);
		this.globals.setString("__nuttle_version", "v0.0.0");
		this.globals.setString("__nuttle_corelib_name", "org.knot126.knock.basiccorelib");
		this.globals.setString("__nuttle_interpreter", "org.knot126.knock.interpreter");
		this.globals.setString("__nuttle_quirks", "")
	}
	
	void runString() {
		
	}
}
