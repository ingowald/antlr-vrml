all: vrmlParser.class

ANTLR=/usr/local/lib/antlr-4.2.2-complete.jar

antlr4=java -jar $(ANTLR)

vrmlParser.java: vrml.g4
	${antlr4} vrml.g4

vrmlParser.class: vrmlParser.java
	javac vrml*java -classpath $(ANTLR)

