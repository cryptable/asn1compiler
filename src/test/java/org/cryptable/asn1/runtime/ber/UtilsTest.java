package org.cryptable.asn1.runtime.ber;

import org.cryptable.asn1.runtime.exception.ASN1Exception;
import org.junit.Rule;
import org.junit.Test;
import org.junit.internal.runners.statements.ExpectException;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

/**
 * Test class which tests the BER utilities
 *
 * Created by david on 6/20/15.
 */
public class UtilsTest {

    @Test
    public void testCalculateTAGByteLength() {

        assertEquals(1, Utils.calculateTAGByteLength(30));
        assertEquals(2, Utils.calculateTAGByteLength(31));
    }

    @Test
    public void testCalculateLengthByteLength() throws ASN1Exception {

        assertEquals(1, Utils.calculateLengthByteLength(127));
        assertEquals(3, Utils.calculateLengthByteLength(128));
        assertEquals(3, Utils.calculateLengthByteLength(127 * 256 + 255));
        assertEquals(4, Utils.calculateLengthByteLength(128 * 256));
        assertEquals(4, Utils.calculateLengthByteLength(127 * 256 * 256 + 256 * 255 + 255));
        assertEquals(5, Utils.calculateLengthByteLength(128 * 256 * 256));
    }

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    @Test
    public void testExceptionGetNegativeLengthInBytes() throws ASN1Exception {

        expectedException.expect(ASN1Exception.class);
        expectedException.expectMessage("Invalid length (NEGATIVE)");

        byte[] lengthBytes = Utils.getLengthInBytes(-1);
    }

    @Test
    public void testExceptionCalculateNegativeLengthByteLength() throws ASN1Exception {

        expectedException.expect(ASN1Exception.class);
        expectedException.expectMessage("Invalid length (NEGATIVE)");

        int length = Utils.calculateLengthByteLength(-1);
    }
}