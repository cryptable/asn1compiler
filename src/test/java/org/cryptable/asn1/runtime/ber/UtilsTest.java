package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Test class which tests the BER utilities
 *
 * Created by david on 6/20/15.
 */
public class UtilsTest {

    @Test
    public void testCalcutateTAGByteLength() {

        assertEquals(1, Utils.calculateTAGByteLength(30));
        assertEquals(2, Utils.calculateTAGByteLength(31));
    }

    @Test
    public void testCalcutateLengthByteLength() throws ASN1Exception {

        assertEquals(1, Utils.calculateLengthByteLength(127));
        assertEquals(2, Utils.calculateLengthByteLength(128));
        assertEquals(3, Utils.calculateLengthByteLength(127 * 256 + 255));
        assertEquals(3, Utils.calculateLengthByteLength(128 * 256));
        assertEquals(4, Utils.calculateLengthByteLength(127 * 256 * 256 + 256 * 255 + 255));
        assertEquals(4, Utils.calculateLengthByteLength(128 * 256 * 256));
    }
}