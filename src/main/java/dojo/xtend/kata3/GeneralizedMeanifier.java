package dojo.xtend.kata3;

import java.math.BigInteger;

import com.google.common.base.Optional;

import dojo.xtend.kata2.Meanifier;

/**
 * Computes the mean value of a series of integer values.
 * 
 * At most one filter at a time can be applied before the values are processed.
 */
public interface GeneralizedMeanifier extends Meanifier {
    /**
     * Apply {@link #process(int...)} to the given input objects, converting them with the given
     * converter.
     * 
     * @param converter
     *            The converter to use to transform the objects into their integer representation
     *            (cannot be null).
     * @param values
     *            The values to compute the mean from (can be empty but never null)
     * @return The computed mean, or no value if there were no input values or they were all
     *         filtered out.
     * @throws IllegalArgumentException
     *             If a value cannot be converted to an integer.
     */
    Optional<Integer> process(Converter converter, Object... values) throws IllegalArgumentException;

    /**
     * Set a custom filter to use with the {@link #process(int...)} operation.
     * 
     * @param filter
     *            The filter to use. If <code>null</code>, behaves as if {@link #withoutFilter()}
     *            was called
     * @return The current instance.
     */
    GeneralizedMeanifier withFilter(final Filter filter);

    @Override
    GeneralizedMeanifier filterByRange(final int lower, final int higher);

    @Override
    GeneralizedMeanifier filterByMultiple(final int multiple);

    @Override
    GeneralizedMeanifier withoutFilter();

    /**
     * A filter for integer values
     */
    public interface Filter {
        /**
         * Checks if the given value is acceptable.
         * 
         * @param value
         *            The value to check.
         * @return <code>true</code> if the value is accepted by the filter, <code>false</code>
         *         otherwise.
         */
        boolean isApplicable(int value);
    }

    /**
     * A converter from Objects to integer values.
     * 
     * Implementation must support at least the following types:
     * <ul>
     * <li>{@link Integer}</li>
     * <li>{@link IntegerWrapper}</li>
     * <li>{@link BigInteger}</li>
     * <li>{@link String}
     * <ul>
     * <li>The first character can be a minus sign. In this case, the result is negative. Then, the
     * remaining characters are checked.</li>
     * <li>If they start with <code>0x</code>, the remaining is hexadecimal (case insensitive, no
     * spaces).</li>
     * <li>If they start with <code>0</code>, the remaining is octal.</li>
     * <li>Otherwise, it's an integer in string form</li>
     * </ul>
     * </li>
     * </ul>
     */
    public interface Converter {
        /**
         * Converts the given value to an integer.
         * 
         * @param value
         *            The value to convert.
         * @return The integer value of the object.
         * @throws ConverterException
         *             If the given value is null or cannot be converted.
         */
        int convert(Object value) throws ConverterException;
    }

    /**
     * The exception to raise in case of a conversion error.
     */
    public static final class ConverterException extends RuntimeException {
        private static final long serialVersionUID = -6148858420526984167L;

        public ConverterException(String message) {
            super(message);
        }

        public ConverterException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}
