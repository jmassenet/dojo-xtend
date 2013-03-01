package dojo.xtend.kata2

import dojo.xtend.kata2.solution.JavaMeanifier
import dojo.xtend.kata2.solution.XtendMeanifier
import java.io.IOException
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static dojo.xtend.TestHelper.*
import static org.junit.Assert.*
import dojo.xtend.kata2.Meanifier
import org.junit.Before

/**
 * <h1>Xtend concepts</h1>
 * <ul>
 * <li>Constructor</li>
 * <li>Variables definition</li>
 * <li>Type inference</li>
 * <li>Extension methods</li>
 * <li>Closures</li>
 * <li>Control structures as expressions</li>
 * </ul>
 */
@RunWith(typeof(Parameterized))
class MeanifierTest {
    val Meanifier meanifier
    
    new(Meanifier meanifier) {
        super()
        this.meanifier = meanifier
    }
    
    @Parameters
    def static data() {
         addRun(new JavaMeanifier) //
        .addRun(new XtendMeanifier) //
        .done
    }
    
    @Before
    def void setUp() {
        meanifier.withoutFilter
    }

    @Test
    def testProcessNoFilter() throws IOException {
        val result = meanifier.process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(-13, result.get)
    }
    
    @Test
    def testProcessEmptyInput() throws IOException {
        val result = meanifier.process()
        assertFalse(result.present)
    }
    
    @Test
    def testProcessRangeFilter() throws IOException {
        val result = meanifier.filterByRange(-25, 25).process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(-3, result.get)
    }
    
    @Test
    def testProcessMultipleFilter() throws IOException {
        val result = meanifier.filterByMultiple(2).process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(-27, result.get)
    }
    
    @Test
    def testProcessWithoutFilter() {
        val result = meanifier.filterByMultiple(2).withoutFilter.process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertTrue(result.present)
        assertEquals(-13, result.get)
    }
    
    @Test
    def testFilterAllElements() {
        val result = meanifier.filterByRange(1000, 1500).process(-25, 13, -42, 1, 58, 33, -98, -51)
        assertFalse(result.present)
    }
}
