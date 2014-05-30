grammar vrml;		

world: header ( node ) * EOF ;

header 
  : '#VRML' 'V2.0' 'utf8' ( 'CosmoWorlds' 'V1.0' )?
  ;

node
  : ( worldInfoNode
    | navigationInfoNode
    | transformNode
    | viewPointNode
    | pointLightNode    
    | groupNode
    | shapeNode
    | collisionNode
    | switchNode
    | inlineNode
    | ortSpotLightNode
    | ortDirectionalLightNode
    | ortPointLightNode
    | ortShaderNode
    )   
  ;

inlineNode 
  : optDef 'Inline' '{'
    ( 'url' stringArray
    | 'bboxCenter' float3
    | 'bboxSize' float3
    )*
'}'
  ;
navigationInfoNode
  : optDef 'NavigationInfo' '{' 
    ( 'headlight' BooleanLiteral
    | 'avatarSize' float1Array
    | 'speed' float1
    | 'type' stringArray
    | 'visibilityLimit' float1
    )*
    '}'
  ;

worldInfoNode
  : optDef 'WorldInfo' '{' 
    ('info' stringArray
    |'title' stringArray
    )*
    '}'
  ;

optDef
  : ('DEF' Identifier)? 
  ;

collisionNode
  : optDef 'Collision' '{'
    ( children 
    | 'bboxCenter' float3
    | 'bboxSize' float3
    | 'collide' bool1
    | 'proxy' proxyNode
    )*
    '}'
  ;

proxyNode
  : 'USE' Identifier
  | 'NULL'
  ;

shapeNode
  : 'Shape' '{' 
    ('appearance' appearanceNode
    |'geometry' geometryNode)* 
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

colorNode
  : 'USE' Identifier
  | 'NULL'
  ;

geometryNode
  : indexedFaceSetNode
  ;

indexedFaceSetNode
  : optDef 'IndexedFaceSet' '{'
    ( 'coord' coordinateNode
    | 'normal' normalNode
    | 'creaseAngle' float1
    | 'color' colorNode
    | 'coordIndex' intArray 
    | 'colorIndex' intArray 
    | 'normalIndex' intArray 
    | 'normalPerVertex' bool1
    | 'solid' bool1
    | 'texCoord' textureCoordinateNode
    | 'texCoordIndex' intArray 
    | 'ccw' bool1
    | 'colorPerVertex' bool1
    | 'convex' bool1
    )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

textureCoordinateNode
  : optDef 'TextureCoordinate' '{'
    ( 'point' float2Array )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

normalNode
  : optDef 'Normal' '{'
    ( 'vector' float3Array )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

coordinateNode
  : optDef 'Coordinate' '{'
    ( 'point' float3Array )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

intArray
  : '[' int1 (','? int1)* ']'
  | '[' ']'
  | int1
  ;

stringArray
  : '[' string (','? string)* ']'
  | '[' ']'
  | string
  ;

float2Array
  : '[' float2 (','? float2)* ']'
  | '[' ']'
  | float2
  ;

float3Array
  : '[' float3 (','? float3)* ']'
  | '[' ']'
  | float3
  ;

float1Array
  : '[' float1 (','? float1)* ']'
  | '[' ']'
  | float1
  ;

appearanceNode 
  : 'Appearance' '{' 
    ( appearanceMember 
    )*
    '}'
  | ortAppearanceNode
  | 'USE' Identifier
  | 'NULL'
  ;

// 'ORT'Appearance nodes are extensions from the original 'openrt'
// project (in the 2000-2005's); they're not part of the VRML2
// spec, but I'll add them here just for testing, since many of my
// vrml files still have such nodes
ortAppearanceNode
  :'ORTAppearance' '{' 
    ( 'material' materialNode
    | 'shader' ortShaderNode
    | 'instanceName' string
    | appearanceMember
    )*
    '}'
  ;

ortSpotLightNode
  : 'ORTSpotLight' '{'
    ( 'name' string
    | 'shader' ortShaderNode 
    | 'ambientIntensity' float1
    | 'attenuation' float3
    | 'beamWidth' float1
    | 'cutOffAngle' float1
    | 'direction' float3
    | 'location' float3
    | 'on' bool1
    | 'radius' float1
    | 'ambientIntensity' float1
    | 'color' float3    
    | 'intensity' float1
    | 'on' bool1
    )*
    '}'
  ;

ortDirectionalLightNode
  : 'ORTDirectionalLight' '{'
    ( 'name' string
    | 'shader' ortShaderNode 
    | 'ambientIntensity' float1
    | 'color' float3    
    | 'intensity' float1
    | 'on' bool1
    | 'direction' float3
    )*
    '}'
  ;

ortPointLightNode
  : 'ORTPointLight' '{'
    ( 'name' string
    | 'shader' ortShaderNode 
    | 'ambientIntensity' float1
    | 'color' float3    
    | 'attenuation' float3    
    | 'location' float3    
    | 'intensity' float1
    | 'on' bool1
    | 'radius' float1
    )*
    '}'
  ;

ortShaderNode
  : 'ORTGeneralShader' '{'
    ( 'name' string
    | 'file' string
    | 'options' stringArray
    )*
    '}'
  | 'ORTLightShader' '{'
    ( 'name' string
    | 'file' string
    | 'options' stringArray
    )*
    '}'
  | 'ORTEnvironmentShader' '{'
    ( 'textureURLs'  stringArray 
    | 'name' string
    | 'file' string
    | 'options' stringArray
    )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;


appearanceMember
  : 'material' materialNode
  | 'texture' imageTextureNode
  | 'textureTransform' textureTransformNode
  | 'textureProjection' textureProjectionNode
  ;

textureProjectionNode
  : 'USE' Identifier
  | 'NULL'
  ;

textureTransformNode
  : optDef 'TextureTransform' '{'
    ( 'center' float2
    | 'rotation' float1
    | 'scale' float2
    | 'translation' float2
    )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;
imageTextureNode
  : optDef 'ImageTexture' '{'
    ( 'repeatS' bool1 
    | 'repeatT' bool1 
    | 'url' stringArray
    | 'model' string
    | 'blendColor' float3
    )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

materialNode
  : optDef 'Material' '{'
    ( 'diffuseColor' float3
    | 'ambientIntensity' float1
    | 'specularColor' float3
    | 'emissiveColor' float3
    | 'shininess' float1
    | 'transparency' float1
    )*
    '}'
  | 'USE' Identifier
  | 'NULL'
  ;

transformNode
  : optDef 'Transform' '{' 
    ( children
    | 'center' float3
    | 'rotation' float4
    | 'scale' float3
    | 'scaleOrientation' float4
    | 'translation' float3
    | 'bboxCenter' float3
    | 'bboxSize' float3
    )* 
    '}' 
  | 'USE' Identifier
  ;

groupNode
  : optDef 'Group' '{' 
    ( children 
    | 'bboxCenter' float3
    | 'bboxSize' float3
    )* 
    '}'
  ;

switchNode
  : optDef 'Switch' '{'
    ( 'choice' nodeArray
    | 'whichChoice' int1
    )*
    '}' 
  ;

pointLightNode
  : optDef 'PointLight' '{' 
    ( 'ambientIntensity' float1
    | 'on' boolVal
    | 'color' float3
    )*
    '}'
  ;

bool1
  : BooleanLiteral
  ;

int1
  : IntegerLiteral
  ;

float1
  : FloatingPointLiteral
  | IntegerLiteral
  ;

float2: float1 float1;
float3: float1 float1 float1;
float4: float1 float1 float1 float1;


boolVal
  : BooleanLiteral
  ;

viewPointNode
  : optDef 'Viewpoint' '{' 
    ( 'fieldOfView' float1 
    | 'position' float3
    | 'orientation' float4
    | 'description' string
    | 'jump' bool1
    )*
    '}'
  ;

string: StringLiteral ;

notImplemented
  : '___NotYetImplemented___'
  ;

children
  : 'children' nodeArray
  ;

nodeArray
  : '[' node (','? node)* ']'
  | '[' ']'
  | node
  ;

// §3.10.1 Integer Literals

IntegerLiteral
: '-'? DecimalIntegerLiteral
| '-'? HexIntegerLiteral
| '-'? OctalIntegerLiteral
| '-'? BinaryIntegerLiteral
;

fragment
DecimalIntegerLiteral
: DecimalNumeral IntegerTypeSuffix?
;

fragment
HexIntegerLiteral
: HexNumeral IntegerTypeSuffix?
;

fragment
OctalIntegerLiteral
: OctalNumeral IntegerTypeSuffix?
;

fragment
BinaryIntegerLiteral
: BinaryNumeral IntegerTypeSuffix?
;

fragment
IntegerTypeSuffix
: [lL]
;

fragment
DecimalNumeral
: '0'
| NonZeroDigit (Digits? | Underscores Digits)
;

fragment
Digits
: Digit (DigitOrUnderscore* Digit)?
;

fragment
Digit
: '0'
| NonZeroDigit
;

fragment
NonZeroDigit
: [1-9]
;

fragment
DigitOrUnderscore
: Digit
| '_'
;

fragment
Underscores
: '_'+
;

fragment
HexNumeral
: '0' [xX] HexDigits
;

fragment
HexDigits
: HexDigit (HexDigitOrUnderscore* HexDigit)?
;

fragment
HexDigit
: [0-9a-fA-F]
;

fragment
HexDigitOrUnderscore
: HexDigit
| '_'
;

fragment
OctalNumeral
: '0' Underscores? OctalDigits
;

fragment
OctalDigits
: OctalDigit (OctalDigitOrUnderscore* OctalDigit)?
;

fragment
OctalDigit
: [0-7]
;

fragment
OctalDigitOrUnderscore
: OctalDigit
| '_'
;

fragment
BinaryNumeral
: '0' [bB] BinaryDigits
;

fragment
BinaryDigits
: BinaryDigit (BinaryDigitOrUnderscore* BinaryDigit)?
;

fragment
BinaryDigit
: [01]
;

fragment
BinaryDigitOrUnderscore
: BinaryDigit
| '_'
;

// §3.10.2 Floating-Point Literals

FloatingPointLiteral
: '-'? DecimalFloatingPointLiteral
| HexadecimalFloatingPointLiteral
;

fragment
DecimalFloatingPointLiteral
: Digits '.' Digits? ExponentPart? FloatTypeSuffix?
| '.' Digits ExponentPart? FloatTypeSuffix?
| Digits ExponentPart FloatTypeSuffix?
| Digits FloatTypeSuffix
;

fragment
ExponentPart
: ExponentIndicator SignedInteger
;

fragment
ExponentIndicator
: [eE]
;

fragment
SignedInteger
: Sign? Digits
;

fragment
Sign
: [+-]
;

fragment
FloatTypeSuffix
: [fFdD]
;

fragment
HexadecimalFloatingPointLiteral
: HexSignificand BinaryExponent FloatTypeSuffix?
;

fragment
HexSignificand
: HexNumeral '.'?
| '0' [xX] HexDigits? '.' HexDigits
;

fragment
BinaryExponent
: BinaryExponentIndicator SignedInteger
;

fragment
BinaryExponentIndicator
: [pP]
;

// §3.10.3 Boolean Literals

BooleanLiteral
  : 'true'
  | 'TRUE'
  | 'false'
  | 'FALSE'
  ;

// §3.10.4 Character Literals

CharacterLiteral
: '\'' SingleCharacter '\''
| '\'' EscapeSequence '\''
;

fragment
SingleCharacter
: ~['\\]
;

// §3.10.5 String Literals

StringLiteral
: '"' StringCharacters? '"'
;

fragment
StringCharacters
: StringCharacter+
;

fragment
StringCharacter
: ~["]
| EscapeSequence
;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
: '\\' [btnfr"'\\]
| OctalEscape
| UnicodeEscape
;

fragment
OctalEscape
: '\\' OctalDigit
| '\\' OctalDigit OctalDigit
| '\\' ZeroToThree OctalDigit OctalDigit
;

fragment
UnicodeEscape
: '\\' 'u' HexDigit HexDigit HexDigit HexDigit
;

fragment
ZeroToThree
: [0-3]
;

// §3.10.7 The Null Literal

NullLiteral
: 'null'
;

// §3.11 Separators

LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';
SEMI : ';';
COMMA : ',';
DOT : '.';

// §3.12 Operators

ASSIGN : '=';
GT : '>';
LT : '<';
BANG : '!';
TILDE : '~';
QUESTION : '?';
COLON : ':';
EQUAL : '==';
LE : '<=';
GE : '>=';
NOTEQUAL : '!=';
AND : '&&';
OR : '||';
INC : '++';
DEC : '--';
ADD : '+';
SUB : '-';
MUL : '*';
DIV : '/';
BITAND : '&';
BITOR : '|';
CARET : '^';
MOD : '%';

ADD_ASSIGN : '+=';
SUB_ASSIGN : '-=';
MUL_ASSIGN : '*=';
DIV_ASSIGN : '/=';
AND_ASSIGN : '&=';
OR_ASSIGN : '|=';
XOR_ASSIGN : '^=';
MOD_ASSIGN : '%=';
LSHIFT_ASSIGN : '<<=';
RSHIFT_ASSIGN : '>>=';
URSHIFT_ASSIGN : '>>>=';

// §3.8 Identifiers (must appear after all keywords in the grammar)

// Identifier
// : JavaLetter JavaLetterOrDigit*
// ;

Identifier
: Letter+ (Letter|[0-9%:])*
  ;

fragment 
Letter
: [a-zA-Z_\(\)]
  ;

fragment
JavaLetter
: [a-zA-Z$_] // these are the "java letters" below 0xFF
| // covers all characters above 0xFF which are not a surrogate
~[\u0000-\u00FF\uD800-\uDBFF]
{Character.isJavaIdentifierStart(_input.LA(-1))}?
| // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
[\uD800-\uDBFF] [\uDC00-\uDFFF]
{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
;

fragment
JavaLetterOrDigit
: [a-zA-Z0-9$_] // these are the "java letters or digits" below 0xFF
| // covers all characters above 0xFF which are not a surrogate
~[\u0000-\u00FF\uD800-\uDBFF]
{Character.isJavaIdentifierPart(_input.LA(-1))}?
| // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
[\uD800-\uDBFF] [\uDC00-\uDFFF]
{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
;

//
// Additional symbols not defined in the lexical specification
//

AT : '@';
ELLIPSIS : '...';

//
// Whitespace and comments
//

WS : [ \t\r\n\u000C]+ -> channel(HIDDEN)
;

COMMENT
: '/*' .*? '*/' -> channel(HIDDEN)
;

LINE_COMMENT
: '#' WS ~[\r\n]* -> channel(HIDDEN)
;
