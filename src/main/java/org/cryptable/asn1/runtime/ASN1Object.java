package org.cryptable.asn1.runtime;

import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.io.ByteArrayOutputStream;

/**
 * The ASN1 main object for which 2 functions need to be implmented
 *
 * Created by david on 6/20/15.
 */
public interface ASN1Object {

    /**
     * encode function to encode the ASN1 value
     *
     * @return the value of the ASN1 Object
     */
    byte[] encode();

    /**
     * decode function to decode the ASN1 value
     *
     * @param value binary value to be decoded
     */
    void decode(byte[] value) throws ASN1Exception;
}
