package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Test the BERBoolean implementation
 *
 * Created by david on 6/20/15.
 */
public class BERBooleanTest {

    @Test
    public void defaultConstructorBERbooleanTest() {
        BERBoolean berBoolean = new BERBoolean();

        assertFalse(berBoolean.getASN1Boolean());
    }

    @Test
    public void parameterConstructorBERbooleanTest() {
        BERBoolean trueBERBoolean = new BERBoolean(true);
        BERBoolean falseBERBoolean = new BERBoolean(false);

        assertTrue(trueBERBoolean.getASN1Boolean());
        assertFalse(falseBERBoolean.getASN1Boolean());
    }

    @Test
    public void setValuesBERbooleanTest() {
        BERBoolean trueBERBoolean = new BERBoolean();
        BERBoolean falseBERBoolean = new BERBoolean();

        trueBERBoolean.setASN1Boolean(true);
        falseBERBoolean.setASN1Boolean(false);

        assertTrue(trueBERBoolean.getASN1Boolean());
        assertFalse(falseBERBoolean.getASN1Boolean());
    }

    @Test
    public void encodeBERbooleanTest() {
        BERBoolean trueBERBoolean = new BERBoolean(true);
        BERBoolean falseBERBoolean = new BERBoolean(false);

        byte[] trueEncoded = trueBERBoolean.encode();
        byte[] falseEncoded = falseBERBoolean.encode();

        byte[] trueValue = {0x01, 0x01, (byte)0xFF};
        byte[] falseValue = {0x01, 0x01, (byte)0x00};

        assertArrayEquals(trueValue, trueEncoded);
        assertArrayEquals(falseValue, falseEncoded);
    }

    @Test
    public void decodeBERbooleanTest() {
        BERBoolean trueBERBoolean = new BERBoolean();
        BERBoolean falseBERBoolean = new BERBoolean();

        byte[] trueValue = {0x01, 0x01, (byte)0xFF};
        byte[] falseValue = {0x01, 0x01, (byte)0x00};

        try {
            trueBERBoolean.decode(trueValue);
            falseBERBoolean.decode(falseValue);
        }
        catch (ASN1Exception e) {
            e.printStackTrace();
        }

        assertTrue(trueBERBoolean.getASN1Boolean());
        assertFalse(falseBERBoolean.getASN1Boolean());
    }

    @Test(expected = ASN1Exception.class)
    public void invalidTagBERbooleanTest() throws ASN1Exception {
        BERBoolean berBoolean = new BERBoolean();

        byte[] binValue = {0x02, 0x01, (byte)0xFF};

        berBoolean.decode(binValue);
    }

    @Test(expected = ASN1Exception.class)
    public void invalidLengthBERbooleanTest() throws ASN1Exception {
        BERBoolean berBoolean = new BERBoolean();

        byte[] binValue = {0x01, 0x02, (byte)0xFF};

        berBoolean.decode(binValue);
    }

    @Test
    public void getLengthBERbooleanTest() throws ASN1Exception {
        BERBoolean berBoolean = new BERBoolean();

        byte[] binValue = {0x01, 0x01, (byte)0xFF};

        berBoolean.decode(binValue);

        assertEquals(3, berBoolean.getLength());
    }

    @Test
    public void isIndefiniteLengthBERbooleanTest() throws ASN1Exception {
        BERBoolean berBoolean = new BERBoolean();

        byte[] binValue = {0x01, 0x01, (byte)0xFF};

        berBoolean.decode(binValue);

        assertEquals(false, berBoolean.isIndefiniteLength());
    }
}