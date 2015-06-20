package org.cryptable.asn1.runtime;

/**
 * ASN1 Boolean interface
 */
public interface ASN1Boolean extends ASN1Object {

    /**
     * Get the value of the ASN1 boolean value
     *
     * @return return the ASN1 boolean value
     */
    boolean getASN1Boolean();

    /**
     * Set the value of the ASN1 boolean value
     *
     * @param asn1Boolean boolean value to set
     */
    void setASN1Boolean(final boolean asn1Boolean);
}
