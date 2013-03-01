package dojo.xtend.kata3

import dojo.xtend.kata3.solution.JavaConverter
import dojo.xtend.kata3.solution.JavaGeneralizedMeanifier
import dojo.xtend.kata3.solution.XtendConverter
import dojo.xtend.kata3.solution.XtendGeneralizedMeanifier
import dojo.xtend.kata3.GeneralizedMeanifier$Converter
import dojo.xtend.kata3.GeneralizedMeanifier$ConverterException
import java.math.BigInteger
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static dojo.xtend.TestHelper.*
import static org.junit.Assert.*
import org.junit.Before

/**
 * <h1>Xtend concepts</h1>
 * <ul>
 * <li>Casting</li>
 * </ul>
 */
@RunWith(typeof(Parameterized))
class GeneralizedMeanifierTest {
    val GeneralizedMeanifier meanifier
    val Converter converter
    
    new(GeneralizedMeanifier meanifier, Converter converter) {
        super()
        this.meanifier = meanifier
        this.converter = converter
    }
    
    @Parameters
    def static data() {
         addRun(new JavaGeneralizedMeanifier, new JavaConverter) //
        .addRun(new XtendGeneralizedMeanifier, new XtendConverter) //
        .done
    }
    
    @Before
    def void setUp() {
        meanifier.withoutFilter
    }
    
    @Test
    def testWithFilter() {
        val result = meanifier.withFilter[it >= 0].process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(26, result.get)
    }
    
    @Test
    def testWithNullFilter() {
        val result = meanifier.withFilter(null).process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(-13, result.get)
    }
    
    @Test
    def testProcess() {
        val result = meanifier.process(converter, -25, new IntegerWrapper('unlucky', 13), "-0x2A", new BigInteger("1"), "072", "33", -98, -51)
        assertTrue(result.present)
        assertEquals(-13, result.get)
    }
    
    @Test
    def void testProcessEmpty() {
        assertFalse(meanifier.process(converter).present)
    }
    
    @Test(expected = typeof(ConverterException))
    def void testProcessErroneousValue() {
        meanifier.process(converter, -25, new IntegerWrapper('unlucky', 13), "-0x2A", new BigInteger("1"), "072", "33", -98, -51, 'wrong')
    }
}