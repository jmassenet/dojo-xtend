package dojo.xtend.kata3

import dojo.xtend.kata3.solution.JavaConverter
import dojo.xtend.kata3.solution.XtendConverter
import dojo.xtend.kata3.GeneralizedMeanifier$Converter
import dojo.xtend.kata3.GeneralizedMeanifier$ConverterException
import java.math.BigInteger
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static dojo.xtend.TestHelper.*
import static org.junit.Assert.*

/**
 * <h1>Xtend concepts</h1>
 * <ul>
 * <li>Dispatch methods</li>
 * <li>Switch expressions</li>
 * </ul>
 */
@RunWith(typeof(Parameterized))
class ConverterTest {
    val Converter converter
    
    new(Converter converter) {
        super()
        this.converter = converter
    }
    
    @Parameters
    def static data() {
         addRun(new JavaConverter) //
        .addRun(new XtendConverter) //
        .done
    }
    
    @Test
    def testConvertInteger() {
        assertEquals(42, converter.convert(42))
        assertEquals(-69, converter.convert(-69))
    }
    
    @Test
    def testConvertIntegerWrapper() {
        assertEquals(42, converter.convert(new IntegerWrapper('forty two', 42)))
        assertEquals(-69, converter.convert(new IntegerWrapper('minus sixty nine', -69)))
    }
    
    @Test
    def testConvertBigInteger() {
        assertEquals(42, converter.convert(new BigInteger('42')))
        assertEquals(-69, converter.convert(new BigInteger('-69')))
    }
    
    @Test
    def testConvertStringDecimal() {
        assertEquals(42, converter.convert('42'))
        assertEquals(-69, converter.convert('-69'))
    }
    
    @Test
    def testConvertStringHexadecimal() {
        assertEquals(42, converter.convert('0x2A'))
        assertEquals(-69, converter.convert('-0x45'))
    }
    
    @Test
    def testConvertStringOctal() {
        assertEquals(42, converter.convert('052'))
        assertEquals(-69, converter.convert('-0105'))
    }
    
    @Test
    def testConvertStringZeroIsNotOctal() {
        assertEquals(0, converter.convert('0'))
    }
    
    @Test(expected = typeof(ConverterException))
    def void testConvertStringEmpty() {
        converter.convert('')
    }
    
    @Test(expected = typeof(ConverterException))
    def void testConvertStringMinusOnly() {
        converter.convert('-')
    }
    
    @Test(expected = typeof(ConverterException))
    def void testConvertStringHexaPrefixOnly() {
        converter.convert('0x')
    }
    
    @Test(expected = typeof(ConverterException))
    def void testConvertStringInvalidFormat() {
        converter.convert('forty five')
    }
    
    @Test(expected = typeof(ConverterException))
    def void testConvertNull() {
        converter.convert(null)
    } 
    
    @Test(expected = typeof(ConverterException))
    def void testConvertUnsupported() {
        converter.convert(42L)
    }
}