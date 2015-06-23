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

    @Test
    public void laymansguideEncodeBERIntegerTest() throws ASN1Exception, IOException {
        byte[] byteBERInteger0 = { 0x02, 0x01, 0x00 };
        BigInteger bigInteger0 = BigInteger.ZERO;
        byte[] byteBERInteger127 = { 0x02, 0x01, 0x7F };
        BigInteger bigInteger127 = BigInteger.valueOf(127);
        byte[] byteBERInteger128 = { 0x02, 0x02, 0x00, (byte)0x80 };
        BigInteger bigInteger128 = BigInteger.valueOf(128);
        byte[] byteBERInteger256 = { 0x02, 0x02, 0x01, 0x00 };
        BigInteger bigInteger256 = BigInteger.valueOf(256);
        byte[] byteBERIntegerMin128 = { 0x02, 0x01, (byte)0x80 };
        BigInteger bigIntegerMin128 = BigInteger.valueOf(-128);
        byte[] byteBERIntegerMin129 = { 0x02, 0x02, (byte)0xFF, (byte)0x7F };
        BigInteger bigIntegerMin129 = BigInteger.valueOf(-129);

        BERInteger berInteger0 = new BERInteger(bigInteger0);
        BERInteger berInteger127 = new BERInteger(bigInteger127);
        BERInteger berInteger128 = new BERInteger(bigInteger128);
        BERInteger berInteger256 = new BERInteger(bigInteger256);
        BERInteger berIntegerMin128 = new BERInteger(bigIntegerMin128);
        BERInteger berIntegerMin129 = new BERInteger(bigIntegerMin129);

        assertArrayEquals(byteBERInteger0, berInteger0.encode());
        assertArrayEquals(byteBERInteger127, berInteger127.encode());
        assertArrayEquals(byteBERInteger128, berInteger128.encode());
        assertArrayEquals(byteBERInteger256, berInteger256.encode());
        assertArrayEquals(byteBERIntegerMin128, berIntegerMin128.encode());
        assertArrayEquals(byteBERIntegerMin129, berIntegerMin129.encode());
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