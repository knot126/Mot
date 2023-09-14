import mtobject;

alias MTObjectID = uint;

struct MTLayer {
	MTObject[MTObjectID] objects;
	MTObjectID current_id = 1;
	
	uint addObject(MTObject object) {
		this.objects[this.current_id] = object;
		return this.current_id++;
	}
	
	void getObjectRef(out MTObject object, MTObjectID id) {
		object = this.objects[id];
	}
}
