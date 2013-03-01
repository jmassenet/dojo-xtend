package dojo.xtend.kata2.solution

import dojo.xtend.kata2.Meanifier
import com.google.common.base.Optional

class XtendMeanifier implements Meanifier {
    protected var (int)=>boolean filter

    new() {
        super()
        withoutFilter
    }
    
    override process(int ... values) {
        val filteredValues = values.filter(filter)
        
        if (filteredValues.empty) {
            Optional::absent
        } else {
            Optional::of(filteredValues.reduce[sum, value | sum + value] / filteredValues.size)
        }
    }
    
    override Meanifier filterByRange(int lower, int higher) {
        filter = [it >= lower && it <= higher]
        this
    }
    
    override Meanifier filterByMultiple(int multiple) {
        filter = [(it % multiple) == 0]
        this
    }
    
    override Meanifier withoutFilter() {
        filter = [true]
        this
    }
}