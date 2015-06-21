package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Random;
import org.apache.commons.codec.binary.Hex;

import static org.junit.Assert.*;

/**
 * Test class for the BER Integer implementation
 * Created by david on 6/21/15.
 */
public class BERIntegerTest {

    @Test
    public void defaultConstructorTest() {
        BERInteger berInteger = new BERInteger();

        assertEquals(BigInteger.valueOf(0), berInteger.getASN1Integer());
    }

    @Test
    public void parameterizedConstructorTest() {
        BERInteger berInteger = new BERInteger(BigInteger.valueOf(123456));

        assertEquals(BigInteger.valueOf(123456), berInteger.getASN1Integer());
    }

    @Test
    public void encodeBERIntegerTest() throws ASN1Exception {
        byte[] byteInteger = { 0x03, (byte)0xF2, (byte)0xE6 };
        byte[] byteBERInteger = { 0x02, 0x03, 0x03, (byte)0xF2, (byte)0xE6 };

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger(bigInteger);

        assertArrayEquals(byteBERInteger, berInteger.encode());
    }

    @Test
    public void decodeBERIntegerTest() throws ASN1Exception {
        byte[] byteInteger = { 0x03, (byte)0xF2, (byte)0xE6 };
        byte[] byteBERInteger = { 0x02, 0x03, 0x03, (byte)0xF2, (byte)0xE6 };

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();
        berInteger.decode(byteBERInteger);

        assertEquals(bigInteger, berInteger.getASN1Integer());
    }

    @Test
    public void encodeUsingSetBERIntegerTest() throws ASN1Exception {
        byte[] byteInteger = { 0x03, (byte)0xF2, (byte)0xE6 };
        byte[] byteBERInteger = { 0x02, 0x03, 0x03, (byte)0xF2, (byte)0xE6 };

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();

        berInteger.setASN1Integer(bigInteger);

        assertArrayEquals(byteBERInteger, berInteger.encode());
    }

    @Test
    public void exceptionUsingSetBERIntegerTest() throws ASN1Exception {
        byte[] byteInteger = { 0x03, (byte)0xF2, (byte)0xE6 };
        byte[] byteBERInteger = { 0x02, 0x03, 0x03, (byte)0xF2, (byte)0xE6 };

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();
        berInteger.decode(byteBERInteger);

        assertEquals(bigInteger, berInteger.getASN1Integer());
    }

    @Test
    public void decodeUsingLongBERIntegerTest() throws ASN1Exception, IOException {
        Random rnd = new Random(1);
        byte[] byteInteger = new byte[1457];
        rnd.nextBytes(byteInteger);
        byte[] TAG = { 0x02 };
        byte[] lengthBytes = Utils.getLengthInBytes(byteInteger.length);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(TAG);
        baos.write(lengthBytes);
        baos.write(byteInteger);
        byte[] byteBERInteger = baos.toByteArray();

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();

        berInteger.decode(byteBERInteger);

        assertEquals(bigInteger, berInteger.getASN1Integer());
    }

    @Test
    public void encodeUsingLongBERIntegerTest() throws ASN1Exception, IOException {
        Random rnd = new Random(1);
        byte[] byteInteger = new byte[1457];
        rnd.nextBytes(byteInteger);
        byte[] TAG = { 0x02 };
        byte[] lengthBytes = Utils.getLengthInBytes(byteInteger.length);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(TAG);
        baos.write(lengthBytes);
        baos.write(byteInteger);
        byte[] byteBERInteger = baos.toByteArray();

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();

        berInteger.setASN1Integer(bigInteger);

        assertArrayEquals(byteBERInteger, berInteger.encode());
    }

    @Test(expected = ASN1Exception.class)
    public void decodeUsingLongBERIntegerExceptionTest() throws ASN1Exception, IOException {
        Random rnd = new Random(1);
        byte[] byteInteger = new byte[1457];
        rnd.nextBytes(byteInteger);
        byte[] TAG = { 0x02 };
        byte[] lengthBytes = Utils.getLengthInBytes(1548);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(TAG);
        baos.write(lengthBytes);
        baos.write(byteInteger);
        byte[] byteBERInteger = baos.toByteArray();

        BigInteger bigInteger = new BigInteger(byteInteger);
        BERInteger berInteger = new BERInteger();

        berInteger.decode(byteBERInteger);

        assertEquals(bigInteger, berInteger.getASN1Integer());
    }
}