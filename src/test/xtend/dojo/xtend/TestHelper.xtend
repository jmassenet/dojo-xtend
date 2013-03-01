package dojo.xtend

import java.util.ArrayList
import java.util.Collection

abstract class TestHelper {
    def static addRun(Object ... cstrArgs) {
        return new ParametersBuilder(cstrArgs);
    }
}

class ParametersBuilder {
    private val Collection<Object[]> result = new ArrayList<Object[]>();
    
    new(Object ... cstrArgs) {
        super();
        addRun(cstrArgs);
    }
    
    def addRun(Object ... cstrArgs) {
        result.add(cstrArgs);
        return this;
    }
    
    def done() {
        return result;
    }
}