package dojo.xtend.kata2.solution;

import com.google.common.base.Optional;

import dojo.xtend.kata2.Meanifier;

public class JavaMeanifier implements Meanifier {
    protected Filter filter;
    
    @Override
    public Optional<Integer> process(int ... values) {
        int sum = 0;
        int nbElements = 0;
        
        for (int value : values) {
            if (filter != null && !filter.isAcceptable(value)) {
                continue;
            }
            sum += value;
            nbElements++;
        }
        
        if (nbElements == 0) {
            return Optional.absent();
        }
        
        return Optional.of(sum / nbElements);
    }
    
    @Override
    public Meanifier filterByRange(final int lower, final int higher) {
        filter = new Filter() {
            @Override
            public boolean isAcceptable(int value) {
                return value >= lower && value <= higher;
            }
        };
        return this;
    }
    
    @Override
    public Meanifier filterByMultiple(final int multiple) {
        filter = new Filter() {
            @Override
            public boolean isAcceptable(int value) {
                return (value % multiple) == 0;
            }
        };
        return this;
    }
    
    @Override
    public Meanifier withoutFilter() {
        filter = null;
        return this;
    }
    
    protected interface Filter {
        boolean isAcceptable(int value);
    }
    
}
