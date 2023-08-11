/*
 * Maths and stuff
 * 
 * @comment knot126 Ramble! I have really loved maths my entire life ...
 * unforuntely a lot of things are still kind of "magic" to me. I do not nessicarially
 * take much time to learn maths at the moment. I always feel a bit disappointed
 * by that. I hope, one day, I will have the ability to sit and learn some maths
 * again like I did a year (or hell, two years ago now!).
 * 
 * The positive part is that when you program and you learn about theory you do
 * pick up things on the way which is helpful. At least I am not doing nothing. =3
 * 
 * @note I really don't want to use GLM. I just don't want to use someone else's
 * maths library. The end. And this isn't C++ where everything is in a namespace
 * for whatever goddamn reason.
 * 
 * @comment knot126 And to the person who commented on my stackoverflow
 * post about the broken camera matrix telling me to use GLM and then giving me
 * unexplained example code: you are a wonderful person for trying to help, and
 * really I would rather more people be like you and try to be helpful, but also
 * fuck you. Using external libraries is not learning how something works.
 */

struct MTVector2 {
	float x, y;
	
	this(float x, float y) {
		this.x = x;
		this.y = y;
	}
	
	MTVector2 opBinary(string s : "+")(MTVector2 other) {
		return MTVector2(this.x + other.x, this.y + other.y);
	}
	
	void opOpAssign(string op: "+")(MTVector2 rhs) {
		this = this + rhs;
	}
	
	MTVector2 opBinary(string s : "-")(MTVector2 other) {
		return MTVector2(this.x - other.x, this.y - other.y);
	}
	
	MTVector2 opBinary(string s : "*")(float scalar) {
		return MTVector2(scalar * this.x, scalar * this.y);
	}
	
	MTVector2 opBinaryRight(string s : "*")(float scalar) {
		return MTVector2(scalar * this.x, scalar * this.y);
	}
}

float dot(MTVector2 a, MTVector2 b) {
	/*
	 * Take the dot product of two 2D vectors
	 * 
	 * dot(a, b) = ||A|| * ||B|| * cos(AngleBetween(a, b))
	 */
	
	return a.x * b.x + a.y * b.y;
}

MTVector2 MTLerp(float t, MTVector2 a, MTVector2 b) {
	return ((1.0 - t) * a) + (t * b);
}

struct MTColour {
	float r, g, b, a;
	
	this(float r, float g, float b, float a = 1.0) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}
	
	MTColour opBinary(string s : "+")(MTColour other) {
		return MTColour(this.r + other.r, this.g + other.g, this.b + other.b, this.a + other.a);
	}
	
	MTColour opBinary(string s : "-")(MTColour other) {
		return MTColour(this.r - other.r, this.g - other.g, this.b - other.b, this.a - other.a);
	}
	
	MTColour opBinary(string s : "*")(float scalar) {
		return MTColour(scalar * this.r, scalar * this.g, scalar * this.b, scalar * this.a);
	}
	
	MTColour opBinaryRight(string s : "*")(float scalar) {
		return MTColour(scalar * this.r, scalar * this.g, scalar * this.b, scalar * this.a);
	}
	
	MTColour opBinary(string s : "*")(MTColour other) {
		return MTColour(this.r * other.r, this.g * other.g, this.b * other.b, this.a * other.a);
	}
	
	int toHex() {
		/*
		 * Get the hex colour that can be passed to raylib.
		 * Format: RRRRRRRR GGGGGGGG BBBBBBBB AAAAAAAA
		 */
		
		int r = (cast(int) (this.r * 255.0)) & 0xff;
		int g = (cast(int) (this.g * 255.0)) & 0xff;
		int b = (cast(int) (this.b * 255.0)) & 0xff;
		int a = (cast(int) (this.a * 255.0)) & 0xff;
		
		return (r << 24) | (g << 16) | (b << 8) | a;
	}
}

MTColour MTLerp(float t, MTColour a, MTColour b) {
	return ((1.0 - t) * a) + (t * b);
}
