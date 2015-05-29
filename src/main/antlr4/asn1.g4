grammar asn1;

moduleDefinition: moduleIdentifier
	  'DEFINITIONS'
	  encodingReferenceDefault
	  TAGDEFAULT
	  EXTENSIONDEFAULT
	  '::='
	  'BEGIN'
	  moduleBody
	  encodingControlSections
	  'END';

moduleIdentifier: MODULEREFERENCE definitiveIdentification;

definitiveIdentification: definitiveOID | definitiveOIDandIRI | ;

definitiveOID: '{' definitiveObjIdComponentList '}';

definitiveOIDandIRI: definitiveOID iRIValue;

definitiveObjIdComponentList: (definitiveObjIdComponent)+ ;

definitiveObjIdComponent: nameForm | definitiveNumberForm | definitiveNameAndNumberForm;

definitiveNumberForm : NUMBER;

definitiveNameAndNumberForm: IDENTIFIER '(' definitiveNumberForm ')';

encodingReferenceDefault: ENCODINGREFERENCE 'INSTRUCTIONS' | ;

moduleBody: exports imports assignmentList | ;

exports: 'EXPORTS' symbolsExported ';' | 'EXPORTS ALL' ';' | ;

symbolsExported: symbolList | ;

imports: 'IMPORTS' symbolsImported ';' | ;

symbolsImported: symbolsFromModuleList | ;

symbolsFromModuleList: (symbolsFromModule)* ;

symbolsFromModule: symbolList 'FROM' globalModuleReference ;

globalModuleReference: MODULEREFERENCE assignedIdentifier ;

assignedIdentifier: objectIdentifierValue | definedValue | ;

symbolList: symbol (',' symbol)* ;

symbol: reference | parameterizedReference ;

reference: TYPEREFERENCE | VALUEREFERENCE | OBJECTCLASSREFERENCE | OBJECTREFERENCE | OBJECTSETREFERENCE ;

assignmentList: (assignment)* ;

assignment
	: typeAssignment
	| valueAssignment
	| xMLValueAssignment
	| valueSetTypeAssignment
	| objectClassAssignment
	| objectAssignment
	| objectSetAssignment
	| parameterizedAssignment ;

// Chapter 14 Referencing type and value definitions
definedType: externalTypeReference | TYPEREFERENCE | parameterizedType | parameterizedValueSetType ;

definedValue: externalValueReference | VALUEREFERENCE | parameterizedValue ;

nonParameterizedTypeName: externalTypeReference | TYPEREFERENCE | XMLASN1TYPENAME ;

externalTypeReference: MODULEREFERENCE '.' TYPEREFERENCE ;

externalValueReference: MODULEREFERENCE '.' VALUEREFERENCE ;

// Chapter 15

// Chapter 16
typeAssignment: TYPEREFERENCE '::=' type ;

valueAssignment: VALUEREFERENCE type '::=' value ;

xMLValueAssignment: VALUEREFERENCE '::=' xMLTypedValue ;

xMLTypedValue
	: '<' nonParameterizedTypeName '>' xMLValue '</' nonParameterizedTypeName '>'
	| '<' nonParameterizedTypeName '/>' ;

valueSetTypeAssignment: TYPEREFERENCE type '::=' valueSet ;

valueSet: '{' elementSetSpecs '}' ;

type: builtinType | referencedType | constrainedType ;

builtinType
    : bitStringType
	| booleanType
	| characterStringType
	| choiceType
	| dateType
	| dateTimeType
	| durationType
	| embeddedPDVType
	| enumeratedType
	| externalType
	| instanceOfType
	| integerType
	| iRIType
	| nullType
	| objectClassFieldType
	| objectIdentifierType
	| octetStringType
	| realType
	| relativeIRIType
	| relativeOIDType
	| sequenceType
	| sequenceOfType
	| setType
	| setOfType
	| prefixedType
	| timeType
	| timeOfDayType ;

referencedType
	: definedType
	| usefulType
	| selectionType
	| typeFromObject
	| valueSetFromObjects ;

namedType: IDENITIFIER type ;

value
	: builtinValue
	| referencedValue
	| objectClassFieldValue ;

xMLValue
	: xMLBuiltinValue
	| xMLObjectClassFieldValue ;

builtinValue
	: bitStringValue
	| booleanValue
	| characterStringValue
	| choiceValue
	| embeddedPDVValue
	| enumeratedValue
	| externalValue
	| instanceOfValue
	| integerValue
	| iRIValue
	| nullValue
	| objectIdentifierValue
	| octetStringValue
	| realValue
	| relativeIRIValue
	| relativeOIDValue
	| sequenceValue
	| sequenceOfValue
	| setValue
	| setOfValue
	| prefixedValue
	| timeValue ;

xMLBuiltinValue
	: xMLBitStringValue
	| xMLBooleanValue
	| xMLCharacterStringValue
	| xMLChoiceValue
	| xMLEmbeddedPDVValue
	| xMLEnumeratedValue
	| xMLExternalValue
	| xMLInstanceOfValue
	| xMLIntegerValue
	| xMLIRIValue
	| xMLNullValue
	| xMLObjectIdentifierValue
	| xMLOctetStringValue
	| xMLRealValue
	| xMLRelativeIRIValue
	| xMLRelativeOIDValue
	| xMLSequenceValue
	| xMLSequenceOfValue
	| xMLSetValue
	| xMLSetOfValue
	| xMLPrefixedValue
	| xMLTimeValue ;

referencedValue
	: definedValue
	| valueFromObject ;

namedValue: IDENITIFIER Value ;

xMLNamedValue: '<' IDENITIFIER '>' XMLValue '</' IDENITIFIER '>' ;

/** Boolean value */
booleanType: 'BOOLEAN' ;

booleanValue: 'TRUE' | 'FALSE' ;

xMLBooleanValue
	: emptyElementBoolean
	| textBoolean ;

emptyElementBoolean
	: '<' 'true' '/>'
	| '<' 'false' '/>' ;

textBoolean
	: EXTENDED_TRUE
	| EXTENDED_FALSE ;

/** Integer type */
integerType
	: INTEGER
	| INTEGER '{' NamedNumberList '}' ;

namedNumberList: namedNumber (',' namedNumber)* ;

namedNumber
	: IDENITIFIER '(' signedNumber ')'
	| IDENITIFIER '(' definedValue ')' ;

signedNumber: '-'? NUMBER ;

integerValue
	: signedNumber
	| IDENITIFIER ;

xMLIntegerValue
	: xMLSignedNumber
	| emptyElementInteger
	| textInteger ;

xMLSignedNumber: '-'? NUMBER;

emptyElementInteger: '<' IDENITIFIER '/>' ;

textInteger: IDENITIFIER ;

/** Enumeration Type */
enumeratedType: ENUMERATED '{' enumerations '}' ;

enumerations
	: rootEnumeration
	| rootEnumeration ',' '...' exceptionSpec
	| rootEnumeration ',' '...' exceptionSpec ',' additionalEnumeration ;

rootEnumeration: enumeration ;

additionalEnumeration: enumeration ;

enumeration: enumerationItem | (',' enumerationItem)* ;

enumerationItem: IDENITIFIER | namedNumber ;

enumeratedValue: IDENITIFIER ;

xMLEnumeratedValue: emptyElementEnumerated | textEnumerated ;

emptyElementEnumerated: '<' IDENITIFIER '/>' ;

textEnumerated: IDENITIFIER ;

/** Real Type */
realType: 'REAL' ;

realValue
	: numericRealValue
	| specialRealValue ;

numericRealValue
	: '-'? REALNUMBER
	| sequenceValue ;

specialRealValue
	: 'PLUS-INFINITY'
	| 'MINUS-INFINITY'
	| 'NOT-A-NUMBER' ;

xMLRealValue: xMLNumericRealValue | xMLSpecialRealValue ;

xMLNumericRealValue: '-'? REALNUMBER ;

xMLSpecialRealValue: emptyElementReal | textReal ;

emptyElementReal
	: '<' 'PLUS-INFINITY' '/>'
	| '<' 'MINUS-INFINITY' '/>'
	| '<' 'NOT-A-NUMBER' '/>' ;

textReal
	: '-'? 'INF'
	| 'NaN' ;

/** Bitstring type */
bitStringType: 'BIT STRING' | 'BIT STRING' '{' namedBitList '}' ;

namedBitList: namedBit (',' namedBit)* ;

namedBit: IDENITIFIER '(' NUMBER ')' | IDENITIFIER '(' definedValue ')' ;

bitStringValue
	: bstring
	| hstring
	| '{' identifierList '}'
	| '{' '}'
	| 'CONTAINING' value ;

identifierList: IDENITIFIER (',' IDENITIFIER)* ;

xMLBitStringValue: xMLTypedValue | xmlbstring | xMLIdentifierList | ;

xMLIdentifierList: emptyElementList | textList ;

emptyElementList: ('<' IDENITIFIER '/>')+ ;

textList: (IDENITIFIER)+ ;

/** Octet string */
octetStringType: 'OCTET STRING' ;

octetStringValue
	: bstring
	| hstring
	| 'CONTAINING' value ;

xMLOctetStringValue: xMLTypedValue | xmlhstring ;

/** Null type */
nullType: 'NULL' ;

nullValue: 'NULL' ;

xMLNullValue: ;

/** Sequence type */
sequenceType
    : 'SEQUENCE' '{' '}'
    | 'SEQUENCE' '{' extensionAndException optionalExtensionMarker '}'
    | 'SEQUENCE' '{' componentTypeLists '}' ;

extensionAndException: '...' | '...' exceptionSpec ;

optionalExtensionMarker: ',' '...' | ;

componentTypeLists
    : rootComponentTypeList
    | rootComponentTypeList ',' extensionAndException extensionAdditions optionalExtensionMarker
    | rootComponentTypeList ',' extensionAndException extensionAdditions extensionEndMarker ',' rootComponentTypeList
    | extensionAndException extensionAdditions extensionEndMarker ',' rootComponentTypeList
    | extensionAndException extensionAdditions optionalExtensionMarker ;

rootComponentTypeList: componentTypeList ;

extensionEndMarker: ',' ' ... ' ;

extensionAdditions: ',' extensionAdditionList | ;

extensionAdditionList: extensionAddition (',' extensionAddition)* ;

extensionAddition: componentType | extensionAdditionGroup ;

extensionAdditionGroup: '[[' versionNumber componentTypeList ']]' ;

versionNumber: NUMBER ':' | ;

componentTypeList: componentType (',' componentType)* ;

componentType: namedType | namedType 'OPTIONAL' | namedType 'DEFAULT' value | 'COMPONENTS OF' type ;

sequenceValue: '{' componentValueList '}' | '{' '}' ;

componentValueList: namedValue (',' namedValue)* ;

xMLSequenceValue: xMLComponentValueList | ;

xMLComponentValueList: (xMLNamedValue)+ ;

sequenceOfType: 'SEQUENCE OF' type | 'SEQUENCE OF' namedType ;

sequenceOfValue: '{' valueList '}' | '{' namedValueList '}' | '{' '}' ;

valueList: value (',' value)* ;

namedValueList: namedValue | (',' namedValue)* ;

xMLSequenceOfValue: xMLValueList | xMLDelimitedItemList | ;

xMLValueList: (xMLValueOrEmpty)+ ;

xMLValueOrEmpty: xMLValue | '<' nonParameterizedTypeName '/>' ;

xMLDelimitedItemList : (xMLDelimitedItem)+ ;

xMLDelimitedItem
    : '<' nonParameterizedTypeName '>' xMLValue '</' nonParameterizedTypeName '>'
    | '<' IDENITIFIER '>' xMLValue '</' IDENITIFIER '>' ;

setType
	: 'SET' '{' '}'
	| 'SET' '{' extensionAndException optionalExtensionMarker '}'
	| 'SET' '{' componentTypeLists '}' ;

setValue
	: '{' componentValueList '}'
	| '{' '}' ;

xMLSetValue
	: xMLComponentValueList
	| ;

setOfType
	: 'SET OF' type
	| 'SET OF' namedType ;

setOfValue
	: '{' valueList '}'
	| '{' namedValueList '}'
	| '{' '}' ;

xMLSetOfValue
	: xMLValueList
	| xMLDelimitedItemList
	| ;

choiceType
	: 'CHOICE' '{' alternativeTypeLists '}' ;

alternativeTypeLists
	: rootAlternativeTypeList
	| rootAlternativeTypeList ',' extensionAndException extensionAdditionAlternatives optionalExtensionMarker ;

rootAlternativeTypeList: alternativeTypeList ;

extensionAdditionAlternatives: ',' extensionAdditionAlternativesList | ;

extensionAdditionAlternativesList: extensionAdditionAlternative (',' extensionAdditionAlternative)* ;

extensionAdditionAlternative
	: extensionAdditionAlternativesGroup
	| namedType ;

extensionAdditionAlternativesGroup: '[[' versionNumber alternativeTypeList ']]' ;

alternativeTypeList: namedType (',' namedType)* ;

choiceValue: IDENITIFIER ':' value ;

xMLChoiceValue: '<' IDENITIFIER '>' xMLValue '</' IDENITIFIER '>' ;

selectionType : IDENITIFIER '<' type ;

prefixedType : taggedType | encodingPrefixedType ;

prefixedValue : value ;

xMLPrefixedValue : xMLValue ;

encodingPrefixedType: encodingPrefix Type ;

encodingPrefix : '[' encodingReference encodingInstruction ']' ;

taggedType: tag type | tag 'IMPLICIT' type | tag 'EXPLICIT' type ;

tag : '[' encodingReference class classNumber ']' ;

encodingReference : ENCODINGREFERENCE ':' | ;

classNumber: NUMBER | definedValue ;

class
	: 'UNIVERSAL'
	| 'APPLICATION'
	| 'PRIVATE'
	| ;

objectIdentifierType : 'OBJECT IDENTIFIER' ;

objectIdentifierValue: '{' objIdComponentsList '}' | '{' definedValue objIdComponentsList '}' ;

objIdComponentsList: (objIdComponents)+;

objIdComponents: nameForm | numberForm | nameAndNumberForm | definedValue ;

nameForm: IDENITIFIER ;

numberForm: NUMBER | definedValue ;

nameAndNumberForm: IDENITIFIER '(' numberForm ')' ;

xMLObjectIdentifierValue : xMLObjIdComponentList ;

xMLObjIdComponentList: xMLObjIdComponent | xMLObjIdComponent '.' xMLObjIdComponentList ;

xMLObjIdComponent: nameForm | xMLNumberForm | xMLNameAndNumberForm ;

xMLNumberForm: NUMBER ;

xMLNameAndNumberForm: IDENITIFIER '(' xMLNumberForm ')' ;

relativeOIDType: 'RELATIVE-OID' ;

relativeOIDValue: '{' relativeOIDComponentsList '}' ;

relativeOIDComponentsList: (relativeOIDComponents)+ ;

relativeOIDComponents: numberForm | nameAndNumberForm | definedValue ;

xMLRelativeOIDValue: xMLRelativeOIDComponentList ;

xMLRelativeOIDComponentList: xMLRelativeOIDComponent ('.' xMLRelativeOIDComponent)* ;

xMLRelativeOIDComponent: xMLNumberForm | xMLNameAndNumberForm ;

iRIType: 'OID-IRI' ;

iRIValue: '"' firstArcIdentifier subsequentArcIdentifier '"' ;

firstArcIdentifier: '/' arcIdentifier ;

subsequentArcIdentifier : '/' arcIdentifier subsequentArcIdentifier | ;

arcIdentifier: integerUnicodeLabel | nonintegerUnicodeLabel ;

xMLIRIValue: firstArcIdentifier subsequentArcIdentifier ;

relativeIRIType: 'RELATIVE-OID-IRI' ;

relativeIRIValue: '"' firstRelativeArcIdentifier subsequentArcIdentifier '"' ;

firstRelativeArcIdentifier: arcIdentifier ;

xMLRelativeIRIValue: firstRelativeArcIdentifier subsequentArcIdentifier ;

embeddedPDVType: 'EMBEDDED PDV' ;

embeddedPDVValue: sequenceValue ;

xMLEmbeddedPDVValue: xMLSequenceValue ;

externalType: 'EXTERNAL' ;

externalValue: sequenceValue ;

xMLExternalValue: xMLSequenceValue ;

timeType: 'TIME' ;

timeValue: TSTRING ;

xMLTimeValue: XMLTSTRING ;

dateType: 'DATE' ;

timeOfDayType: 'TIME-OF-DAY' ;

dateTimeType: 'DATE-TIME' ;

durationType: 'DURATION' ;

characterStringType: restrictedCharacterStringType | unrestrictedCharacterStringType ;

characterStringValue: restrictedCharacterStringValue | unrestrictedCharacterStringValue ;

xMLCharacterStringValue : xMLRestrictedCharacterStringValue | xMLUnrestrictedCharacterStringValue ;

restrictedCharacterStringType
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

restrictedCharacterStringValue: CSTRING | characterStringList | quadruple | tuple ;

characterStringList: '{' charSyms '}' ;

charSyms: charsDefn (',' charsDefn)* ;

charsDefn: CSTRING | quadruple | tuple | definedValue ;

quadruple : '{' group ',' plane ',' row ',' cell '}' ;

group: NUMBER ;

plane: NUMBER ;

row: NUMBER ;

cell: NUMBER ;

tuple : '{' tableColumn ',' tableRow '}' ;

tableColumn: NUMBER ;

tableRow: NUMBER ;

xMLRestrictedCharacterStringValue: XMLCSTRING ;

unrestrictedCharacterStringType: 'CHARACTER STRING' ;

unrestrictedCharacterStringValue: sequenceValue ;

xMLUnrestrictedCharacterStringValue: xMLSequenceValue ;

usefulType: TYPEREFERENCE ;


// Constrained types
constrainedType
	: type constraint
	| typeWithConstraint ;

typeWithConstraint
	: 'SET' constraint 'OF' type
	| 'SET' sizeConstraint 'OF' type
	| 'SEQUENCE' constraint 'OF' type
	| 'SEQUENCE' sizeConstraint 'OF' type
	| 'SET' constraint 'OF' namedType
	| 'SET' sizeConstraint 'OF' namedType
	| 'SEQUENCE' constraint 'OF' namedType
	| 'SEQUENCE' sizeConstraint 'OF' namedType ;

constraint: '(' constraintSpec exceptionSpec ')' ;

constraintSpec: subtypeConstraint | generalConstraint ;

subtypeConstraint: elementSetSpecs ;

elementSetSpecs
	: rootElementSetSpec
	| rootElementSetSpec ',' '...'
	| rootElementSetSpec ',' '...' ',' additionalElementSetSpec ;

rootElementSetSpec: elementSetSpec ;

additionalElementSetSpec: elementSetSpec ;

elementSetSpec: unions | 'ALL' exclusions ;

unions: intersections | uElems unionMark intersections ;

uElems: unions ;

intersections: intersectionElements | iElems intersectionMark intersectionElements ;

iElems: intersections ;

intersectionElements: elements | elems exclusions ;

elems: elements ;

exclusions: 'EXCEPT' elements ;

unionMark: '|' | 'UNION' ;

intersectionMark: '^' | 'INTERSECTION' ;

elements: subtypeElements | objectSetElements | '(' elementSetSpec ')' ;

subtypeElements
	: singleValue
	| containedSubtype
	| valueRange
	| permittedAlphabet
	| sizeConstraint
	| typeConstraint
	| innerTypeConstraints
	| patternConstraint
	| propertySettings
	| durationRange
	| timePointRange
	| recurrenceRange ;

singleValue: value ;

containedSubtype: includes type ;

includes: 'INCLUDES' | ;

valueRange: lowerEndpoint '..' upperEndpoint ;

lowerEndpoint: lowerEndValue | lowerEndValue '<' ;

upperEndpoint: upperEndValue | '<' upperEndValue ;

lowerEndValue: value | 'MIN' ;

upperEndValue: value | 'MAX' ;

sizeConstraint: 'SIZE' constraint ;

typeConstraint: type ;

permittedAlphabet: 'FROM' constraint ;

innerTypeConstraints: 'WITH COMPONENT' singleTypeConstraint | 'WITH COMPONENTS' multipleTypeConstraints ;

singleTypeConstraint: constraint ;

multipleTypeConstraints: fullSpecification | partialSpecification ;

fullSpecification: '{' typeConstraints '}' ;

partialSpecification: '{' '...' ',' typeConstraints '}' ;

typeConstraints: namedConstraint (',' namedConstraint)* ;

namedConstraint: IDENITIFIER componentConstraint ;

componentConstraint: valueConstraint presenceConstraint ;

valueConstraint: constraint | ;

presenceConstraint: 'PRESENT' | 'ABSENT' | 'OPTIONAL' | ;

patternConstraint: 'PATTERN' value ;

propertySettings: 'SETTINGS' SIMPLESTRING ;

propertySettingsList: (propertyAndSettingPair)+ ;

propertyAndSettingPair: propertyName '=' settingName ;

propertyName: PSNAME ;

settingName: PSNAME ;

durationRange: valueRange ;

timePointRange: valueRange ;

recurrenceRange: valueRange ;

exceptionSpec: '!' exceptionIdentification | ;

exceptionIdentification: signedNumber | definedValue | type ':' value ;

// ITU X.681
// Chapter 8 Referencing definitions
definedObjectClass: externalObjectClassReference | OBJECTCLASSREFERENCE | usefulObjectClassReference ;

definedObject: externalObjectReference | OBJECTREFERENCE ;

definedObjectSet: externalObjectSetReference | OBJECTSETREFERENCE ;

externalObjectClassReference: MODULEREFERENCE '.' OBJECTCLASSREFERENCE ;

externalObjectReference: MODULEREFERENCE '.' OBJECTREFERENCE ;

externalObjectSetReference: MODULEREFERENCE '.' OBJECTSETREFERENCE ;

usefulObjectClassReference: 'TYPE-IDENTIFIER' | 'ABSTRACT-SYNTAX' ;

// Chapter 9 Information object class definition and assignment
objectClassAssignment: OBJECTCLASSREFERENCE '::=' objectClass ;

objectClass: definedObjectClass | objectClassDefn | parameterizedObjectClass ;

objectClassDefn: 'CLASS' '{' fieldSpec (',' fieldSpec)* '}' withSyntaxSpec? ;

withSyntaxSpec: 'WITH SYNTAX' syntaxList ;

fieldSpec
	: typeFieldSpec
	| fixedTypeValueFieldSpec
	| variableTypeValueFieldSpec
	| fixedTypeValueSetFieldSpec
	| variableTypeValueSetFieldSpec
	| objectFieldSpec
	| objectSetFieldSpec ;

typeFieldSpec: TYPEFIELDREFERENCE typeOptionalitySpec? ;

typeOptionalitySpec: ('OPTIONAL' | 'DEFAULT') type ;

fixedTypeValueFieldSpec: VALUEFIELDREFERENCE type 'UNIQUE'? valueOptionalitySpec? ;

valueOptionalitySpec: ('OPTIONAL' | 'DEFAULT') value ;

variableTypeValueFieldSpec: VALUEFIELDREFERENCE fieldName valueOptionalitySpec? ;

fixedTypeValueSetFieldSpec: valuesetfieldreference type valueSetOptionalitySpec? ;

valueSetOptionalitySpec: ('OPTIONAL' | 'DEFAULT') valueSet ;

variableTypeValueSetFieldSpec: valuesetfieldreference fieldName valueSetOptionalitySpec? ;

objectFieldSpec: OBJECTFIELDREFERENCE definedObjectClass objectOptionalitySpec? ;

objectOptionalitySpec: ('OPTIONAL' | 'DEFAULT') Object ;

objectSetFieldSpec: OBJECTSETFIELDREFERENCE definedObjectClass objectSetOptionalitySpec? ;

objectSetOptionalitySpec: ('OPTIONAL' | 'DEFAULT') objectSet ;

primitiveFieldName
	: TYPEFIELDREFERENCE
	| VALUEFIELDREFERENCE
	| valuesetfieldreference
	| OBJECTFIELDREFERENCE
	| OBJECTSETFIELDREFERENCE ;

fieldName: primitiveFieldName ('.' primitiveFieldName)* ;

// chapter 10 Syntax List
syntaxList: '{' tokenOrGroupSpec (WS tokenOrGroupSpec)* '}' ;

tokenOrGroupSpec: requiredToken | optionalGroup ;

optionalGroup: '[' tokenOrGroupSpec (WS tokenOrGroupSpec)* ']' ;

requiredToken: literal | primitiveFieldName ;

literal: WORD | ',' ;

// Chapter 11 Information object definition and assignment
objectAssignment: OBJECTREFERENCE definedObjectClass '::=' object ;

object: definedObject | objectDefn | objectFromObject | parameterizedObject ;

objectDefn: defaultSyntax | definedSyntax ;

defaultSyntax: '{' fieldSetting (',' fieldSetting)* '}' ;

fieldSetting: primitiveFieldName setting ;

definedSyntax: '{' definedSyntaxToken (WS definedSyntaxToken)* '}' ;

definedSyntaxToken: literal | setting ;

setting: type | value | valueSet | object | objectSet ;

// Chapter 12 Information object set definition and assignment
objectSetAssignment: OBJECTSETREFERENCE definedObjectClass '::=' objectSet ;

objectSet: '{' objectSetSpec '}' ;

objectSetSpec
	: rootElementSetSpec
	| rootElementSetSpec ',' '...'
	| '...'
	| '...' ',' additionalElementSetSpec
	| rootElementSetSpec ',' '...' ',' additionalElementSetSpec ;

objectSetElements: object | definedObjectSet | objectSetFromObjects | parameterizedObjectSet ;

// Chapter 14 Notation for the object class field type
objectClassFieldType: definedObjectClass '.' fieldName ;

objectClassFieldValue: openTypeFieldVal | fixedTypeFieldVal ;

openTypeFieldVal: type ':' value ;

fixedTypeFieldVal: builtinValue | referencedValue ;

xMLObjectClassFieldValue: xMLOpenTypeFieldVal | xMLFixedTypeFieldVal ;

xMLOpenTypeFieldVal: xMLTypedValue | xmlhstring ;

xMLFixedTypeFieldVal: xMLBuiltinValue ;

// Chapter 15 Information from objects
informationFromObjects
	:valueFromObject
	| valueSetFromObjects
	| typeFromObject
	| objectFromObject
	| objectSetFromObjects ;

valueFromObject: referencedObjects '.' fieldName ;

valueSetFromObjects: referencedObjects '.' fieldName ;

typeFromObject: referencedObjects '.' fieldName ;

objectFromObject: referencedObjects '.' fieldName ;

objectSetFromObjects: referencedObjects '.' fieldName ;

referencedObjects
	: definedObject
	| parameterizedObject
	| definedObjectSet
	| parameterizedObjectSet ;

instanceOfType: 'INSTANCE OF' DefinedObjectClass ;

instanceOfValue: value ;

xMLInstanceOfValue: xMLValue ;

// Chapter 54 Encoding Control Sections
encodingControlSections : encodingControlSection (WS encodingControlSections)* ;

encodingControlSection: 'ENCODING-CONTROL' ENCODINGREFERENCE encodingInstructionAssignmentList ;

encodingInstructionAssignmentList: ENCODINGREFERENCE ;

encodingInstruction: encodingReference ;

// ITU X.682
generalConstraint: userDefinedConstraint | tableConstraint | contentsConstraint ;

contentsConstraint: type ;

// Chapter 9 User-defined constraints
userDefinedConstraint: 'CONSTRAINED BY' '{' userDefinedConstraintParameter (',' userDefinedConstraintParameter)* '}' ;

userDefinedConstraintParameter
	: governor ':' value
	| governor ':' object
	| definedObjectSet
	| type
	| definedObjectClass ;

// Chapter 10 Table constraints, including component relation constraints
tableConstraint: simpleTableConstraint | componentRelationConstraint ;

simpleTableConstraint: objectSet ;

componentRelationConstraint: '{' definedObjectSet '}' '{' atNotation (',' atNotation)* '}' ;

atNotation: '@' componentIdList | '@' '.' level componentIdList ;

level: '.' level | ;

componentIdList: IDENITIFIER ('.' IDENITIFIER)* ;

// ITU X.683
// Chapter 8 Parameterized assignments
parameterizedAssignment
	: parameterizedTypeAssignment
	| parameterizedValueAssignment
	| parameterizedValueSetTypeAssignment
	| parameterizedObjectClassAssignment
	| parameterizedObjectAssignment
	| parameterizedObjectSetAssignment ;

parameterizedTypeAssignment: TYPEREFERENCE parameterList '::=' type ;

parameterizedValueAssignment: VALUEREFERENCE parameterList type '::=' value ;

parameterizedValueSetTypeAssignment: TYPEREFERENCE parameterList type '::=' valueSet ;

parameterizedObjectClassAssignment: OBJECTCLASSREFERENCE parameterList '::=' objectClass ;

parameterizedObjectAssignment: OBJECTREFERENCE parameterList definedObjectClass '::=' object ;

parameterizedObjectSetAssignment: OBJECTSETREFERENCE parameterList definedObjectClass '::=' objectSet ;

parameterList: '{' parameter (',' parameter)* '}' ;

parameter: paramGovernor ':' (dummyReference | dummyReference) ;

paramGovernor: governor | dummyGovernor ;

governor: type | definedObjectClass ;

dummyGovernor: dummyReference ;

dummyReference: reference ;

// Chapter 9 Referencing parameterized definitions
parameterizedReference: reference | reference '{' '}' ;

parameterizedType: simpleDefinedType actualParameterList ;

simpleDefinedType: externalTypeReference | TYPEREFERENCE ;

parameterizedValue: simpleDefinedValue actualParameterList ;

simpleDefinedValue: externalValueReference | VALUEREFERENCE ;

parameterizedValueSetType: simpleDefinedType actualParameterList ;

parameterizedObjectClass: definedObjectClass actualParameterList ;

parameterizedObjectSet: definedObjectSet actualParameterList ;

parameterizedObject: definedObject actualParameterList ;

actualParameterList: '{' actualParameter (',' actualParameter)* '}' ;

actualParameter: type | value | valueSet | definedObjectClass | object | objectSet ;

// ITU 680
TAGDEFAULT: 'EXPLICIT TAGS' | 'IMPLICIT TAGS' | 'AUTOMATIC TAGS' | ;

EXTENSIONDEFAULT: 'EXTENSIBILITY IMPLIED' | ;

// Lexer
// -----


WS : [\t\n\0x11\0x12\r ] ;
NEWLINE: [\n\0x11\0x12\r] ;
LETTER: [a-zA-Z] ;
UPPERCASE: [A-Z] ;
LOWERCASE: [a-z] ;
ALPHANUMERIC: [a-zA-Z0-9] ;
WITHZERO: [0-9] ;
NONZERO: [1-9] ;
BIT: [01] ;
HEX: [0-9A-F] ;
XMLHEX: [0-9A-Fa-f] ;
CSTRINGCHAR: ~[\"] ;
XMLCHARACTER: [\x09\x10\x13\x0020-\xD7FF\xE000-\xFFFD\x010000-\x10FFFF] ;
XMLCHARCODES: '&#' Number* ';' ;
XMLCHARHEXCODES: '&#x' XMLHex* ';' ;
XMLCHARAMPCODES: '&amp;' | '&lt;' | '&gt;' ;
XMLCHARXMLCODES
	: '<nul/>' | '<soh/>' | '<stx/>' | '<etx/>' | '<eot/>' | '<enq/>' | '<ack/>' | '<bel/>' | '<bs/>'
	| '<vt/>' | '<ff/>' | '<so/>' | '<si/>' | '<dle/>' | '<dc1/>' | '<dc2/>' | '<dc3/>' | '<dc4/>' | '<nak/>'
	| '<syn/>' | '<etb/>' | '<can/>' | '<em/>' | '<sub/>' | '<esc/>' | '<is4/>' | '<is3/>' | '<is2/>' | '<is1/>' ;

SIMPLESTRINGCODES: [\x32-\x7E] ;

TSTRINGCHARACTER: [0-9+-:.,/CDHMRPSTWYZ] ;

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

// chapter 12.2 Type references
TYPEREFERENCE: UpperCase (AlphaNumeric | '-' AlphaNumeric)* ;

// chapter 12.3 Identifiers
IDENTIFIER: LowerCase (AlphaNumeric | '-' AlphaNumeric)* ;

// chapter 12.4 Value references
VALUEREFERENCE: IDENTIFIER ;

// chapter 12.5 Module references
MODULEREFERENCE: TYPEREFERENCE ;

// chapter 12.6 Comments
COMMENT: '--' ~NEWLINE* NEWLINE | '--' ~NEWLINE? '--' | '/*' .*? '*/' ;

// chapter 12.7 Empty
EMPTY: ;

// chapter 12.8 Numbers
NUMBER: WITHZERO | NONZERO WITHZERO*;

// chapter 12.9 Real numbers
REALNUMBER: NUMBER ('.' NUMBER*)?;

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
CSTRING: ('"' CSTRINGCHAR+ '"')+;

// chapter 12.15 XML character string item
XMLCSTRING: (XMLCHARACTER | XMLCHARCODES | XMLCHARHEXCODES | XMLCHARAMPCODES | XMLCHARXMLCODES)*;

// chapter 12.16 Simple string item
SIMPLESTRING: '"' SIMPLESTRINGCODES+ '"' ;

// chapter 12.17 Time string item
TSTRING: '"' TSTRINGCHARACTER+ '"' ;

// chapter 12.18 XML Time string item
XMLTSTRING: TSTRINGCHARACTER+ ;

// chapter 12.19 property and settings name lexical item
PSNAME: UPPERCASE (ALPHANUMERIC | '-' ALPHANUMERIC)* ;

// chapter 12.25 encoding references
ENCODINGREFERENCE: TYPEREFERENCE ;

// chapter 12.26 Integer-valued Unicode labels ;
INTEGERUNICODELABEL: NUMBER ;

// chapter 12.27 Non-integer Unicode labels ;
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

// ITU X.681
OBJECTCLASSREFERENCE: TYPEREFERENCE ;

OBJECTREFERENCE: VALUEREFERENCE ;

OBJECTSETREFERENCE: TYPEREFERENCE ;

TYPEFIELDREFERENCE: '&' TYPEREFERENCE ;

VALUEFIELDREFERENCE: '&' VALUEREFERENCE ;

VALUESETFIELDREFERENCE: '&' TYPEREFERENCE ;

OBJECTFIELDREFERENCE: '&' OBJECTREFERENCE ;

OBJECTSETFIELDREFERENCE: '&' OBJECTSETREFERENCE ;

WORD: TYPEREFERENCE ;



// TODO: value definition
// TODO: type definition


