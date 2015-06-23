package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

/**
 * Testing the BER enumeration
 *
 * Created by david on 22/06/15.
 */
public class BEREnumerationTest {

    @Test
    public void encodeBEREnumerationTest() throws ASN1Exception {
        byte[] byteBERInteger = { 0x02, 0x01, 0x02 };

        BEREnumeration berEnumeration = new BEREnumeration();

        berEnumeration.addEnumeration(BigInteger.valueOf(0));
        berEnumeration.addEnumeration(BigInteger.valueOf(1));
        berEnumeration.addEnumeration(BigInteger.valueOf(2));
        berEnumeration.addEnumeration(BigInteger.valueOf(3));

        berEnumeration.setASN1Integer(BigInteger.valueOf(2));

        assertArrayEquals(byteBERInteger, berEnumeration.encode());
    }

    @Test
    public void decodeBEREnumerationTest() throws ASN1Exception {
        byte[] byteBERInteger = { 0x02, 0x01, 0x03 };

        BEREnumeration berEnumeration = new BEREnumeration();

        berEnumeration.addEnumeration(BigInteger.valueOf(0));
        berEnumeration.addEnumeration(BigInteger.valueOf(1));
        berEnumeration.addEnumeration(BigInteger.valueOf(2));
        berEnumeration.addEnumeration(BigInteger.valueOf(3));

        berEnumeration.decode(byteBERInteger);

        assertEquals(BigInteger.valueOf(3), berEnumeration.getASN1Integer());
    }

    @Test(expected = ASN1Exception.class)
    public void decodeBEREnumerationExceptionTest() throws ASN1Exception {
        byte[] byteBERInteger = { 0x02, 0x01, 0x04 };

        BEREnumeration berEnumeration = new BEREnumeration();

        berEnumeration.addEnumeration(BigInteger.valueOf(0));
        berEnumeration.addEnumeration(BigInteger.valueOf(1));
        berEnumeration.addEnumeration(BigInteger.valueOf(2));
        berEnumeration.addEnumeration(BigInteger.valueOf(3));

        berEnumeration.decode(byteBERInteger);
    }

    @Test(expected = ASN1Exception.class)
    public void encodeBEREnumerationExceptionTest() throws ASN1Exception {

        BEREnumeration berEnumeration = new BEREnumeration();

        berEnumeration.addEnumeration(BigInteger.valueOf(0));
        berEnumeration.addEnumeration(BigInteger.valueOf(1));
        berEnumeration.addEnumeration(BigInteger.valueOf(2));
        berEnumeration.addEnumeration(BigInteger.valueOf(3));

        berEnumeration.setASN1Integer(BigInteger.valueOf(4));

    }

}