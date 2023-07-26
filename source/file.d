import std.stdio;

enum MTFileMode {
	Read = 1,
	Write = 2,
	ReadWrite = 3,
}

string[MTFileMode] gFileModes = [
	MTFileMode.Read: "rb",
	MTFileMode.Write: "wb",
	MTFileMode.ReadWrite: "a+",
];

struct MTFile {
	File f;
	
	this(string path, MTFileMode mode) {
		this.f = File();
		this.f.open(path, gFileModes[mode]);
	}
	
	byte readByte() {
		auto data = this.f.rawRead(new byte[1]);
		return data[0];
	}
	
	int readInt() {
		auto data = this.f.rawRead(new int[1]);
		return data[0];
	}
	
	uint readUInt() {
		auto data = this.f.rawRead(new uint[1]);
		return data[0];
	}
	
	long readLong() {
		auto data = this.f.rawRead(new long[1]);
		return data[0];
	}
	
	ulong readULong() {
		auto data = this.f.rawRead(new ulong[1]);
		return data[0];
	}
	
	void seek(int mode, long offset) {
		this.f.seek(offset, mode);
	}
}
