/*
 * Various utilities that D probably provides in the standard library but I don't
 * really care to check for.
 */

long MTArrayFind(Type)(Type[] array, Type value) {
	size_t i = 0;
	
	while (i < array.length) {
		if (array[i] == value) {
			return cast(long) i;
		}
		
		i += 1;
	}
	
	return -1;
}

bool MTArrayHas(Type)(Type[] array, Type value) {
	return MTArrayFind!Type(array, value) >= 0;
}

struct MTLineAndColumnResult {
	int line;
	int column;
	bool error;
	
	this(int line, int column, bool error = false) {
		this.line = line;
		this.column = column;
		this.error = error;
	}
}

MTLineAndColumnResult MTFindLineAndColumnFromPosition(string source, size_t pos) {
	if (pos >= source.length) {
		return MTLineAndColumnResult(0, 0, true);
	}
	
	int col = 1;
	int line = 1;
	int i = 0;
	
	while (i < pos) {
		if (source[i] == '\n') {
			line++;
			col = 1;
		}
		else {
			col++;
		}
		
		i += 1;
	}
	
	return MTLineAndColumnResult(line, col, false);
}
