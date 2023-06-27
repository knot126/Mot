/*
 * Generic lexer utilites
 * 
 * @comment knot126 Working on this first becuase I think it should be very
 * useful and it makes a good starting task as it's not too complex.
 */

enum LexerType {
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

enum LexerErrorType {
	Unknown,
	UnexpectedCharacter,
	UnexpectedEndOfFile,
}

union LexerValue {
	long asInteger;
	double asRational;
	string asString;
}

struct LexerToken {
	LexerType type;
	LexerValue value;
	size_t location;
}

struct LexerError {
	LexerErrorType type;
	string desc;
}

struct LexerResult {
	LexerToken[] tokens;
	LexerError[] errors;
}

LexerResult GenericLexerProcessString(string data) {
	/*
	 * Parse a generic string to a series of sensible tokens. This should be
	 * fairly language independent.
	 * 
	 * @param data The data to tokenise
	 */
	
	
}
