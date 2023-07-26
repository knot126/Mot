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
