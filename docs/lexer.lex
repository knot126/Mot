Alphabet -> Σ
Letter -> ['a'-'z'] | ['A'-'Z']
Digit -> ['0'-'9']
LetterOrUnderscore -> Letter | '_'
Hexit -> ['0'-'9'] | ['a'-'f'] | ['A'-'F']
Bit -> '0' | '1'

Digits -> Digit+
DecimalPart -> '.' Digits
Base2Number -> '0b' Bit+
Base10Number -> Digits DecimalPart?
Base16Number -> '0x' Hexit+
Number -> Base2Number | Base10Number | Base16Number
String -> '"' (Alphabet ^ '"') '"'
Symbol -> LetterOrUnderscore (LetterOrUnderscore | Digit)*
