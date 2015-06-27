package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.math.BigInteger;

/**
 * Utils class with general utilities for ASN1 processing
 *
 * Created by david on 6/20/15.
 */
public class Utils {

    /**
     * get the TAG from the byteArray
     *
     * @param value bytae array containing the TAG Length Value
     * @return return Integer value of the TAG
     * @throws ASN1Exception when unsupported ASN1 TAG (greater then 31)
     */
    public static int getTAG(byte[] value) throws ASN1Exception {

        if ((int)value[0] > 31)
            throw new ASN1Exception("Not yet supported TAGs [" + (int)value[0] + "]");

        return value[0];
    }

    /**
     * Calculate the TAG length for the bytes
     *
     * @param tag TAG parameter
     * @return byte length to allocate for the TAG
     */
    public static int calculateTAGByteLength(long tag) {
        if (tag >= 31)
            return 2;
        else
            return 1;
    }

    /**
     * Calculate the Length length for the bytes
     *
     * @param length The length of the value in bytes
     * @return the byte length to allocate for the Length
     * @throws ASN1Exception
     */
    public static int calculateLengthByteLength(int length) throws ASN1Exception {
        if (length < 0)
            throw new ASN1Exception("Invalid length (NEGATIVE)");

        if (length <= 127) {
            return 1;
        }
        else {
            return (BigInteger.valueOf(length).toByteArray().length + 1);
        }
    }

    /**
     * Get the Length as bytes to be filled in the BER value
     *
     * @param length Length value as an integer
     * @return bytes containing the Length value
     * @throws ASN1Exception
     */
    public static byte[] getLengthInBytes(int length) throws ASN1Exception {
        if (length < 0)
            throw new ASN1Exception("Invalid length (NEGATIVE)");

        if (length <= 127) {
            return BigInteger.valueOf(length).toByteArray();
        }
        else {
            byte[] value = BigInteger.valueOf(length).toByteArray();
            byte[] result = new byte[value.length+1];
            byte byteLength = (byte) (0x80 | (byte)value.length);
            result[0] = byteLength;
            System.arraycopy(value, 0, result, 1, value.length);
            return result;
        }
    }
}
