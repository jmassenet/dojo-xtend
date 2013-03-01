package dojo.xtend.kata3.solution;

import com.google.common.base.Optional;

import dojo.xtend.kata2.solution.JavaMeanifier;
import dojo.xtend.kata3.GeneralizedMeanifier;

public class JavaGeneralizedMeanifier extends JavaMeanifier implements GeneralizedMeanifier {

    @Override
    public Optional<Integer> process(Converter converter, Object... values) throws IllegalArgumentException {
        int[] intValues = new int[values.length];
        for (int i = 0; i < values.length; i++) {
            intValues[i] = converter.convert(values[i]);
        }
        return process(intValues);
    }

    @Override
    public GeneralizedMeanifier withFilter(final GeneralizedMeanifier.Filter inFilter) {
        if (inFilter == null) {
            return withoutFilter();
        }
        this.filter = new JavaMeanifier.Filter() {
            @Override
            public boolean isAcceptable(int value) {
                return inFilter.isApplicable(value);
            }
        };
        return this;
    }

    @Override
    public GeneralizedMeanifier filterByRange(final int lower, final int higher) {
        return (GeneralizedMeanifier) super.filterByRange(lower, higher);
    }

    @Override
    public GeneralizedMeanifier filterByMultiple(final int multiple) {
        return (GeneralizedMeanifier) super.filterByMultiple(multiple);
    }

    @Override
    public GeneralizedMeanifier withoutFilter() {
        return (GeneralizedMeanifier) super.withoutFilter();
    }

}
