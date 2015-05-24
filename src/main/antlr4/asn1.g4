grammar ASN1;

ModuleDefinition: ModuleIdentifier
	  'DEFINITIONS'
	  EncodingReferenceDefault
	  TagDefault
	  ExtensionDefault
	  '::='
	  'BEGIN'
	  ModuleBody
	  EncodingControlSections
	  'END';

ModuleIdentifier: modulereference DefinitiveIdentification;

DefinitiveIdentification: DefinitiveOID | DefinitiveOIDandIRI | ;

DefinitiveOID: '{' DefinitiveObjIdComponentList '}';

DefinitiveOIDandIRI: DefinitiveOID IRIValue;

DefinitiveObjIdComponentList: (DefinitiveObjIdComponent)+ ;

DefinitiveObjIdComponent: NameForm | DefinitiveNumberForm | DefinitiveNameAndNumberForm;

DefinitiveNumberForm : number;

DefinitiveNameAndNumberForm: identifier '(' DefinitiveNumberForm ')';

EncodingReferenceDefault: encodingreference 'INSTRUCTIONS' | ;

TagDefault: 'EXPLICIT TAGS' | 'IMPLICIT TAGS' | 'AUTOMATIC TAGS' | ;

ExtensionDefault: 'EXTENSIBILITY IMPLIED' | ;

ModuleBody: Exports Imports AssignmentList | ;

Exports: 'EXPORTS' SymbolsExported ';' | 'EXPORTS ALL' ';' | ;

SymbolsExported: SymbolList | ;

Imports: 'IMPORTS' SymbolsImported ';' | ;

SymbolsImported: SymbolsFromModuleList | ;

SymbolsFromModuleList: (SymbolsFromModule)* ;

SymbolsFromModule: SymbolList 'FROM' GlobalModuleReference ;

GlobalModuleReference: modulereference AssignedIdentifier ;

AssignedIdentifier: ObjectIdentifierValue | DefinedValue | ;

SymbolList: Symbol (',' Symbol)* ;

Symbol: Reference | ParameterizedReference ;

Reference: typereference | valuereference | objectclassreference | objectreference | objectsetreference ;

AssignmentList: (Assignment)* ;

Assignment
	: TypeAssignment
	| ValueAssignment
	| XMLValueAssignment
	| ValueSetTypeAssignment
	| ObjectClassAssignment
	| ObjectAssignment
	| ObjectSetAssignment
	| ParameterizedAssignment ;

TypeAssignment: typereference '::=' Type ;

ValueAssignment: valuereference Type '::=' Value ;

XMLValueAssignment: valuereference '::=' XMLTypeValue ;

XMLTypeValue
	: '<' NonParameterizedTypeName '>' XMLValue '</' NonParameterizedTypeName '>'
	| '<' NonParameterizedTypeName '/>' ;

ValueSetTypeAssignment: typereference Type '::=' ValueSet ;

ValueSet: '{' ElementSetSpecs '}' ;

Type: BuiltinType | ReferencedType | ConstrainedType ;

BuiltinType
    : BitStringType
	| BooleanType
	| CharacterStringType
	| ChoiceType
	| DateType
	| DateTimeType
	| DurationType
	| EmbeddedPDVType
	| EnumeratedType
	| ExternalType
	| InstanceOfType
	| IntegerType
	| IRIType
	| NullType
	| ObjectClassFieldType
	| ObjectIdentifierType
	| OctetStringType
	| RealType
	| RelativeIRIType
	| RelativeOIDType
	| SequenceType
	| SequenceOfType
	| SetType
	| SetOfType
	| PrefixedType
	| TimeType
	| TimeOfDayType ;

ReferencedType
	: DefinedType
	| UsefulType
	| SelectionType
	| TypeFromObject
	| ValueSetFromObjects ;

NamedType: identifier Type ;

Value
	: BuiltinValue
	| ReferencedValue
	| ObjectClassFieldValue ;

XMLValue
	: XMLBuiltinValue
	| XMLObjectClassFieldValue ;

BuiltinValue
	: BitStringValue
	| BooleanValue
	| CharacterStringValue
	| ChoiceValue
	| EmbeddedPDVValue
	| EnumeratedValue
	| ExternalValue
	| InstanceOfValue
	| IntegerValue
	| IRIValue
	| NullValue
	| ObjectIdentifierValue
	| OctetStringValue
	| RealValue
	| RelativeIRIValue
	| RelativeOIDValue
	| SequenceValue
	| SequenceOfValue
	| SetValue
	| SetOfValue
	| PrefixedValue
	| TimeValue ;

XMLBuiltinValue
	: XMLBitStringValue
	| XMLBooleanValue
	| XMLCharacterStringValue
	| XMLChoiceValue
	| XMLEmbeddedPDVValue
	| XMLEnumeratedValue
	| XMLExternalValue
	| XMLInstanceOfValue
	| XMLIntegerValue
	| XMLIRIValue
	| XMLNullValue
	| XMLObjectIdentifierValue
	| XMLOctetStringValue
	| XMLRealValue
	| XMLRelativeIRIValue
	| XMLRelativeOIDValue
	| XMLSequenceValue
	| XMLSequenceOfValue
	| XMLSetValue
	| XMLSetOfValue
	| XMLPrefixedValue
	| XMLTimeValue ;

ReferencedValue
	: DefinedValue
	| ValueFromObject ;

NamedValue: identifier Value ;
XMLNamedValue: '<' identifier '>' XMLValue '</' identifier '>' ;

/** Boolean value */
BooleanType: 'BOOLEAN' ;
BooleanValue: 'TRUE' | 'FALSE' ;

XMLBooleanValue
	: EmptyElementBoolean
	| TextBoolean ;
EmptyElementBoolean
	: '<' 'true' '/>'
	| '<' 'false' '/>' ;
TextBoolean
	: extended_true
	| extended_false ;

/** Integer type */
IntegerType
	: INTEGER
	| INTEGER '{' NamedNumberList '}' ;

NamedNumberList: NamedNumber (',' NamedNumber)* ;

NamedNumber
	: identifier '(' SignedNumber ')'
	| identifier '(' DefinedValue ')' ;

SignedNumber: '-'? number ;

IntegerValue
	: SignedNumber
	| identifier ;

XMLIntegerValue
	: XMLSignedNumber
	| EmptyElementInteger
	| TextInteger ;

XMLSignedNumber: '-'? number;

EmptyElementInteger: '<' identifier '/>' ;

TextInteger: identifier ;

/** Enumeration Type */
EnumeratedType: ENUMERATED '{' Enumerations '}' ;

Enumerations
	: RootEnumeration
	| RootEnumeration ',' '...' ExceptionSpec
	| RootEnumeration ',' '...' ExceptionSpec ',' AdditionalEnumeration ;

RootEnumeration: Enumeration ;

AdditionalEnumeration: Enumeration ;

Enumeration: EnumerationItem | (',' EnumerationItem)* ;

EnumerationItem: identifier | NamedNumber ;

EnumeratedValue: identifier ;

XMLEnumeratedValue: EmptyElementEnumerated | TextEnumerated ;

EmptyElementEnumerated: '<' identifier '/>' ;

TextEnumerated: identifier ;

/** Real Type */
RealType: 'REAL' ;

RealValue
	: NumericRealValue
	| SpecialRealValue ;

NumericRealValue
	: '-'? realnumber
	| SequenceValue ;

SpecialRealValue
	: 'PLUS-INFINITY'
	| 'MINUS-INFINITY'
	| 'NOT-A-NUMBER' ;

XMLRealValue: XMLNumericRealValue | XMLSpecialRealValue ;

XMLNumericRealValue: '-'? realnumber ;

XMLSpecialRealValue: EmptyElementReal | TextReal ;

EmptyElementReal
	: '<' 'PLUS-INFINITY' '/>'
	| '<' 'MINUS-INFINITY' '/>'
	| '<' 'NOT-A-NUMBER' '/>' ;

TextReal
	: '-'? 'INF'
	| 'NaN' ;

/** Bitstring type */
BitStringType: 'BIT STRING' | 'BIT STRING' '{' NamedBitList '}' ;

NamedBitList: NamedBit (',' NamedBit)* ;

NamedBit: identifier '(' number ')' | identifier '(' DefinedValue ')' ;

BitStringValue
	: bstring
	| hstring
	| '{' IdentifierList '}'
	| '{' '}'
	| 'CONTAINING' Value ;

IdentifierList: identifier (',' identifier)* ;

XMLBitStringValue: XMLTypedValue | xmlbstring | XMLIdentifierList | ;

XMLIdentifierList: EmptyElementList | TextList ;

EmptyElementList: ('<' identifier '/>')+ ;

TextList: (identifier)+ ;

/** Octet string */
OctetStringType: 'OCTET STRING' ;

OctetStringValue
	: bstring
	| hstring
	| 'CONTAINING' Value ;

XMLOctetStringValue: XMLTypedValue | xmlhstring ;

/** Null type */
NullType: 'NULL' ;

NullValue: 'NULL' ;

XMLNullValue: ;

/** Sequence type */
SequenceType
    : 'SEQUENCE' '{' '}'
    | 'SEQUENCE' '{' ExtensionAndException OptionalExtensionMarker '}'
    | 'SEQUENCE' '{' ComponentTypeLists '}' ;

ExtensionAndException: '...' | '...' ExceptionSpec ;

OptionalExtensionMarker: ',' '...' | ;

ComponentTypeLists
    : RootComponentTypeList
    | RootComponentTypeList ',' ExtensionAndException ExtensionAdditions OptionalExtensionMarker
    | RootComponentTypeList ',' ExtensionAndException ExtensionAdditions ExtensionEndMarker ',' RootComponentTypeList
    | ExtensionAndException ExtensionAdditions ExtensionEndMarker ',' RootComponentTypeList
    | ExtensionAndException ExtensionAdditions OptionalExtensionMarker ;

RootComponentTypeList: ComponentTypeList ;

ExtensionEndMarker: ',' ' ... ' ;

ExtensionAdditions: ',' ExtensionAdditionList | ;

ExtensionAdditionList: ExtensionAddition (',' ExtensionAddition)* ;

ExtensionAddition: ComponentType | ExtensionAdditionGroup ;

ExtensionAdditionGroup: '[[' VersionNumber ComponentTypeList ']]' ;

VersionNumber: number ':' | ;

ComponentTypeList: ComponentType (',' ComponentType)* ;

ComponentType: NamedType | NamedType 'OPTIONAL' | NamedType 'DEFAULT' Value | 'COMPONENTS OF' Type ;

SequenceValue: '{' ComponentValueList '}' | '{' '}' ;

ComponentValueList: NamedValue (',' NamedValue)* ;

XMLSequenceValue: XMLComponentValueList | ;

XMLComponentValueList: (XMLNamedValue)+ ;

SequenceOfType: 'SEQUENCE OF' Type | 'SEQUENCE OF' NamedType ;

SequenceOfValue: '{' ValueList '}' | '{' NamedValueList '}' | '{' '}' ;

ValueList: Value (',' Value)* ;

NamedValueList: NamedValue | (',' NamedValue)* ;

XMLSequenceOfValue: XMLValueList | XMLDelimitedItemList | ;

XMLValueList: (XMLValueOrEmpty)+ ;

XMLValueOrEmpty: XMLValue | '<' NonParameterizedTypeName '/>' ;

XMLDelimitedItemList : (XMLDelimitedItem)+ ;

XMLDelimitedItem
    : '<' NonParameterizedTypeName '>' XMLValue '</' NonParameterizedTypeName '>'
    | '<' identifier '>' XMLValue '</' identifier '>' ;

SetType
	: SET '{' '}'
	| SET '{' ExtensionAndException OptionalExtensionMarker '}'
	| SET '{' ComponentTypeLists '}' ;

SetValue
	: '{' ComponentValueList '}'
	| '{' '}' ;

XMLSetValue
	: XMLComponentValueList
	| ;

SetOfType
	: 'SET OF' Type
	| 'SET OF' NamedType ;

SetOfValue
	: '{' ValueList '}'
	| '{' NamedValueList '}'
	| '{' '}' ;

XMLSetOfValue
	: XMLValueList
	| XMLDelimitedItemList
	| ;

ChoiceType
	: 'CHOICE' '{' AlternativeTypeLists '}' ;

AlternativeTypeLists
	: RootAlternativeTypeList
	| RootAlternativeTypeList ',' ExtensionAndException ExtensionAdditionAlternatives OptionalExtensionMarker ;

RootAlternativeTypeList: AlternativeTypeList ;

ExtensionAdditionAlternatives: ',' ExtensionAdditionAlternativesList | ;

ExtensionAdditionAlternativesList: ExtensionAdditionAlternative (',' ExtensionAdditionAlternative)* ;

ExtensionAdditionAlternative
	: ExtensionAdditionAlternativesGroup
	| NamedType ;

ExtensionAdditionAlternativesGroup: '[[' VersionNumber AlternativeTypeList ']]' ;

AlternativeTypeList: NamedType (',' NamedType)* ;

ChoiceValue: identifier ':' Value ;

XMLChoiceValue: '<' identifier '>' XMLValue '</' identifier '>' ;

SelectionType : identifier '<' Type ;

PrefixedType : TaggedType | EncodingPrefixedType ;

PrefixedValue : Value ;

XMLPrefixedValue : XMLValue ;

EncodingPrefixedType: EncodingPrefix Type ;

EncodingPrefix : '[' EncodingReference EncodingInstruction ']' ;

TaggedType: Tag Type | Tag 'IMPLICIT' Type | Tag 'EXPLICIT' Type ;

Tag : '[' EncodingReference Class ClassNumber ']' ;

EncodingReference : encodingreference ':' | ;

ClassNumber: number | DefinedValue ;

Class
	: 'UNIVERSAL'
	| 'APPLICATION'
	| 'PRIVATE'
	| ;

EncodingPrefixedType: EncodingPrefix Type ;

EncodingPrefix : '[' EncodingReference EncodingInstruction ']' ;

ObjectIdentifierType : 'OBJECT IDENTIFIER' ;

ObjectIdentifierValue: '{' ObjIdComponentsList '}' | '{' DefinedValue ObjIdComponentsList '}' ;

ObjIdComponentsList: (ObjIdComponents)+;

ObjIdComponents: NameForm | NumberForm | NameAndNumberForm | DefinedValue ;

NameForm: identifier ;

NumberForm: number | DefinedValue ;

NameAndNumberForm: identifier '(' NumberForm ')' ;

XMLObjectIdentifierValue : XMLObjIdComponentList ;

XMLObjIdComponentList: XMLObjIdComponent | XMLObjIdComponent '.' XMLObjIdComponentList ;

XMLObjIdComponent: NameForm | XMLNumberForm | XMLNameAndNumberForm ;

XMLNumberForm: number ;

XMLNameAndNumberForm: identifier '(' XMLNumberForm ')' ;

RelativeOIDType: 'RELATIVE-OID' ;

RelativeOIDValue: '{' RelativeOIDComponentsList '}' ;

RelativeOIDComponentsList: (RelativeOIDComponents)+ ;

RelativeOIDComponents: NumberForm | NameAndNumberForm | DefinedValue ;

XMLRelativeOIDValue: XMLRelativeOIDComponentList ;

XMLRelativeOIDComponentList: XMLRelativeOIDComponent ('.' XMLRelativeOIDComponent)* ;

XMLRelativeOIDComponent: XMLNumberForm | XMLNameAndNumberForm ;

IRIType: 'OID-IRI' ;

IRIValue: '"' FirstArcIdentifier SubsequentArcIdentifier '"' ;

FirstArcIdentifier: '/' ArcIdentifier ;

SubsequentArcIdentifier : '/' ArcIdentifier SubsequentArcIdentifier | ;

ArcIdentifier: integerUnicodeLabel | nonintegerUnicodeLabel ;

XMLIRIValue: FirstArcIdentifier SubsequentArcIdentifier ;

RelativeIRIType: 'RELATIVE-OID-IRI' ;

RelativeIRIValue: '"' FirstRelativeArcIdentifier SubsequentArcIdentifier '"' ;

FirstRelativeArcIdentifier: ArcIdentifier ;

XMLRelativeIRIValue: FirstRelativeArcIdentifier SubsequentArcIdentifier ;

EmbeddedPDVType: 'EMBEDDED PDV' ;

EmbeddedPDVValue: SequenceValue ;

XMLEmbeddedPDVValue: XMLSequenceValue ;

ExternalType: 'EXTERNAL' ;

ExternalValue: SequenceValue ;

XMLExternalValue: XMLSequenceValue ;

TimeType: 'TIME' ;

TimeValue: tstring ;

XMLTimeValue: xmltstring ;

DateType: 'DATE' ;

TimeOfDayType: 'TIME-OF-DAY' ;

DateTimeType: 'DATE-TIME' ;

DurationType: 'DURATION' ;

CharacterStringType: RestrictedCharacterStringType | UnrestrictedCharacterStringType ;

CharacterStringValue: RestrictedCharacterStringValue | UnrestrictedCharacterStringValue ;

XMLCharacterStringValue : XMLRestrictedCharacterStringValue | XMLUnrestrictedCharacterStringValue ;

RestrictedCharacterStringType
	: 'BMPString'
	| 'GeneralString'
	| 'GraphicString'
	| 'IA5String'
	| 'ISO646String'
	| 'NumericString'
	| 'PrintableString'
	| 'TeletexString'
	| 'T61String'
	| 'UniversalString'
	| 'UTF8String'
	| 'VideotexString'
	| 'VisibleString' ;

RestrictedCharacterStringValue: cstring | CharacterStringList | Quadruple | Tuple ;

CharacterStringList: '{' CharSyms '}' ;

CharSyms: CharsDefn (',' CharsDefn)* ;

CharsDefn: cstring | Quadruple | Tuple | DefinedValue ;


Quadruple : '{' Group ',' Plane ',' Row ',' Cell '}' ;

Group: number ;

Plane: number ;

Row: number ;

Cell: number ;

Tuple : '{' TableColumn ',' TableRow '}' ;

TableColumn: number ;

TableRow: number ;

XMLRestrictedCharacterStringValue: xmlcstring ;

UnrestrictedCharacterStringType: 'CHARACTER STRING' ;

UnrestrictedCharacterStringValue: SequenceValue ;

XMLUnrestrictedCharacterStringValue: XMLSequenceValue ;

UsefulType: typereference ;


// Constrained types
ConstrainedType
	: Type Constraint
	| TypeWithConstraint ;

TypeWithConstraint
	: 'SET' Constraint 'OF' Type
	| 'SET' SizeConstraint 'OF' Type
	| 'SEQUENCE' Constraint 'OF' Type
	| 'SEQUENCE' SizeConstraint 'OF' Type
	| 'SET' Constraint 'OF' NamedType
	| 'SET' SizeConstraint 'OF' NamedType
	| 'SEQUENCE' Constraint 'OF' NamedType
	| 'SEQUENCE' SizeConstraint 'OF' NamedType ;

Constraint: '(' ConstraintSpec ExceptionSpec ')' ;

ConstraintSpec: SubtypeConstraint | GeneralConstraint ;

SubtypeConstraint: ElementSetSpecs ;
ElementSetSpecs
	: RootElementSetSpec
	| RootElementSetSpec ',' '...'
	| RootElementSetSpec ',' '...' ',' AdditionalElementSetSpec ;

RootElementSetSpec: ElementSetSpec ;

AdditionalElementSetSpec: ElementSetSpec ;

ElementSetSpec: Unions | 'ALL' Exclusions ;

Unions: Intersections | UElems UnionMark Intersections ;

UElems: Unions ;

Intersections: IntersectionElements | IElems IntersectionMark IntersectionElements ;

IElems: Intersections ;

IntersectionElements: Elements | Elems Exclusions ;

Elems: Elements ;

Exclusions: 'EXCEPT' Elements ;

UnionMark: '|' | 'UNION' ;

IntersectionMark: '^' | 'INTERSECTION' ;

Elements: SubtypeElements | ObjectSetElements | '(' ElementSetSpec ')' ;

SubtypeElements
	: SingleValue
	| ContainedSubtype
	| ValueRange
	| PermittedAlphabet
	| SizeConstraint
	| TypeConstraint
	| InnerTypeConstraints
	| PatternConstraint
	| PropertySettings
	| DurationRange
	| TimePointRange
	| RecurrenceRange ;

SingleValue: Value ;

ContainedSubtype: Includes Type ;

Includes: INCLUDES | ;

ValueRange: LowerEndpoint '..' UpperEndpoint ;

LowerEndpoint: LowerEndValue | LowerEndValue '<' ;

UpperEndpoint: UpperEndValue | '<' UpperEndValue ;

LowerEndValue: Value | 'MIN' ;

UpperEndValue: Value | 'MAX' ;

SizeConstraint: SIZE Constraint ;

TypeConstraint: Type ;

PermittedAlphabet: 'FROM' Constraint ;

InnerTypeConstraints: 'WITH COMPONENT' SingleTypeConstraint | 'WITH COMPONENTS' MultipleTypeConstraints ;

SingleTypeConstraint: Constraint ;

MultipleTypeConstraints: FullSpecification | PartialSpecification ;

FullSpecification: '{' TypeConstraints '}' ;

PartialSpecification: '{' '...' ',' TypeConstraints '}' ;

TypeConstraints: NamedConstraint (',' NamedConstraint)* ;

NamedConstraint: identifier ComponentConstraint ;

ComponentConstraint: ValueConstraint PresenceConstraint ;

ValueConstraint: Constraint | ;

PresenceConstraint: 'PRESENT' | 'ABSENT' | 'OPTIONAL' | ;

PatternConstraint: 'PATTERN' Value ;

PropertySettings: 'SETTINGS' simplestring ;

PropertySettingsList: (PropertyAndSettingPair)+ ;

PropertyAndSettingPair: PropertyName '=' SettingName ;

PropertyName: psname ;

SettingName: psname ;

DurationRange: ValueRange ;

TimePointRange: ValueRange ;

RecurrenceRange: ValueRange ;

ExceptionSpec: '!' ExceptionIdentification | ;

ExceptionIdentification: SignedNumber | DefinedValue | Type ':' Value ;

// Lexer
WhiteSpace : [\t\n\0x11\0x12\r ]+ ;
NewLine: [\n\0x11\0x12\r]+ ;
Letter: [a-zA-Z] ;
UpperCase: [A-Z] ;
LowerCase: [a-z] ;
AlphaNumeric: [a-zA-Z0-9] ;
Number: [0-9] ;
NonZero: [1-9] ;
Bit: [01] ;
Hex: [0-9A-F] ;
XMLHex: [0-9A-Fa-f] ;
CString1: ~["];

// chapter 12.2 Type references
typereference: UpperCase (AlphaNumeric | '-')* AlphaNumeric ;

// chapter 12.3 Identifiers
identifier: LowerCase (AlphaNumeric | '-')* AlphaNumeric ;

// chapter 12.4 Value references
valuereference: identifier ;

// chapter 12.5 Module references
modulereference: typereference ;

// chapter 12.6 Comments
comment: '--' ~NewLine* NewLine | '--' ~NewLine? '--' | '/*' .*? '*/' ;

// chapter 12.7 Empty
empty: ;

// chapter 12.8 Numbers
number: Number | NonZero Number*;

// chapter 12.9 Real numbers
realnumber: number ('.' number)?;

// chapter 12.10 XML Binary string
bstring: Bit+ | '\'' Bit+ '\'B' ;

// chapter 12.11 XML Binary string
xmlbstring: Bit+ ;

// chapter 12.12 Hexadecimal string
hstring: Hex+ | '\'' Hex+ '\'H' ;

// chapter 12.13 XML hexadecimal string item
xmlhstring: XMLHex+ ;

// chapter 12.14 Character strings
// TODO: extend further according to ISO/IEC 8824
cstring: ('"' CString+ '"')+;

// chapter 12.15 XML character string item
xmlcstring: ;

// objectclassreference
// objectreference
// objectsetreference
// encodingreference
// xmlbstring
// xmlhstring
// psname



// chapter 12.38
reserved
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