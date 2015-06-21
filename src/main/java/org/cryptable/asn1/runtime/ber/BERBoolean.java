package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.ASN1Boolean;
import org.cryptable.asn1.runtime.exception.ASN1Exception;

/**
 * BERBoolean is the BER implementation of ASN1Boolean
 *
 * Created by david on 6/13/15.
 */
public class BERBoolean implements ASN1Boolean {

    private boolean asn1Boolean;

    /**
     * get boolean value
     * @return returns the boolean value of BER boolean
     */
    public boolean getASN1Boolean() {
        return asn1Boolean;
    }

    /**
     * set the boolean value
     *
     * @param asn1Boolean boolean value to set
     */
    public void setASN1Boolean(final boolean asn1Boolean) {
        this.asn1Boolean = asn1Boolean;
    }

    /**
     * default constructor, default false
     */
    public BERBoolean() {
        this.asn1Boolean = false;
    }

    /**
     * parameterized constructor
     *
     * @param value set boolean value with construction
     */
    public BERBoolean(final boolean value) {
        this.asn1Boolean = value;
    }

    /**
     * check if the length is indefinite (used in BER objects)
     *
     * @return the value of the indefinite length
     */
    public boolean isIndefiniteLength() {
        return false;
    }

    /**
     * Get length for BER encoded Boolean
     *
     * @return This will return 3
     */
    public int getLength() {
        return 3;
    }

    /**
     * BER encoding of the boolean value
     * true: 0x01|0x01|0xFF
     * false: 0x01|Ox01|0x00
     *
     * @return 3 bytes 0x01|0x01|value
     */
    public byte[] encode() {
        byte[] value = { 0x01, 0x01, 0x00 };

        if (asn1Boolean) {
            value[2] = (byte) 0xFF;
        }

        return value;
    }

    /**
     * BER decoding of the boolean array
     *
     * @param value binary value to be decoded
     * @throws ASN1Exception
     */
    public void decode(byte[] value) throws ASN1Exception {

        if (value[0] != 0x01)
            throw new ASN1Exception("Wrong BERBoolean tag value [" + value[0] + "]");

        if (value[1] != 0x01)
            throw new ASN1Exception("Wrong BERBoolean length value [" + value[1] + "]");

        this.asn1Boolean = value[2] != 0x00;
    }
}
