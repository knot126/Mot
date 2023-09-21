import file;
import log;

MTResMan resman;

enum MTResManStorageType {
	None   = 0,
	Folder = 1,
	Bundle = 2,
}

struct MTResMan {
	MTResManStorageType type;
	union {
		string path;
		MTFile bundle;
	}
	
	void initWithFolder(string path) {
		this.type = MTResManStorageType.Folder;
		this.path = path;
	}
	
	void initWithBundle(string path) {
		this.type = MTResManStorageType.Bundle;
		MTLog(MTLogLevel.Error, "Bundles are not supported in this engine version");
	}
	
	byte[] readFile(string named) {
		switch (this.type) {
			case MTResManStorageType.Folder:
				return MTLoadFile(this.path ~ "/" ~ named);
				break;
			
			default:
				MTLog(MTLogLevel.Error, "Cannot load file " ~ named);
				break;
		}
	}
	
	byte[] load(string named) {
		return this.readFile(named);
	}
}
