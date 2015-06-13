grammar Asn1Parser;
import Asn1Lexical;

// Chapter 13 Module definition
moduleDefinition: moduleIdentifier
	  DEFINITIONS
	  encodingReferenceDefault
	  tagDefault
	  extensionDefault
	  ASSIGNMENT
	  BEGIN
	  moduleBody
	  encodingControlSections
	  END;

moduleIdentifier: modulereference definitiveIdentification;

definitiveIdentification: definitiveOID | definitiveOIDandIRI | ;

definitiveOID: LEFT_CURLY_BRACKET definitiveObjIdComponentList RIGHT_CURLY_BRACKET;

definitiveOIDandIRI: definitiveOID iRIValue ;

definitiveObjIdComponentList: (definitiveObjIdComponent)+ ;

definitiveObjIdComponent: nameForm | definitiveNumberForm | definitiveNameAndNumberForm ;

definitiveNumberForm : number ;

definitiveNameAndNumberForm: IDENTIFIER LEFT_PARENTHESIS definitiveNumberForm RIGHT_PARENTHESIS;

encodingReferenceDefault: ENCODINGREFERENCE INSTRUCTIONS | ;

tagDefault
	: EXPLICIT_TAGS
	| IMPLICIT_TAGS
	| AUTOMATIC_TAGS
	| ;

extensionDefault : EXTENSIBILITY_IMPLIED | ;

moduleBody: exports imports assignmentList | ;

exports: EXPORTS symbolsExported SEMICOLON | EXPORTS_ALL SEMICOLON | ;

symbolsExported: symbolList | ;

imports: IMPORTS symbolsImported SEMICOLON | ;

symbolsImported: symbolsFromModuleList | ;

symbolsFromModuleList: (symbolsFromModule)+ ;

symbolsFromModule: symbolList FROM globalModuleReference ;

globalModuleReference: modulereference assignedIdentifier ;

assignedIdentifier: objectIdentifierValue | definedValue | ;

symbolList: symbol (COMMA symbol)* ;

symbol: reference | parameterizedReference ;

reference: TYPEREFERENCE | valuereference | objectclassreference | objectreference | objectsetreference ;

assignmentList: (assignment)+ ;

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

definedValue: externalValueReference | valuereference | parameterizedValue ;

nonParameterizedTypeName: externalTypeReference | TYPEREFERENCE | XMLASN1TYPENAME ;

externalTypeReference: modulereference FULL_STOP TYPEREFERENCE ;

externalValueReference: modulereference FULL_STOP valuereference ;

// Chapter 15 Notation to support references to ASN.1 components
absoluteReference: AMPERSAND moduleIdentifier FULL_STOP itemSpec ;

itemSpec: TYPEREFERENCE | itemSpec FULL_STOP componentId ;

// itemId: itemSpec ;

componentId: IDENTIFIER | number | ASTERISK ;

// Chapter 16 Assigning types and values
typeAssignment: TYPEREFERENCE ASSIGNMENT type ;

valueAssignment: valuereference type ASSIGNMENT value ;

xMLValueAssignment: valuereference ASSIGNMENT xMLTypedValue ;

xMLTypedValue
	: LESS_THAN_SIGN nonParameterizedTypeName GREATER_THAN_SIGN xMLValue XML_ENDTAG nonParameterizedTypeName GREATER_THAN_SIGN
	| LESS_THAN_SIGN nonParameterizedTypeName XML_SINGLE_ENDTAG ;

valueSetTypeAssignment: TYPEREFERENCE type ASSIGNMENT valueSet ;

valueSet: (LEFT_CURLY_BRACKET | LEFT_PARENTHESIS) elementSetSpecs (RIGHT_CURLY_BRACKET | RIGHT_PARENTHESIS) ;

// Chapter 17 Definition of types and values
type: builtinType | referencedType | type constraint | typeWithConstraint ;

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
	| timeOfDayType
	| anyType ;

referencedType
	: definedType
	| usefulType
	| selectionType
	| typeFromObject
	| valueSetFromObjects ;

namedType: IDENTIFIER type ;

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
//	| instanceOfValue
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
//	| prefixedValue
	| timeValue ;

xMLBuiltinValue
	: xMLBitStringValue
//	| xMLBooleanValue
//	| xMLCharacterStringValue
//	| xMLChoiceValue
//	| xMLEmbeddedPDVValue
//	| xMLEnumeratedValue
//	| xMLExternalValue
/*	| xMLInstanceOfValue  */
//	| xMLIntegerValue
//	| xMLIRIValue
//	| xMLNullValue
//	| xMLObjectIdentifierValue
//	| xMLOctetStringValue
//	| xMLRealValue
//	| xMLRelativeIRIValue
//	| xMLRelativeOIDValue
//	| xMLSequenceValue
/*	| xMLSequenceOfValue */
//	| xMLSetValue
/*	| xMLSetOfValue */
/*	| xMLPrefixedValue */
	| xMLTimeValue ;

referencedValue
	: definedValue
	| valueFromObject ;

namedValue: IDENTIFIER value ;

xMLNamedValue: LESS_THAN_SIGN IDENTIFIER GREATER_THAN_SIGN xMLValue XML_ENDTAG IDENTIFIER GREATER_THAN_SIGN ;

// Chapter 18 Notation for the boolean type
booleanType: BOOLEAN ;

booleanValue: TRUE | FALSE ;

xMLBooleanValue
	: emptyElementBoolean
	| textBoolean ;

emptyElementBoolean
	: LESS_THAN_SIGN XML_TRUE XML_SINGLE_ENDTAG
	| LESS_THAN_SIGN XML_FALSE XML_SINGLE_ENDTAG ;

textBoolean
	: extended_true
	| extended_false ;

/** Integer type */
integerType
	: INTEGER 
	| INTEGER LEFT_CURLY_BRACKET namedNumberList RIGHT_CURLY_BRACKET ;

namedNumberList: namedNumber (COMMA namedNumber)* ;

namedNumber
	: IDENTIFIER LEFT_PARENTHESIS signedNumber RIGHT_PARENTHESIS
	| IDENTIFIER LEFT_PARENTHESIS definedValue RIGHT_PARENTHESIS ;

signedNumber: HYPHEN_MINUS? number ;

integerValue
	: signedNumber
	| IDENTIFIER ;

xMLIntegerValue
	: xMLSignedNumber
	| emptyElementInteger
	| textInteger ;

xMLSignedNumber: HYPHEN_MINUS?  number ;

emptyElementInteger: LESS_THAN_SIGN IDENTIFIER XML_SINGLE_ENDTAG ;

textInteger: IDENTIFIER ;

// Chapter 20 Notation for the enumerated type
enumeratedType: ENUMERATED LEFT_CURLY_BRACKET enumerations RIGHT_CURLY_BRACKET ;

enumerations
 	: rootEnumeration
	| rootEnumeration COMMA ELLIPSIS exceptionSpec
	| rootEnumeration COMMA ELLIPSIS exceptionSpec COMMA additionalEnumeration ;

rootEnumeration: enumeration ;

additionalEnumeration: enumeration ;

enumeration: enumerationItem (COMMA enumerationItem)* ;

enumerationItem: IDENTIFIER | namedNumber ;

enumeratedValue: IDENTIFIER ;

xMLEnumeratedValue: emptyElementEnumerated | textEnumerated ;

emptyElementEnumerated: LESS_THAN_SIGN IDENTIFIER XML_SINGLE_ENDTAG ;

textEnumerated: IDENTIFIER ;

// Chapter 21 Notation for the real type
realType: REAL ;

realValue
	: numericRealValue
	| specialRealValue ;

numericRealValue
	: HYPHEN_MINUS? realnumber
	| sequenceValue ;

specialRealValue
	: PLUS_INFINITY
	| MINUS_INFINITY
	| NOT_A_NUMBER ;

xMLRealValue: xMLNumericRealValue | xMLSpecialRealValue ;

xMLNumericRealValue: HYPHEN_MINUS? realnumber ;

xMLSpecialRealValue: emptyElementReal | textReal ;

emptyElementReal
	: LESS_THAN_SIGN PLUS_INFINITY XML_SINGLE_ENDTAG
	| LESS_THAN_SIGN MINUS_INFINITY XML_SINGLE_ENDTAG
	| LESS_THAN_SIGN NOT_A_NUMBER XML_SINGLE_ENDTAG ;

textReal
	: HYPHEN_MINUS? XML_INF
	| XML_NAN ;

// Chapter 22 Notation for the bitstring type
bitStringType: BIT_STRING | BIT_STRING LEFT_CURLY_BRACKET namedBitList RIGHT_CURLY_BRACKET ;

namedBitList: namedBit (COMMA namedBit)* ;

namedBit
	: IDENTIFIER LEFT_PARENTHESIS number RIGHT_PARENTHESIS
	| IDENTIFIER LEFT_PARENTHESIS definedValue RIGHT_PARENTHESIS ;

bitStringValue
	: bSTRING
	| hSTRING
	| LEFT_CURLY_BRACKET identifierList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET
	| CONTAINING value ;

identifierList: IDENTIFIER (COMMA IDENTIFIER)* ;

xMLBitStringValue: xMLTypedValue | xMLBSTRING | xMLIdentifierList ;

xMLIdentifierList: emptyElementList | textList ;

emptyElementList: (LESS_THAN_SIGN IDENTIFIER XML_SINGLE_ENDTAG)+ ;

textList: (IDENTIFIER)+ ;

// Chapter 23 Notation for the octetstring type
octetStringType: OCTET_STRING ;

octetStringValue
	: bSTRING
	| hSTRING
	| CONTAINING value ;

xMLOctetStringValue: xMLTypedValue | xMLHSTRING ;

// Chapter 24 Notation for the null type
nullType: NULL ;

nullValue: NULL ;

xMLNullValue: '' ;

// Chapter 25 Notation for sequence types
sequenceType
    : SEQUENCE LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET
    | SEQUENCE LEFT_CURLY_BRACKET extensionAndException optionalExtensionMarker RIGHT_CURLY_BRACKET
    | SEQUENCE LEFT_CURLY_BRACKET componentTypeLists RIGHT_CURLY_BRACKET ;

extensionAndException: ELLIPSIS | ELLIPSIS exceptionSpec ;

optionalExtensionMarker: COMMA ELLIPSIS | ;

componentTypeLists
    : rootComponentTypeList
    | rootComponentTypeList COMMA extensionAndException extensionAdditions optionalExtensionMarker
    | rootComponentTypeList COMMA extensionAndException extensionAdditions extensionEndMarker COMMA rootComponentTypeList
    | extensionAndException extensionAdditions extensionEndMarker COMMA rootComponentTypeList
    | extensionAndException extensionAdditions optionalExtensionMarker ;

rootComponentTypeList: componentTypeList ;

extensionEndMarker: COMMA ELLIPSIS ;

extensionAdditions: COMMA extensionAdditionList | ;

extensionAdditionList: extensionAddition (COMMA extensionAddition)* ;

extensionAddition: componentType | extensionAdditionGroup ;

extensionAdditionGroup: LEFT_VERSION_BRACKET versionNumber componentTypeList RIGHT_VERSION_BRACKET ;

versionNumber: number COLON | ;

componentTypeList: componentType (COMMA componentType)* ;

componentType: namedType | namedType OPTIONAL | namedType DEFAULT value | COMPONENTS_OF type ;

sequenceValue: LEFT_CURLY_BRACKET componentValueList RIGHT_CURLY_BRACKET | LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET ;

componentValueList: namedValue (COMMA namedValue)* ;

xMLSequenceValue: xMLComponentValueList | ;

xMLComponentValueList: (xMLNamedValue)+ ;

// Chapter 26 Notation for sequence-of types
sequenceOfType: SEQUENCE_OF type | SEQUENCE_OF namedType ;

sequenceOfValue
	: LEFT_CURLY_BRACKET valueList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET namedValueList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET ;

valueList: value (COMMA value)* ;

namedValueList: namedValue | (COMMA namedValue)* ;

xMLSequenceOfValue: xMLValueList | xMLDelimitedItemList | ;

xMLValueList: (xMLValueOrEmpty)+ ;

xMLValueOrEmpty: xMLValue | LESS_THAN_SIGN nonParameterizedTypeName XML_SINGLE_ENDTAG ;

xMLDelimitedItemList : (xMLDelimitedItem)+ ;

xMLDelimitedItem
    : LESS_THAN_SIGN nonParameterizedTypeName GREATER_THAN_SIGN xMLValue XML_ENDTAG nonParameterizedTypeName GREATER_THAN_SIGN
    | LESS_THAN_SIGN IDENTIFIER GREATER_THAN_SIGN xMLValue XML_ENDTAG IDENTIFIER GREATER_THAN_SIGN ;

// Chapter 27 Notation for set types
setType
	: SET LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET
	| SET LEFT_CURLY_BRACKET extensionAndException optionalExtensionMarker RIGHT_CURLY_BRACKET
	| SET LEFT_CURLY_BRACKET componentTypeLists RIGHT_CURLY_BRACKET ;

setValue
	: LEFT_CURLY_BRACKET componentValueList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET ;

xMLSetValue
	: xMLComponentValueList
	| ;


// Chapter 28 Notation for set-of types
setOfType
	: SET_OF type
	| SET_OF namedType ;

setOfValue
	: LEFT_CURLY_BRACKET valueList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET namedValueList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET ;

xMLSetOfValue
	: xMLValueList
	| xMLDelimitedItemList
	| ;

// Chapter 29 Notation for choice types
choiceType
	: CHOICE LEFT_CURLY_BRACKET alternativeTypeLists RIGHT_CURLY_BRACKET ;

alternativeTypeLists
	: rootAlternativeTypeList
	| rootAlternativeTypeList COMMA extensionAndException extensionAdditionAlternatives optionalExtensionMarker ;

rootAlternativeTypeList: alternativeTypeList ;

extensionAdditionAlternatives: COMMA extensionAdditionAlternativesList | ;

extensionAdditionAlternativesList: extensionAdditionAlternative (COMMA extensionAdditionAlternative)* ;

extensionAdditionAlternative
	: extensionAdditionAlternativesGroup
	| namedType ;

extensionAdditionAlternativesGroup: LEFT_VERSION_BRACKET versionNumber alternativeTypeList RIGHT_VERSION_BRACKET ;

alternativeTypeList: namedType (COMMA namedType)* ;

choiceValue: IDENTIFIER COLON value ;

xMLChoiceValue: LESS_THAN_SIGN IDENTIFIER GREATER_THAN_SIGN xMLValue XML_ENDTAG IDENTIFIER GREATER_THAN_SIGN ;

// Chapter 30 Notation for selection types
selectionType : IDENTIFIER LESS_THAN_SIGN type ;

// Chapter 31 Notation for prefixed types
prefixedType : taggedType | encodingPrefixedType ;

prefixedValue : value ;

xMLPrefixedValue : xMLValue ;

taggedType: tag type | tag IMPLICIT type | tag EXPLICIT type ;

tag : LEFT_SQUARE_BRACKET encodingReference asn1class classNumber RIGHT_SQUARE_BRACKET ;

encodingReference : ENCODINGREFERENCE COLON | ;

classNumber: number | definedValue ;

asn1class
	: UNIVERSAL
	| APPLICATION
	| PRIVATE
	| ;

encodingPrefixedType: encodingPrefix type ;

encodingPrefix : LEFT_SQUARE_BRACKET encodingReference encodingInstruction RIGHT_SQUARE_BRACKET ;

// Chapter 32 Notation for the object identifier type
objectIdentifierType: OBJECT_IDENTIFIER ;

objectIdentifierValue
	: LEFT_CURLY_BRACKET objIdComponentsList RIGHT_CURLY_BRACKET
	| LEFT_CURLY_BRACKET definedValue objIdComponentsList RIGHT_CURLY_BRACKET ;

objIdComponentsList: (objIdComponents)+;

objIdComponents: nameForm | numberForm | nameAndNumberForm | definedValue ;

nameForm: IDENTIFIER ;

numberForm: number | definedValue ;

nameAndNumberForm: IDENTIFIER LEFT_PARENTHESIS numberForm RIGHT_PARENTHESIS ;

xMLObjectIdentifierValue : xMLObjIdComponentList ;

xMLObjIdComponentList: xMLObjIdComponent | xMLObjIdComponent FULL_STOP xMLObjIdComponentList ;

xMLObjIdComponent: nameForm | xMLNumberForm | xMLNameAndNumberForm ;

xMLNumberForm: number ;

xMLNameAndNumberForm: IDENTIFIER LEFT_PARENTHESIS xMLNumberForm RIGHT_PARENTHESIS ;

// Chapter 33 Notation for the relative object identifier type
relativeOIDType: RELATIVE_OID ;

relativeOIDValue: LEFT_CURLY_BRACKET relativeOIDComponentsList RIGHT_CURLY_BRACKET ;

relativeOIDComponentsList: (relativeOIDComponents)+ ;

relativeOIDComponents: numberForm | nameAndNumberForm | definedValue ;

xMLRelativeOIDValue: xMLRelativeOIDComponentList ;

xMLRelativeOIDComponentList: xMLRelativeOIDComponent (FULL_STOP xMLRelativeOIDComponent)* ;

xMLRelativeOIDComponent: xMLNumberForm | xMLNameAndNumberForm ;

// Chapter 34 Notation for the OID internationalized resource identifier type
iRIType: OID_IRI ;

iRIValue: QUOTATION firstArcIdentifier subsequentArcIdentifier QUOTATION ;

firstArcIdentifier: SOLIDUS arcIdentifier ;

subsequentArcIdentifier : SOLIDUS arcIdentifier subsequentArcIdentifier | ;

arcIdentifier: iNTEGERUNICODELABEL | NONINTEGERUNICODELABEL ;

xMLIRIValue: firstArcIdentifier subsequentArcIdentifier ;

// Chapter 35 Notation for the relative OID internationalized resource identifier type
relativeIRIType: 'RELATIVE-OID-IRI' ;

relativeIRIValue: QUOTATION firstRelativeArcIdentifier subsequentArcIdentifier QUOTATION ;

firstRelativeArcIdentifier: arcIdentifier ;

xMLRelativeIRIValue: firstRelativeArcIdentifier subsequentArcIdentifier ;

// Chapter 36 Notation for the embedded-pdv type
embeddedPDVType: 'EMBEDDED PDV' ;

embeddedPDVValue: sequenceValue ;

xMLEmbeddedPDVValue: xMLSequenceValue ;

// Chapter 37 Notation for the external type
externalType: 'EXTERNAL' ;

externalValue: sequenceValue ;

xMLExternalValue: xMLSequenceValue ;

// Chapter 38 The time type
timeType: TIME ;

timeValue: tSTRING ;

xMLTimeValue: xMLTSTRING ;

dateType: DATE ;

timeOfDayType: TIME_OF_DAY ;

dateTimeType: DATE_TIME ;

durationType: DURATION ;

// Chapter 39 The character string types

// Chapter 40 Notation for character string types
characterStringType: restrictedCharacterStringType | unrestrictedCharacterStringType ;

characterStringValue: restrictedCharacterStringValue | unrestrictedCharacterStringValue ;

xMLCharacterStringValue : xMLRestrictedCharacterStringValue | xMLUnrestrictedCharacterStringValue ;

// Chapter 41 Definition of restricted character string types
restrictedCharacterStringType : TYPEREFERENCE ;
/**	
	Checked in the code
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
*/

restrictedCharacterStringValue: CSTRING | characterStringList | quadruple | tuple ;

characterStringList: LEFT_CURLY_BRACKET charSyms RIGHT_CURLY_BRACKET ;

charSyms: charsDefn (COMMA charsDefn)* ;

charsDefn: CSTRING | quadruple | tuple | definedValue ;

quadruple : LEFT_CURLY_BRACKET group COMMA plane COMMA row COMMA cell RIGHT_CURLY_BRACKET ;

group: number ;

plane: number ;

row: number ;

cell: number ;

tuple : LEFT_CURLY_BRACKET tableColumn COMMA tableRow RIGHT_CURLY_BRACKET ;

tableColumn: number ;

tableRow: number ;

xMLRestrictedCharacterStringValue: xMLCSTRING ;

// Chapter 42 Naming characters, collections and property category sets

// Chapter 43 Canonical order of characters

// Chapter 44 Definition of unrestricted character string types
unrestrictedCharacterStringType: CHARACTER_STRING ;

unrestrictedCharacterStringValue: sequenceValue ;

xMLUnrestrictedCharacterStringValue: xMLSequenceValue ;

// Chapter 45 Notation for types defined in clauses 46 to 48
usefulType: TYPEREFERENCE ;

// Chapter 46 Generalized time

// Chapter 47 Universal time

// Chapter 48 The object descriptor type

// Chapter 49 Constrained types
// merged into type
// constrainedType
// 	: type constraint
//	| typeWithConstraint ;

typeWithConstraint
	: SET constraint OF type
	| SET sizeConstraint OF type
	| SEQUENCE constraint OF type
	| SEQUENCE sizeConstraint OF type
	| SET constraint OF namedType
	| SET sizeConstraint OF namedType
	| SEQUENCE constraint OF namedType
	| SEQUENCE sizeConstraint OF namedType ;

constraint: LEFT_PARENTHESIS constraintSpec exceptionSpec RIGHT_PARENTHESIS ;

constraintSpec: subtypeConstraint | generalConstraint ;

subtypeConstraint: elementSetSpecs ;

// Chapter 50 Element set specification
elementSetSpecs
	: rootElementSetSpec
	| rootElementSetSpec COMMA ELLIPSIS
	| rootElementSetSpec COMMA ELLIPSIS COMMA additionalElementSetSpec ;

rootElementSetSpec: elementSetSpec ;

additionalElementSetSpec: elementSetSpec ;

elementSetSpec: unions | ALL exclusions ;

unions: intersections | unions unionMark intersections ;

// uElems: unions ;

intersections: intersectionElements | intersections intersectionMark intersectionElements ;

// iElems: intersections ;

intersectionElements: elements | elems exclusions ;

elems: elements ;

exclusions: EXCEPT elements ;

unionMark: VERTICAL_LINE | UNION ;

intersectionMark: CIRCUMFLEX_ACCENT | INTERSECTION ;

elements: subtypeElements | objectSetElements | LEFT_PARENTHESIS elementSetSpec RIGHT_PARENTHESIS ;

// Chapter 51 Subtype elements
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

includes: INCLUDES | ;

valueRange: lowerEndpoint RANGE upperEndpoint ;

lowerEndpoint: lowerEndValue | lowerEndValue LESS_THAN_SIGN ;

upperEndpoint: upperEndValue | LESS_THAN_SIGN upperEndValue ;

lowerEndValue: value | MIN ;

upperEndValue: value | MAX ;

sizeConstraint: SIZE constraint ;

typeConstraint: type ;

permittedAlphabet: FROM constraint ;

innerTypeConstraints: WITH_COMPONENT singleTypeConstraint | WITH_COMPONENTS multipleTypeConstraints ;

singleTypeConstraint: constraint ;

multipleTypeConstraints: fullSpecification | partialSpecification ;

fullSpecification: LEFT_CURLY_BRACKET typeConstraints RIGHT_CURLY_BRACKET ;

partialSpecification: LEFT_CURLY_BRACKET ELLIPSIS COMMA typeConstraints RIGHT_CURLY_BRACKET ;

typeConstraints: namedConstraint (COMMA namedConstraint)* ;

namedConstraint: IDENTIFIER componentConstraint ;

componentConstraint: valueConstraint presenceConstraint ;

valueConstraint: constraint | ;

presenceConstraint: PRESENT | ABSENT | OPTIONAL | ;

patternConstraint: PATTERN value ;

propertySettings: SETTINGS SIMPLESTRING ;

propertySettingsList: (propertyAndSettingPair)+ ;

propertyAndSettingPair: propertyName EQUALS_SIGN settingName ;

propertyName: PSNAME ;

settingName: PSNAME ;

durationRange: valueRange ;

timePointRange: valueRange ;

recurrenceRange: valueRange ;

exceptionSpec: EXCLAMATION exceptionIdentification | ;

exceptionIdentification: signedNumber | definedValue | type COLON value ;

// Chapter 54 Encoding Control Sections
encodingControlSections : (encodingControlSection)+ | ;

encodingControlSection: 'ENCODING-CONTROL' ENCODINGREFERENCE encodingInstructionAssignmentList ;

encodingInstructionAssignmentList: ENCODINGREFERENCE ;

encodingInstruction: encodingReference ;

// ITU X.681
// Chapter 8 Referencing definitions
definedObjectClass: externalObjectClassReference | objectclassreference | usefulObjectClassReference ;

definedObject: externalObjectReference | objectreference ;

definedObjectSet: externalObjectSetReference | objectsetreference ;

externalObjectClassReference: modulereference FULL_STOP objectclassreference ;

externalObjectReference: modulereference FULL_STOP objectreference ;

externalObjectSetReference: modulereference FULL_STOP objectsetreference ;

usefulObjectClassReference: TYPE_IDENTIFIER | ABSTRACT_SYNTAX ;

// Chapter 9 Information object class definition and assignment
objectClassAssignment: objectclassreference ASSIGNMENT objectClass ;

objectClass: definedObjectClass | objectClassDefn | parameterizedObjectClass ;

objectClassDefn: CLASS LEFT_CURLY_BRACKET fieldSpec (COMMA fieldSpec)* RIGHT_CURLY_BRACKET withSyntaxSpec? ;

withSyntaxSpec: WITH_SYNTAX syntaxList ;

fieldSpec
	: typeFieldSpec
	| fixedTypeValueFieldSpec
	| variableTypeValueFieldSpec
	| fixedTypeValueSetFieldSpec
	| variableTypeValueSetFieldSpec
	| objectFieldSpec
	| objectSetFieldSpec ;

typeFieldSpec: typefieldreference typeOptionalitySpec? ;

typeOptionalitySpec: (OPTIONAL | DEFAULT) type ;

fixedTypeValueFieldSpec: valuefieldreference type UNIQUE? valueOptionalitySpec? ;

valueOptionalitySpec: (OPTIONAL | DEFAULT) value ;

variableTypeValueFieldSpec: valuefieldreference fieldName valueOptionalitySpec? ;

fixedTypeValueSetFieldSpec: valuesetfieldreference type valueSetOptionalitySpec? ;

valueSetOptionalitySpec: (OPTIONAL | DEFAULT) valueSet ;

variableTypeValueSetFieldSpec: valuesetfieldreference fieldName valueSetOptionalitySpec? ;

objectFieldSpec: objectfieldreference definedObjectClass objectOptionalitySpec? ;

objectOptionalitySpec: (OPTIONAL | DEFAULT) object ;

objectSetFieldSpec: objectsetfieldreference definedObjectClass objectSetOptionalitySpec? ;

objectSetOptionalitySpec: (OPTIONAL | DEFAULT) objectSet ;

primitiveFieldName
	: typefieldreference
	| valuefieldreference
	| valuesetfieldreference
	| objectfieldreference
	| objectsetfieldreference ;

fieldName: primitiveFieldName (FULL_STOP primitiveFieldName)* ;

// chapter 10 Syntax List
syntaxList: LEFT_CURLY_BRACKET tokenOrGroupSpec (WS tokenOrGroupSpec)* RIGHT_CURLY_BRACKET ;

tokenOrGroupSpec: requiredToken | optionalGroup ;

optionalGroup: LEFT_SQUARE_BRACKET tokenOrGroupSpec (WS tokenOrGroupSpec)* RIGHT_SQUARE_BRACKET ;

requiredToken: literal | primitiveFieldName ;

literal: WORD | COMMA ;

// Chapter 11 Information object definition and assignment
objectAssignment: objectreference definedObjectClass ASSIGNMENT object ;

object: definedObject | objectDefn | objectFromObject | parameterizedObject ;

objectDefn: defaultSyntax | definedSyntax ;

defaultSyntax: LEFT_CURLY_BRACKET fieldSetting (COMMA fieldSetting)* RIGHT_CURLY_BRACKET ;

fieldSetting: primitiveFieldName setting ;

definedSyntax: LEFT_CURLY_BRACKET (definedSyntaxToken)* RIGHT_CURLY_BRACKET ;

definedSyntaxToken: literal | setting ;

setting: type | value | valueSet | object | objectSet ;

// Chapter 12 Information object set definition and assignment
objectSetAssignment: objectsetreference definedObjectClass ASSIGNMENT objectSet ;

objectSet: LEFT_CURLY_BRACKET objectSetSpec RIGHT_CURLY_BRACKET ;

objectSetSpec
	: rootElementSetSpec
	| rootElementSetSpec COMMA ELLIPSIS
	| ELLIPSIS
	| ELLIPSIS COMMA additionalElementSetSpec
	| rootElementSetSpec COMMA ELLIPSIS COMMA additionalElementSetSpec ;

objectSetElements: object | definedObjectSet | objectSetFromObjects | parameterizedObjectSet ;

// Chapter 14 Notation for the object class field type
objectClassFieldType: definedObjectClass FULL_STOP fieldName ;

objectClassFieldValue: openTypeFieldVal | fixedTypeFieldVal ;

openTypeFieldVal: type COLON value ;

fixedTypeFieldVal: builtinValue | referencedValue ;

xMLObjectClassFieldValue: xMLOpenTypeFieldVal | xMLFixedTypeFieldVal ;

xMLOpenTypeFieldVal: xMLTypedValue | xMLHSTRING ;

xMLFixedTypeFieldVal: xMLBuiltinValue ;

// Chapter 15 Information from objects
informationFromObjects
	:valueFromObject
	| valueSetFromObjects
	| typeFromObject
	| objectFromObject
	| objectSetFromObjects ;

valueFromObject: referencedObjects FULL_STOP fieldName ;

valueSetFromObjects: referencedObjects FULL_STOP fieldName ;

typeFromObject: referencedObjects FULL_STOP fieldName ;

objectFromObject: referencedObjects FULL_STOP fieldName ;

objectSetFromObjects: referencedObjects FULL_STOP fieldName ;

referencedObjects
	: definedObject
	| parameterizedObject
	| definedObjectSet
	| parameterizedObjectSet ;

// Annex C
instanceOfType: INSTANCE_OF definedObjectClass ;

instanceOfValue: value ;

xMLInstanceOfValue: xMLValue ;

// ITU X.682
generalConstraint: userDefinedConstraint | tableConstraint | contentsConstraint ;

contentsConstraint: type ;

// Chapter 9 User-defined constraints
userDefinedConstraint: CONSTRAINED_BY LEFT_CURLY_BRACKET userDefinedConstraintParameter (COMMA userDefinedConstraintParameter)* RIGHT_CURLY_BRACKET ;

userDefinedConstraintParameter
	: governor COLON value
	| governor COLON object
	| definedObjectSet
	| type
	| definedObjectClass ;

// Chapter 10 Table constraints, including component relation constraints
tableConstraint: simpleTableConstraint | componentRelationConstraint ;

simpleTableConstraint: objectSet ;

componentRelationConstraint: LEFT_CURLY_BRACKET definedObjectSet RIGHT_CURLY_BRACKET LEFT_CURLY_BRACKET atNotation (COMMA atNotation)* RIGHT_CURLY_BRACKET ;

atNotation: COMMERCIAL_AT componentIdList | COMMERCIAL_AT FULL_STOP level componentIdList ;

level: FULL_STOP level | ;

componentIdList: IDENTIFIER (FULL_STOP IDENTIFIER)* ;

// ITU X.683
// Chapter 8 Parameterized assignments
parameterizedAssignment
	: parameterizedTypeAssignment
	| parameterizedValueAssignment
	| parameterizedValueSetTypeAssignment
	| parameterizedObjectClassAssignment
	| parameterizedObjectAssignment
	| parameterizedObjectSetAssignment ;

parameterizedTypeAssignment: TYPEREFERENCE parameterList ASSIGNMENT type ;

parameterizedValueAssignment: valuereference parameterList type ASSIGNMENT value ;

parameterizedValueSetTypeAssignment: TYPEREFERENCE parameterList type ASSIGNMENT valueSet ;

parameterizedObjectClassAssignment: objectclassreference parameterList ASSIGNMENT objectClass ;

parameterizedObjectAssignment: objectreference parameterList definedObjectClass ASSIGNMENT object ;

parameterizedObjectSetAssignment: objectsetreference parameterList definedObjectClass ASSIGNMENT objectSet ;

parameterList: LEFT_CURLY_BRACKET parameter (COMMA parameter)* RIGHT_CURLY_BRACKET ;

parameter: paramGovernor COLON (dummyReference | dummyReference) ;

paramGovernor: governor | dummyGovernor ;

governor: type | definedObjectClass ;

dummyGovernor: dummyReference ;

dummyReference: reference ;

// Chapter 9 Referencing parameterized definitions
parameterizedReference: reference | reference LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET ;

parameterizedType: simpleDefinedType actualParameterList ;

simpleDefinedType: externalTypeReference | TYPEREFERENCE ;

parameterizedValue: simpleDefinedValue actualParameterList ;

simpleDefinedValue: externalValueReference | valuereference ;

parameterizedValueSetType: simpleDefinedType actualParameterList ;

parameterizedObjectClass: definedObjectClass actualParameterList ;

parameterizedObjectSet: definedObjectSet actualParameterList ;

parameterizedObject: definedObject actualParameterList ;

actualParameterList: LEFT_CURLY_BRACKET actualParameter (COMMA actualParameter)* RIGHT_CURLY_BRACKET ;

actualParameter: type | value | valueSet | definedObjectClass | object | objectSet ;

// Deprecated ANY type
anyType: ANY (DEFINED_BY IDENTIFIER)? ;
