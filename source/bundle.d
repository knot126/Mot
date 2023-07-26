import std.stdio;
import std.digest.sha;
import error;
import file;

string gBundlePath = "./bundles/";

struct MTBundleIdentifier {
	ubyte[20] hash;
	
	string toString() {
		return toHexString(this.hash);
	}
}

struct MTBundleFile {
	string name;
	uint size;
	uint entry_start;
	uint flags;
	
	this(string name, uint size, uint entry_start, uint flags) {
		this.name = name;
		this.size = size;
		this.entry_start = entry_start;
		this.flags = flags;
	}
}

struct MTBundle {
	MTBundleIdentifier identifier;
	MTBundleFile[] files;
	
	this(MTBundleIdentifier identifier) {
		this.identifier = identifier;
	}
	
	string getPath() {
		return gBundlePath ~ this.identifier.toString() ~ ".bundle";
	}
	
	MTError loadInfo(string fromPath) {
		MTFile file = MTFile(fromPath, MTFileMode.Read);
		
		// Read initial header
		file.seek(SEEK_END, -16);
		
		int count = file.readUInt();
		int entry_start = file.readUInt();
		int extra_start = file.readUInt();
		int magic = file.readUInt();
		
		if (magic != 1802531412) {
			return MTError.BadFormat;
		}
		
		// Read extra info
		file.seek(SEEK_SET, extra_start);
		
		// Read file entry data
		file.seek(SEEK_SET, entry_start);
		
		return MTError.Success;
	}
	
	
}

