package dojo.xtend.kata1

import dojo.xtend.kata1.solution.JavaGreeter
import dojo.xtend.kata1.solution.XtendGreeter
import java.io.IOException
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static dojo.xtend.TestHelper.*
import static org.junit.Assert.*

/**
 * <h1>Xtend concepts</h1>
 * <ul>
 * <li>Package declaration</li>
 * <li>Class definition</li>
 * <li>Method definition</li>
 * <li>String literal</li>
 * </ul>
 *  
 */
@RunWith(typeof(Parameterized))
class GreeterTest {
    val Greeter greeter
    
    new(Greeter greeter) {
        super()
        this.greeter = greeter
    }

    @Parameters
    def static data() {
         addRun(new JavaGreeter) //
        .addRun(new XtendGreeter) //
        .done
    }

    @Test
    def testSayHello() throws IOException {
        assertEquals("Hello world!", greeter.sayHello)
    }
}
