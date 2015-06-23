package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.ASN1Integer;
import org.cryptable.asn1.runtime.exception.ASN1Exception;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

/**
 * DER Implementation of the ASN1Enumeration
 *
 * Created by david on 6/20/15.
 */
public class BEREnumeration extends BERInteger implements ASN1Integer {

    private List<BigInteger> enumeration;

    public BEREnumeration() {
        super();
        enumeration = new ArrayList<BigInteger>();
    }

    void addEnumeration(BigInteger integer) {
        enumeration.add(integer);
    };

    @Override
    public void setASN1Integer(BigInteger bigInteger) throws ASN1Exception {
        if (enumeration.contains(bigInteger))
            super.setASN1Integer(bigInteger);
        else
            throw new ASN1Exception("Integer is not value of enumeration [" + bigInteger.toString(10) + "]");
    }

    @Override
    public void decode(byte[] value) throws ASN1Exception {
        super.decode(value);
        if (!enumeration.contains(getASN1Integer())) {
            throw new ASN1Exception("Integer is not value of enumeration [" + super.getASN1Integer() + "]");
        }
    }
}
