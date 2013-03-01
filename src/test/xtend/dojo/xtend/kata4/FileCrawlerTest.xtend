package dojo.xtend.kata4

import dojo.xtend.kata4.solution.JavaFileCrawler
import dojo.xtend.kata4.solution.XtendFileCrawler
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static dojo.xtend.TestHelper.*
import static org.junit.Assert.*

/**
 * <h1>Xtend concepts</h1>
 * <ul>
 * <li>Operator overloading</li>
 * <li>Data annotation</li>
 * </ul>
 */
@RunWith(typeof(Parameterized))
class FileCrawlerTest {
    val FileCrawler crawler
    
    new(FileCrawler crawler) {
        super();
        this.crawler = crawler
    }
    
    @Parameters
    def static data() {
         addRun(new JavaFileCrawler) //
        .addRun(new XtendFileCrawler) //
        .done
    }
    
    @Test
    def void testGetView() {
        val expected = //
              "materials\n" //
            + "  dir1\n" //
            + "    + file-1-1.java  (13)\n" //
            + "    + file-1-2.xtend  (94)\n" //
            + "  dir2\n" //
            + "    + file-2-1  (80)\n" //
            + "  + file-1.txt  (10)\n" //
            + "  + file-2.java  (76)\n";
        assertEquals(expected, crawler.getDirectoryTree('src/test/materials').view)
    }
    
    @Test
    def void testGetViewFiltered() {
        val expected = //
              "materials\n" //
            + "  dir1\n" //
            + "    + file-1-1.java  (13)\n" //
            + "  dir2\n" //
            + "  + file-2.java  (76)\n";
        assertEquals(expected, crawler.getDirectoryTree('src/test/materials', [
            directory || name.endsWith('.java')
        ]).view)
    }
}