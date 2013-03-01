package dojo.xtend.kata3.solution

import dojo.xtend.kata2.solution.XtendMeanifier
import dojo.xtend.kata3.GeneralizedMeanifier
import dojo.xtend.kata3.GeneralizedMeanifier$Converter
import dojo.xtend.kata3.GeneralizedMeanifier$ConverterException
import dojo.xtend.kata3.GeneralizedMeanifier$Filter

class XtendGeneralizedMeanifier extends XtendMeanifier implements GeneralizedMeanifier {

    override process(Converter converter, Object... values) throws ConverterException {
        process(values.map [converter.convert(it)] as int[])
    }

    override withFilter(GeneralizedMeanifier$Filter inFilter) {
        if (inFilter == null) {
            withoutFilter
        } else {
            this.filter = [inFilter.isApplicable(it)]
            this
        }
    }

    override GeneralizedMeanifier filterByRange(int lower, int higher) {
        super.filterByRange(lower, higher) as GeneralizedMeanifier
    }

    override GeneralizedMeanifier filterByMultiple(int multiple) {
        super.filterByMultiple(multiple) as GeneralizedMeanifier
    }

    override GeneralizedMeanifier withoutFilter() {
        super.withoutFilter as GeneralizedMeanifier
    }

}
