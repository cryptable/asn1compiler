lexer grammar asn1lexical;

// ITU 680

// Chapter 11
CAPITAL: [A-Z] ;
SMALL: [a-z] ;
DIGIT: [0-9] ;
EXCLAMATION: '!' ;
QUOTATION: '"' ;
AMPERSAND: '&' ;
APOSTROPHE: '\'' ;
LEFT_PARENTHESIS: '(' ;
RIGHT_PARENTHESIS: ')' ;
ASTERISK: '*' ;
COMMA: ',' ;
HYPHEN_MINUS: '-' ;
FULL_STOP: '.' ;
SOLIDUS: '/' ;
COLON: ':' ;
SEMICOLON: ';' ;
LESS_THAN_SIGN: '<' ;
EQUALS_SIGN: '=' ;
GREATER_THAN_SIGN: '>' ;
COMMERCIAL_AT: '@' ;
LEFT_SQUARE_BRACKET: '[' ;
RIGHT_SQUARE_BRACKET: ']' ;
CIRCUMFLEX_ACCENT: '^' ;
LOW_LINE: '_' ;
LEFT_CURLY_BRACKET: '{' ;
VERTICAL_LINE: '|' ;
RIGHT_CURLY_BRACKET: '}' ;

ASN_CHARACTER_SET
    : CAPITAL
    | SMALL
    | DIGIT
    | EXCLAMATION
    | QUOTATION
    | AMPERSAND
    | APOSTROPHE
    | LEFT_PARENTHESIS
    | RIGHT_PARENTHESIS
    | ASTERISK
    | COMMA
    | HYPHEN_MINUS
    | FULL_STOP
    | SOLIDUS
    | COLON
    | SEMICOLON
    | LESS_THAN_SIGN
    | EQUALS_SIGN
    | GREATER_THAN_SIGN
    | COMMERCIAL_AT
    | LEFT_SQUARE_BRACKET
    | RIGHT_SQUARE_BRACKET
    | CIRCUMFLEX_ACCENT
    | LOW_LINE
    | LEFT_CURLY_BRACKET
    | VERTICAL_LINE
    | RIGHT_CURLY_BRACKET ;

LETTER: CAPITAL | SMALL ;
ALPHANUMERIC: [a-zA-Z0-9] ;
NONZERO: [1-9] ;
BIT: [01] ;
HEX: [0-9A-F] ;
XMLHEX: [0-9A-Fa-f] ;

// chapter 12.1 General Rules
WS : [\t\n\0x11\0x12\r ] ;
NEWLINE: [\n\0x11\0x12\r] ;

// chapter 12.2 Type references
TYPEREFERENCE: CAPITAL (ALPHANUMERIC | '-' ALPHANUMERIC)* ;

// chapter 12.3 Identifiers
IDENTIFIER: SMALL (ALPHANUMERIC | '-' ALPHANUMERIC)* ;

// chapter 12.4 Value references
VALUEREFERENCE: IDENTIFIER ;

// chapter 12.5 Module references
MODULEREFERENCE: TYPEREFERENCE ;

// chapter 12.6 Comments
COMMENT: '--' [ASN_CHARACTER_SET | WS]* NEWLINE | '--' [ASN_CHARACTER_SET | WS]* '--' | '/*' [ASN_CHARACTER_SET | WS | NEWLINE ]* '*/' ;

// chapter 12.7 Empty
EMPTY: ;

// chapter 12.8 Numbers
NUMBER: DIGIT | NONZERO DIGIT*;

// chapter 12.9 Real numbers
REALNUMBER: NUMBER ('.' DIGIT*)? ('e'|'E' '-'? NUMBER)?;

// chapter 12.10 XML Binary string
BSTRING: BIT+ | '\'' BIT+ '\'B' ;

// chapter 12.11 XML Binary string
XMLBSTRING: BIT+ ;

// chapter 12.12 Hexadecimal string
HSTRING: HEX+ | '\'' HEX+ '\'H' ;

// chapter 12.13 XML hexadecimal string item
XMLHSTRING: XMLHEX+ ;

// chapter 12.14 Character strings
// TODO: extend further according to ISO/IEC 8824
// CSTRING: ('"' CSTRINGCHAR+ '"')+;

// chapter 12.15 XML character string item
XMLCHARACTER: [\x09\x10\x13\x0020-\xD7FF\xE000-\xFFFD\x010000-\x10FFFF] ;
XMLCHARCODES: '&#' NUMBER* ';' ;
XMLCHARHEXCODES: '&#x' XMLHEX* ';' ;
XMLCHARAMPCODES: '&amp;' | '&lt;' | '&gt;' ;
XMLCHARXMLCODES
	: '<nul/>' | '<soh/>' | '<stx/>' | '<etx/>' | '<eot/>' | '<enq/>' | '<ack/>' | '<bel/>' | '<bs/>'
	| '<vt/>' | '<ff/>' | '<so/>' | '<si/>' | '<dle/>' | '<dc1/>' | '<dc2/>' | '<dc3/>' | '<dc4/>' | '<nak/>'
	| '<syn/>' | '<etb/>' | '<can/>' | '<em/>' | '<sub/>' | '<esc/>' | '<is4/>' | '<is3/>' | '<is2/>' | '<is1/>' ;

XMLCSTRING: (XMLCHARACTER | XMLCHARCODES | XMLCHARHEXCODES | XMLCHARAMPCODES | XMLCHARXMLCODES)*;

// chapter 12.16 Simple string item
SIMPLESTRINGCODES: [\x32-\x7E] ;

SIMPLESTRING: '"' SIMPLESTRINGCODES+ '"' ;

// chapter 12.17 Time string item
TSTRINGCHARACTER: [0-9+-:.,/CDHMRPSTWYZ] ;

TSTRING: '"' TSTRINGCHARACTER+ '"' ;

// chapter 12.18 XML Time string item
XMLTSTRING: TSTRINGCHARACTER+ ;

// chapter 12.19 property and settings name lexical item
PSNAME: CAPITAL (ALPHANUMERIC | '-' ALPHANUMERIC)* ;

// chapter 12.25 encoding references
ENCODINGREFERENCE: TYPEREFERENCE ;

// chapter 12.26 Integer-valued Unicode labels ;
INTEGERUNICODELABEL: NUMBER ;

// chapter 12.27 Non-integer Unicode labels ;
UNICODENONINTEGER
	: [-._~0-9A-Za-z]
	| [\x000000A0-\x0000DFFE]
	| [\x0000F900-\x0000FDCF]
	| [\x0000FDF0-\x0000FFEF]
	| [\x000000A0-\x0000DFFE]
	| [\x0000F900-\x0000FDCF]
	| [\x0000FDF0-\x0000FFEF]
	| [\x00010000-\x0001FFFD]
	| [\x00020000-\x0002FFFD]
	| [\x00030000-\x0003FFFD]
	| [\x00040000-\x0004FFFD]
	| [\x00050000-\x0005FFFD]
	| [\x00060000-\x0006FFFD]
	| [\x00070000-\x0007FFFD]
	| [\x00080000-\x0008FFFD]
	| [\x00090000-\x0009FFFD]
	| [\x000A0000-\x000AFFFD]
	| [\x000B0000-\x000BFFFD]
	| [\x000C0000-\x000CFFFD]
	| [\x000D0000-\x000DFFFD]
	| [\x000E1000-\x000EFFFD] ;

NONINTEGERUNICODELABEL: UNICODENONINTEGER ;

// chapter 12.31 XML boolean extended-true item
EXTENDED_TRUE: 'true' | '1' ;

// chapter 12.33 XML boolean extended-false item
EXTENDED_FALSE: 'false' | '0' ;

// chapter 12.38
RESERVED
	: 'ABSENT' | 'ENCODED' | 'INTERSECTION' | 'SEQUENCE' | 'ABSTRACT-SYNTAX' | 'ENCODING-CONTROL' | 'ISO646String SET'
	| 'ALL' | 'END' | 'MAX' | 'SETTINGS' | 'APPLICATION' | 'ENUMERATED' | 'MIN' | 'SIZE'
	| 'AUTOMATIC' 'EXCEPT' 'MINUS-INFINITY' 'STRING'
	| 'BEGIN' | 'EXPLICIT' | 'NOT-A-NUMBER' | 'SYNTAX'
	| 'BIT' | 'EXPORTS' | 'NULL' | 'T61String'
	| 'BMPString' | 'EXTENSIBILITY' | 'NumericString' | 'TAGS'
	| 'BOOLEAN' | 'EXTERNAL' | 'OBJECT' | 'TeletexString'
	| 'BY' | 'FALSE' | 'ObjectDescriptor' | 'TIME'
	| 'CHARACTER' | 'FROM' | 'OCTET' | 'TIME-OF-DAY'
	| 'CHOICE' | 'GeneralizedTime' | 'OF' | 'TRUE'
	| 'CLASS' | 'GeneralString' | 'OID-IRI' | 'TYPE-IDENTIFIER'
	| 'COMPONENT' | 'GraphicString' | 'OPTIONAL' | 'UNION'
	| 'COMPONENTS' | 'IA5String' | 'PATTERN' | 'UNIQUE'
	| 'CONSTRAINED' | 'IDENTIFIER' | 'PDV' | 'UNIVERSAL'
	| 'CONTAINING' | 'IMPLICIT' | 'PLUS-INFINITY' | 'UniversalString'
	| 'DATE' | 'IMPLIED' | 'PRESENT' | 'UTCTime'
	| 'DATE-TIME' | 'IMPORTS' | 'PrintableString' | 'UTF8String'
	| 'DEFAULT' | 'INCLUDES' | 'PRIVATE' | 'VideotexString'
	| 'DEFINITIONS' | 'INSTANCE' | 'REAL' | 'VisibleString'
	| 'DURATION' | 'INSTRUCTIONS' | 'RELATIVE-OID' | 'WITH'
	| 'EMBEDDED' | 'INTEGER' | 'RELATIVE-OID-IRI' ;

XMLASN1TYPENAME
	: 'BIT_STRING' | 'BOOLEAN' | 'CHOICE' | 'DATE'
	| 'DATE_TIME' | 'DURATION' | 'SEQUENCE' | 'ENUMERATED'
	| 'INTEGER' | 'OID_IRI' | 'NULL' | 'OCTET_STRING'
	| 'REAL' | 'RELATIVE_OID_IRI' | 'RELATIVE_OID' | 'SEQUENCE_OF'
	| 'SET' | 'SET_OF' | 'TIME' | 'TIME_OF_DAY' ;
