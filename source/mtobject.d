
enum MTValueType {
	None,
	Null,
	Integer,
	Rational,
	String,
	Symbol,
	Class,
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

struct MTObject {
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
}
