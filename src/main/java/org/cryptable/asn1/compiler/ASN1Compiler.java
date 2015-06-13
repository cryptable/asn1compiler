package org.cryptable.asn1.compiler;

import java.io.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

/**
 * Class which invokes the Assembled ASN.1 compiler from ANTLR4
 *
 * @author David Tillemans
 */
public class ASN1Compiler {

    /**
     * Feed the ASN1Compiler the ASN1 specifications
     *
     * @param is Input stream to be compiled
     */
    public void compile(InputStream is) throws IOException {

        ANTLRInputStream input = new ANTLRInputStream(is);

        // create a lexer that feeds off of input CharStream
        Asn1ParserLexer lexer = new Asn1ParserLexer(input);

        // create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // create a parser that feeds off the tokens buffer
        Asn1ParserParser parser = new Asn1ParserParser(tokens);

        ParseTree tree = parser.moduleDefinition(); // begin parsing at init rule

        System.out.println(tree.toStringTree(parser)); // print LISP-style tree

    }

    /**
     * compile an ASN1 file
     *
     * @param file ANS1 file to be compiled
     */
    public void compile(File file) throws IOException {
        // create a CharStream that reads from standard input
        FileInputStream fis = new FileInputStream(file);

        compile(fis);
    }
}