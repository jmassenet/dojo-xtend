package dojo.xtend.kata2;

import com.google.common.base.Optional;

/**
 * Computes the mean value of a series of integer values.
 * 
 * At most one filter at a time can be applied before the values are processed.
 */
public interface Meanifier {
    /**
     * Compute the mean of the given values.
     * 
     * @param values
     *            The values to compute the mean from (can be empty but never null)
     * @return The computed mean, or no value if there were no input values or they were all
     *         filtered out.
     */
    Optional<Integer> process(int... values);

    /**
     * Installs a range filter. Any value not within the range is ignored when
     * {@link #process(int...)} is called.
     * 
     * @param lower
     *            The lower bound of the range, inclusive.
     * @param higher
     *            The higher bound of the range, inclusive.
     * @return The current instance.
     */
    Meanifier filterByRange(final int lower, final int higher);

    /**
     * Installs a multiple filter. Any value which is not a multiple of the given parameter is
     * ignored when {@link #process(int...)} is called.
     * 
     * @param multiple
     *            The multiple to filter by.
     * @return The current instance.
     */
    Meanifier filterByMultiple(final int multiple);

    /**
     * Removes installed filter.
     * 
     * @return The current instance.
     */
    Meanifier withoutFilter();
}
