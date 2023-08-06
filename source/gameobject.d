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
}
