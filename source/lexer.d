/*
 * Generic lexer utilites
 * 
 * @comment knot126 Working on this first becuase I think it should be very
 * useful and it makes a good starting task as it's not too complex.
 */

enum MTLexerType {
	Unknown,
	Symbol,
	String,
	Integer,
	Rational,
	
	/* Baseline */
	BackSlash,
	ForwardSlash,
	OpenBracket,
	CloseBracket,
	OpenSquareBracket,
	CloseSquareBarcket,
	OpenCurlyBracket,
	CloseCurlyBracket,
	OpenPointyBracket,
	ClosePointyBracket,
	Colon,
	SemiColon,
	Bang,
	At,
	Hash,
	Dollar,
	Percent,
	Caret,
	Ampersand,
	Astresk,
	Plus,
	Minus,
	Tilde,
	Chip,
	Pipe,
	Comma,
	Period,
	Question,
	Equal,
	
	/* Common two-char operators */
	EqualEqual,
	BangEqual,
	PlusEqual,
	MinusEqual,
	StarEqual,
	PercentEqual,
	DollarEqual,
	CaretEqual,
	TildeEqual,
	PipeEqual,
	AmpersandEqual,
	PipePipe,
	AmpersandAmpersand,
}

enum MTLexerErrorType {
	Unknown,
	UnexpectedCharacter,
	UnexpectedEndOfFile,
}

union MTLexerValue {
	long asInteger;
	double asRational;
	string asString;
}

struct MTLexerToken {
	MTLexerType type;
	MTLexerValue value;
	size_t location;
}

struct MTLexerError {
	MTLexerErrorType type;
	string desc;
}

struct MTLexerResult {
	MTLexerToken[] tokens;
	MTLexerError[] errors;
}

MTLexerResult MTGenericLexerProcessString(string data) {
	/*
	 * Parse a generic string to a series of sensible tokens. This should be
	 * fairly language independent.
	 * 
	 * @param data The data to tokenise
	 */
	
	MTLexerResult result;
	
	return result;
}
