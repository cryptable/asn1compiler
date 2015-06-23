package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.ASN1Integer;
import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.math.BigInteger;

/**
 * DER Implementation of the ASN1Integer
 * Created by david on 6/20/15.
 */
public class BERInteger implements ASN1Integer {

    private BigInteger bigInteger;

    public BERInteger() {
        this(BigInteger.valueOf(0));
    }

    public BERInteger(BigInteger bigInteger) {
        this.bigInteger = bigInteger;
    }

    public BigInteger getASN1Integer() {
        return bigInteger;
    }

    public void setASN1Integer(BigInteger bigInteger) throws ASN1Exception {
        this.bigInteger = bigInteger;
    }

    public boolean isIndefiniteLength() {
        return false;
    }

    public int getLength() throws ASN1Exception {
        int bodyLength = bigInteger.toByteArray().length;

        return bodyLength + Utils.calculateTAGByteLength(2L) + Utils.calculateLengthByteLength(bodyLength);
    }

    public byte[] encode() throws ASN1Exception {
        byte[] byteInteger = new byte[getLength()];
        byte[] byteTag = { 0x02 };
        byte[] byteLength = Utils.getLengthInBytes(bigInteger.toByteArray().length);
        byte[] byteValue = bigInteger.toByteArray();

        // TAG
        System.arraycopy(byteTag, 0, byteInteger, 0, byteTag.length);
        // Length
        System.arraycopy(byteLength, 0, byteInteger, 1, byteLength.length);
        // Value
        System.arraycopy(byteValue, 0, byteInteger, 1 + byteLength.length, byteValue.length);

        return byteInteger;
    }

    public void decode(byte[] value) throws ASN1Exception {

        int offset = 0;

        if (value.length < 3)
            throw new ASN1Exception("Wrong BERInteger minimal length [" + value.length + "]");

        // TAG
        if (value[0] != 0x02)
            throw new ASN1Exception("Wrong BERInteger tag value [" + value[0] + "]");
        offset += 1;

        // Length
        int length = 0;

        if ((value[1] & 0x80) == 0x80) {
            int lengthLength = value[1] & 0x7F;

            if (lengthLength > 4)
                throw new ASN1Exception("Unsupported BERInteger length value [" + lengthLength + "] for this ASN1 implementation");

            if ((value.length - 2) < lengthLength)
                throw new ASN1Exception("BERInteger length value does not fit BER value  [" + value.length + ":" + lengthLength + "]");

            byte[] lengthValue = new byte[lengthLength];
            System.arraycopy(value, 2, lengthValue, 0, lengthLength);
            BigInteger bigInteger = new BigInteger(lengthValue);
            if (bigInteger.longValue() < 0)
                throw new ASN1Exception("Unsupported BERInteger length value [" + bigInteger.toString(10) + "]");

            length = bigInteger.intValue();

            // value.length - TAG + LENGTH length + LENGTH value must be equal to the length
            if ((value.length - (1 + 1 + lengthLength)) != length)
                throw new ASN1Exception("Wrong BERInteger byte array length [" + (value.length - (1 + 1 + lengthLength)) + ":" + length + "]");
            offset += (1 + lengthLength);
        }
        else {
            length = value[1];
            // value.length - TAG + LENGTH value must be equal to the length
            if ((value.length - (1 + 1)) != length)
                throw new ASN1Exception("Wrong BERInteger byte array length [" + value.length + ":" + length + "]");
            offset += 1;
        }

        // Value
        byte[] integerBytes = new byte[length];
        System.arraycopy(value, offset, integerBytes, 0, length);

        bigInteger = new BigInteger(integerBytes);
    }
}
