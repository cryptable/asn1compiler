package org.cryptable.asn1.runtime;

import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.text.NumberFormat;


/**
 * Interface of the ASN1Real
 *
 * Created by david on 23/06/15.
 */
public interface ASN1Real extends ASN1Object {

    enum Encoding {
        // TODO Support Base 2, 8, 16 binary values
        BINARY,
        ISO6093,
        SpecialRealValue
    }

    enum Base {
        BASE_10,
        BASE_2,
        BASE_8,
        BASE_16
    }

    enum SpecialRealValues {
        PLUS_INFINITY((byte)0x40),
        MINUS_INFINITY((byte)0x41),
        NOT_A_NUMBER((byte)0x42),
        MINUS_ZERO((byte)0x43);

        private byte bitPattern = 0;

        SpecialRealValues(byte bitPattern) { this.bitPattern = bitPattern; }

        public byte getBitPattern() {
            return bitPattern;
        }

    }

    enum ISO6093 {
        NR1((byte)0x01),
        NR2((byte)0x02),
        NR3((byte)0x03);

        private byte bitPattern = 0;

        ISO6093(byte bitPattern) { this.bitPattern = bitPattern; }

        public byte getBitPattern() {
            return bitPattern;
        }

    }

    /**
     * Get the Integer value
     *
     * @return ASN1 integer value as BigInteger
     */
    Double getASN1Real();

    /**
     * Set the ASN1 Real number binary format as Base 10
     *
     * @param berDouble the ASN1 Real to be set
     * @throws ASN1Exception
     */
    void setASN1Real(Double berDouble) throws ASN1Exception;

    /**
     * Set the ASN1 Real number with specified Number Format
     *
     * @param berDouble     the double value to be encoded
     * @param numberFormat  number format to use in string encoding
     * @throws ASN1Exception
     */
    void setASN1Real(Double berDouble, NumberFormat numberFormat) throws ASN1Exception;

    /**
     * Get the Encoding mechanism of the BERREAL
     *
     * @return return one of the encoding value of the REAL
     */
    Encoding getEncoding();

    /**
     * Set the REAL as ISO 6093 format. The string must be on of following formats as base 10
     *
     * digit            = 0| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
     * sign             = + | –
     * decimal-mark     = , | .
     * space            = " "
     * exponent-mark    = E | e
     *
     * NR1 = unsigned-NR1 | signed-NR1
     *      unsigned-NR1 = space* digit digit*
     *      signed-NR1 = space* (sign|space) digit digit*
     *      example: "+004902"
     * NR2 = unsigned-NR2 | signed-NR2
     *      unsigned-NR2 = (space* digit digit* decimal-mark digit*) |
     *                     (space* digit* decimal-mark digit digit*)
     *      signed-NR2 = (space* (sign/space) digit digit* decimal-mark digit*) |
     *                   (space* (sign/space) digit* decimal-mark digit digit*)
     *      example: "  +1327.00"
     * NR3 = unsigned-NR3 | signed-NR3
     *      unsigned-NR3= space* significand exponent-mark exponent
     *      signed-NR3 = space* (sign|space) significand exponent-mark exponent
     *      significand = (digit digit* decimal-mark digit*) |
     *                    (digit* decimal-mark digit digit*)
     *      exponent = sign? digit digit*
     *      example: "  +5.6e+03"
     *
     * @param berValue set the ASN1 Real as a string
     */
    void setASN1RealAsString(String berValue) throws ASN1Exception;

    /**
     * Set the REAL as a SpecialRealValue
     *
     * @param specialRealValue one of the enum of SpecialRealValue enum
     */
    void setSpecialRealValue(SpecialRealValues specialRealValue);

    /**
     * If getASN1Real throw ASN1NotADoubleValue, then it is a SpecialRealValue
     *
     * @return one of the SpecialRealValues
     */
    SpecialRealValues getASN1SpecialRealValue();
}
