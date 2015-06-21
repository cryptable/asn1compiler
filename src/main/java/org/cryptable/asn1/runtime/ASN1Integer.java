package org.cryptable.asn1.runtime;

import java.math.BigInteger;

/**
 * ASN1Integer interface to implement the ASN1 integer
 *
 * Created by david on 6/20/15.
 */
public interface ASN1Integer extends ASN1Object {

    /**
     * Get the Integer value
     *
     * @return ASN1 integer value as BigInteger
     */
    BigInteger getASN1Integer();

    /**
     * Set the ASN1 Integer
     *
     * @param bigInteger The ASN1 integer as BigInteger to be set
     */
    void setASN1Integer(BigInteger bigInteger);
}
