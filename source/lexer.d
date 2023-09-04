/*
 * Generic lexer utilites
 * 
 * @comment knot126 Working on this first becuase I think it should be very
 * useful and it makes a good starting task as it's not too complex.
 */

import std.stdio;
import std.conv;
import log;

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
	PerCent,
	Caret,
	Ampersand,
	Asterisk,
	Plus,
	Minus,
	Tilde,
	Chip,
	Pipe,
	Comma,
	FullStop,
	Question,
	Equal,
	
	/* Common two-char operators */
	EqualEqual,
	BangEqual,
	PlusEqual,
	MinusEqual,
	AsteriskEqual,
	PerCentEqual,
	DollarEqual,
	CaretEqual,
	TildeEqual,
	PipeEqual,
	AmpersandEqual,
	PipePipe,
	AmpersandAmpersand,
	OpenPointyBracketEqual,
	ClosePointyBracketEqual,
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
	void *asPtr;
}

struct MTLexerToken {
	MTLexerType type;
	MTLexerValue value;
	size_t location;
	
	this(MTLexerType type, MTLexerValue value, size_t location) {
		this.type = type;
		this.value = value;
		this.location = location;
	}
	
	void print() {
		write("\t", this.location, ":\t", this.type);
		
		switch (this.type) {
			case MTLexerType.Symbol: writeln(":\t", this.value.asString); break;
			case MTLexerType.String: writeln(":\t", this.value.asString); break;
			case MTLexerType.Integer: writeln(":\t", this.value.asInteger); break;
			case MTLexerType.Rational: writeln(":\t", this.value.asRational); break;
			default: writeln(); break;
		}
	}
}

struct MTLexerError {
	MTLexerErrorType type;
	size_t location;
	string desc;
	
	this(MTLexerErrorType type, size_t location, string desc) {
		this.type = type;
		this.location = location;
		this.desc = desc;
	}
}

struct MTLexerResult {
	MTLexerToken[] tokens;
	MTLexerError[] errors;
	
	void addToken(MTLexerToken token) {
		this.tokens.length += 1;
		this.tokens[$ - 1] = token;
	}
	
	void addSimpleToken(ref MTLexer lexer, MTLexerType type) {
		this.addToken(MTLexerToken(type, MTLexerValue(), lexer.tell()));
		lexer.next();
	}
	
	void addError(MTLexerError error) {
		this.errors.length += 1;
		this.errors[$ - 1] = error;
	}
	
	bool hadErrors() {
		return this.errors.length > 0;
	}
	
	void print() {
		for (size_t i = 0; i < tokens.length; i++) {
			tokens[i].print();
		}
	}
}

struct MTLexer {
	string data;
	int head;
	
	this(string data) {
		this.data = data;
		this.head = 0;
	}
	
	char at(int where) {
		return this.data[where];
	}
	
	char peek(int which = 0) {
		return this.at(this.head + which);
	}
	
	char next() {
		return this.at(this.head++);
	}
	
	string sub(int until) {
		return this.data[this.head .. (this.head + until)];
	}
	
	bool done() {
		return this.head >= this.data.length;
	}
	
	int tell() {
		return this.head;
	}
}

bool MTLexerSymbolIsDigit(char symbol) {
	return (symbol >= '0') && (symbol <= '9');
}

bool MTLexerSymbolIsLowercaseBasicLatin(char symbol) {
	return (symbol >= 'a') && (symbol <= 'z');
}

bool MTLexerSymbolIsUppercaseBasicLatin(char symbol) {
	return (symbol >= 'A') && (symbol <= 'Z');
}

bool MTLexerSymbolIsBasicLatin(char symbol) {
	return MTLexerSymbolIsLowercaseBasicLatin(symbol) || MTLexerSymbolIsUppercaseBasicLatin(symbol);
}

bool MTLexerSymbolIsRadixPoint(char symbol) {
	return symbol == '.';
}

bool MTLexerSymbolIsValidStartingIdentifier(char symbol) {
	return MTLexerSymbolIsBasicLatin(symbol) || symbol == '_';
}

bool MTLexerSymbolIsValidMidOrEndIdentifier(char symbol) {
	return MTLexerSymbolIsValidStartingIdentifier(symbol) || MTLexerSymbolIsDigit(symbol);
}

bool MTLexerSymbolIsWhitespace(char symbol) {
	return (symbol == ' ' || symbol == '\t' || symbol == '\n' || symbol == '\r');
}

MTLexerResult MTGenericLexerProcessString(string data) {
	/*
	 * Parse a generic string to a series of sensible tokens. This should be
	 * fairly language independent.
	 * 
	 * @param data The data to tokenise
	 */
	
	MTLexerResult result = MTLexerResult();
	MTLexer lexer = MTLexer(data);
	
	while (!lexer.done()) {
		char next = lexer.peek();
		
		writeln("Processing char '", next, "' at pos ", lexer.tell());
		
		switch (next) {
			case '\\': {
				result.addSimpleToken(lexer, MTLexerType.BackSlash); break;
			}
			case '/': {
				next = lexer.peek(1); // Next next char
				
				switch (next) {
					case '/': // Single line comment, starting with //
						while (lexer.peek() != '\n') {
							lexer.next();
						}
						break;
					
					default: // Just a normal slash
						result.addSimpleToken(lexer, MTLexerType.ForwardSlash);
						break;
				}
				
				break;
			}
			case '(': {
				result.addSimpleToken(lexer, MTLexerType.OpenBracket); break;
			}
			case ')': {
				result.addSimpleToken(lexer, MTLexerType.CloseBracket); break;
			}
			case '[': {
				result.addSimpleToken(lexer, MTLexerType.OpenSquareBracket); break;
			}
			case ']': {
				result.addSimpleToken(lexer, MTLexerType.CloseSquareBarcket); break;
			}
			case '{': {
				result.addSimpleToken(lexer, MTLexerType.OpenCurlyBracket); break;
			}
			case '}': {
				result.addSimpleToken(lexer, MTLexerType.CloseCurlyBracket); break;
			}
			case '<': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // ==
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.OpenPointyBracketEqual);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.OpenPointyBracket);
						break;
				}
				
				break;
			}
			case '>': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // ==
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.ClosePointyBracketEqual);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.ClosePointyBracket);
						break;
				}
				
				break;
			}
			case ':': {
				result.addSimpleToken(lexer, MTLexerType.Colon); break;
			}
			case ';': {
				result.addSimpleToken(lexer, MTLexerType.SemiColon); break;
			}
			case '!': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // !=
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.BangEqual);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.Bang);
						break;
				}
				
				break;
			}
			case '@': {
				result.addSimpleToken(lexer, MTLexerType.At); break;
			}
			case '#': {
				result.addSimpleToken(lexer, MTLexerType.Hash); break;
			}
			case '$': {
				result.addSimpleToken(lexer, MTLexerType.Dollar); break;
			}
			case '%': {
				result.addSimpleToken(lexer, MTLexerType.PerCent); break;
			}
			case '^': {
				result.addSimpleToken(lexer, MTLexerType.Caret); break;
			}
			case '&': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // ==
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.AmpersandEqual);
						break;
					
					case '&': // ==
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.AmpersandAmpersand);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.Ampersand);
						break;
				}
				
				break;
			}
			case '*': {
				result.addSimpleToken(lexer, MTLexerType.Asterisk); break;
			}
			case '+': {
				result.addSimpleToken(lexer, MTLexerType.Plus); break;
			}
			case '-': {
				result.addSimpleToken(lexer, MTLexerType.Minus); break;
			}
			case '~': {
				result.addSimpleToken(lexer, MTLexerType.Tilde); break;
			}
			case '`': {
				result.addSimpleToken(lexer, MTLexerType.Chip); break;
			}
			case '|': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // |=
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.PipeEqual);
						break;
					
					case '|': // ||
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.PipePipe);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.Pipe);
						break;
				}
				
				break;
			}
			case ',': {
				result.addSimpleToken(lexer, MTLexerType.Comma); break;
			}
			case '.': {
				result.addSimpleToken(lexer, MTLexerType.FullStop); break;
			}
			case '?': {
				result.addSimpleToken(lexer, MTLexerType.Question); break;
			}
			case '=': {
				next = lexer.peek(1); // Peek to the next next char
				
				switch (next) {
					case '=': // ==
						lexer.next();
						result.addSimpleToken(lexer, MTLexerType.EqualEqual);
						break;
					
					default: // Just an =
						result.addSimpleToken(lexer, MTLexerType.Equal);
						break;
				}
				
				break;
			}
			case ' ', '\t', '\n', '\r': {
				// Whitespace
				lexer.next();
				break;
			}
			default: {
				// Symbol
				if (MTLexerSymbolIsValidStartingIdentifier(next)) {
					string name = "";
					size_t position = lexer.tell();
					
					while (true) {
						// Add the current char
						name ~= lexer.next();
						
						// Check if we are now done
						if (lexer.done()) {
							break;
						}
						
						// Peek if not
						next = lexer.peek();
						
						// Check if this is still an identifier
						if (!MTLexerSymbolIsValidMidOrEndIdentifier(next)) {
							break;
						}
					}
					
					MTLexerValue value;
					value.asString = name;
					
					result.addToken(MTLexerToken(MTLexerType.Symbol, value, position));
				}
				// Hex number
				else if (next == '0' && lexer.peek(1) == 'x') {
					MTLog(MTLogLevel.Warning, "Don't know how to handle hex number yet");
				}
				// Digit
				else if (MTLexerSymbolIsDigit(next)) {
					string running_string = "";
					size_t position = lexer.tell();
					bool radix_seen = false;
					
					while (true) {
						running_string ~= lexer.next();
						
						if (lexer.done()) {
							break;
						}
						
						next = lexer.peek();
						
						if (!MTLexerSymbolIsDigit(next) && (!MTLexerSymbolIsRadixPoint(next) || radix_seen)) {
							break;
						}
						
						if (MTLexerSymbolIsRadixPoint(next)) {
							radix_seen = true;
						}
					}
					
					// Rational
					if (radix_seen) {
						MTLexerValue value;
						value.asRational = to!double(running_string);
						
						result.addToken(MTLexerToken(MTLexerType.Rational, value, position));
					}
					// Integer
					else {
						MTLexerValue value;
						value.asInteger = to!long(running_string);
						
						result.addToken(MTLexerToken(MTLexerType.Integer, value, position));
					}
				}
				else {
					// Don't know what to do
					result.addError(MTLexerError(MTLexerErrorType.UnexpectedCharacter, lexer.tell(), "Unknown character '" ~ next ~ "'"));
					lexer.next();
				}
				
				break;
			}
		}
	}
	
	return result;
}
