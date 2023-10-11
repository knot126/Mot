/*
 * In theory this does something nice like having a struct that can do dynamic
 * typing and also having dynamic objects that you can use to do nice things.
 * 
 * I'm not sure if it is really so nice...
 */

import maths;

class MTObject {
	void *[string] data;
	
	void set(T)(string attr, T *data) {
		/*
		 * Set data on the object
		 */
		
		T *memory = new T[1];
		memory[0] = data;
		
		this.data[attr] = cast(void *) memory;
	}
	
	T get(T)(string attr) {
		/*
		 * Get data for this object
		 */
		
		return (cast(T *) this.data[attr])[0];
	}
	
	bool has(string key) {
		/*
		 * Return true if an element exists.
		 */
		
		return (key in this.data) != null;
	}
}
