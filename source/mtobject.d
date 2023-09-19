/*
 * In theory this does something nice like having a struct that can do dynamic
 * typing and also having dynamic objects that you can use to do nice things.
 * 
 * I'm not sure if it is really so nice...
 */

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
}

struct MTValue {
	MTValueType type;
	MTValueData data;
	
	alias data this;
}

class MTObject {
	void *[string] data;
	
	void set(T)(string attr, T *data) {
		/*
		 * Set data on the object
		 */
		
		this.data[attr] = cast(void *) data;
	}
	
	T *get(T)(string attr) {
		/*
		 * Get data for this object
		 */
		
		return cast(T) this.data[attr];
	}
	
	bool has(string key) {
		/*
		 * Return true if an element exists.
		 */
		
		return (key in this.data) != null;
	}
}
