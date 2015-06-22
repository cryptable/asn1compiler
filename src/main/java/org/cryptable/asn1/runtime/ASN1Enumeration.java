package org.cryptable.asn1.runtime;

import java.math.BigInteger;

/**
 * ASN1Integer interface to implement the ASN1 integer
 *
 * Created by david on 6/20/15.
 */
public interface ASN1Enumeration extends ASN1Integer {

    /**
     * Insert an enumeration value to the enumeration
     *
     * @return ASN1 integer value as BigInteger
     */
    void addEnumeration(BigInteger integer);

}
