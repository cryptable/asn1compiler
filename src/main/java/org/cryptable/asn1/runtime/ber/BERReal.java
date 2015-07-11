package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.ASN1Real;
import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.math.BigInteger;
import java.text.NumberFormat;

/**
 * The BER implementation of ASN1 Real values
 * Default will be binary encoding
 *
 * Created by david on 23/06/15.
 */
public class BERReal implements ASN1Real {

    private Encoding encoding = Encoding.ISO6093;

    private Double berDouble = 0.0;

    private String iso6093 = null;

    private ISO6093 iso6093Form = ISO6093.NR1;

    private Base base = Base.BASE_10;

    private SpecialRealValues specialRealValue = null;

    public Double getASN1Real() {
        return berDouble;
    }

    public void setASN1Real(Double value) throws ASN1Exception {
        setASN1RealAsString(berDouble.toString());
    }

    public void setASN1Real(Double berDouble, NumberFormat numberFormat) throws ASN1Exception {
        setASN1RealAsString(numberFormat.format(berDouble));
    }

    public Encoding getEncoding() {
        return encoding;
    }

    public void setASN1RealAsString(String berValue) throws ASN1Exception {
        this.encoding = Encoding.ISO6093;

        if (berValue.matches("^ *(\\+|-)?\\d\\d*$")) {
            this.iso6093Form = ISO6093.NR1;
        }
        else if (berValue.matches("^ *(\\+|-)?((\\d\\d*\\.\\d*)|(\\d*\\.\\d\\d*))$")) {
            this.iso6093Form = ISO6093.NR2;
        }
        else if (berValue.matches("^ *(\\+|-)?((\\d*\\.\\d\\d*)|(\\d*\\.\\d\\d*))(E|e)(\\+|-)?\\d\\d*")) {
            this.iso6093Form = ISO6093.NR3;
        }
        else {
            throw new ASN1Exception("Illegal ISO6093 format [" + berValue + "]");
        }
        this.berDouble = Double.valueOf(berValue);
        this.base = Base.BASE_10;
        this.iso6093 = berValue;
    }

    public void setSpecialRealValue(SpecialRealValues specialRealValue) {
        this.encoding = Encoding.SpecialRealValue;
        this.specialRealValue = specialRealValue;
        this.berDouble = null;
    }

    public SpecialRealValues getASN1SpecialRealValue() {
        return this.specialRealValue;
    }

    public boolean isIndefiniteLength() {
        return false;
    }

    public int getLength() throws ASN1Exception {
        int result;

        if (this.encoding == Encoding.BINARY) {
            // TODO Support Base 2, 8, 16 binary values
            throw new ASN1Exception("Base 2, 8, 16 is not supported");
        }
        else if (this.encoding == Encoding.ISO6093) {
            result = 1 // TAG
                    + Utils.calculateLengthByteLength(this.iso6093.length()) // nbr Length bytes
                    + 1 // Tag for the BERReal content
                    + this.iso6093.length(); // length of the content
        }
        else {
            result = 1  // TAG
                    + 1 // Length
                    + 1; // Content length
        }

        return result;
    }

    public byte[] encode() throws ASN1Exception {
        byte[] byteReal = new byte[getLength()];

        if (encoding == Encoding.BINARY) {
            // TODO Support Base 2, 8, 16 binary values
            throw new ASN1Exception("Base 2, 8, 16 is not supported");
        }
        else if (encoding == Encoding.ISO6093) {
            byte[] byteLength = Utils.getLengthInBytes(iso6093.toCharArray().length);
            byte[] byteValue = iso6093.getBytes();

            // TAG
            byteReal[0] = 0x09;
            // Length
            System.arraycopy(byteLength, 0, byteReal, 1, byteLength.length);
            // Value
            byteReal[1 + byteLength.length] = iso6093Form.getBitPattern();
            System.arraycopy(byteValue,
                    0,
                    byteReal,
                    1 + byteLength.length + 1,
                    byteValue.length);
        }
        else {
            // TAG
            byteReal[0] = 0x09;
            byteReal[1] = 0x01;
            byteReal[2] = specialRealValue.getBitPattern();

        }

        return byteReal;
    }

    private double convertDouble(byte[] value, int offset, int length) {
        byte doubleBytes[] = new byte[length - 1];

        System.arraycopy(value, offset, doubleBytes, 0, (length - 1));

        return Double.parseDouble(new String(doubleBytes));
    }

    public void decode(byte[] value) throws ASN1Exception {
        int offset = 0;

        if (value.length < 3)
            throw new ASN1Exception("Wrong BERReal minimal length [" + value.length + "]");

        // TAG
        if (value[0] != 0x09)
            throw new ASN1Exception("Wrong BERReal tag value [" + value[0] + "]");
        offset += 1;

        // Length
        int length;

        if ((value[1] & 0x80) == 0x80) {
            int lengthLength = value[1] & 0x7F;

            length = Utils.getLengthOfBytes(value, lengthLength);

            offset += lengthLength;
        }
        else {
            length = value[1];

            offset += 1;
        }

        // Test on Base 2, 8, 16
        if ((length >= 1) && ((value[offset] & 0x80) == 0x80)) {
            throw new ASN1Exception("Base 2, 8, 16 not supported.");
        }
        // Test Special value & set SpecialValue
        else if ((length == 1) && ((value[offset] & 0xC0) == 0x40)) {

            switch (value[offset]) {
                // 0x40 -> PLUS-INFINITY
                case 0x40 :
                    this.encoding = Encoding.SpecialRealValue;
                    this.specialRealValue = SpecialRealValues.PLUS_INFINITY;
                    this.berDouble = Double.POSITIVE_INFINITY;
                    break;
                // 0x41 -> MINUS-INFINITY
                case 0x41 :
                    this.encoding = Encoding.SpecialRealValue;
                    this.specialRealValue = SpecialRealValues.MINUS_INFINITY;
                    this.berDouble = Double.NEGATIVE_INFINITY;
                    break;
                // 0x42 -> NOT-A-NUMBER
                case 0x42 :
                    this.encoding = Encoding.SpecialRealValue;
                    this.specialRealValue = SpecialRealValues.NOT_A_NUMBER;
                    this.berDouble = Double.NaN;
                    break;
                // 0x43 -> MINUS-ZERO
                case 0x43 :
                    this.encoding = Encoding.SpecialRealValue;
                    this.specialRealValue = SpecialRealValues.MINUS_ZERO;
                    break;
                default:
                    throw new ASN1Exception("Unknown SpecialRealValue [" + value[2] + "]");
            }
        }
        // ISO 6093
        else {
            switch (value[offset]) {
                case 0x01:
                    this.iso6093Form = ISO6093.NR1;
                    break;
                case 0x02:
                    this.iso6093Form = ISO6093.NR2;
                    break;
                case 0x03:
                    this.iso6093Form = ISO6093.NR3;
                    break;
                default:
                    throw new ASN1Exception("Unknown type of ISO 6093 [" + value[2] + "]");
            }
            offset += 1;
            this.encoding = Encoding.ISO6093;
            this.berDouble = convertDouble(value, offset, length);
        }
    }
}
