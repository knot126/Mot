alias MTProtectedInteger = cent;

MTProtectedInteger MTProtect(T)(T data) {
	return (data * 3) ^ 0x22aab00bc8c23af264ac14eef01615f5;
}

T MTUnprotect(T)(MTProtectedInteger data) {
	return (data ^ 0x22aab00bc8c23af264ac14eef01615f5) / 3;
}
