package dojo.xtend.kata3.solution;

import java.math.BigInteger;

import dojo.xtend.kata3.IntegerWrapper;
import dojo.xtend.kata3.GeneralizedMeanifier.Converter;
import dojo.xtend.kata3.GeneralizedMeanifier.ConverterException;

public class JavaConverter implements Converter {

    @Override
    public int convert(Object value) throws ConverterException {
        if (value == null) {
            throw new ConverterException("Object is null");
        }

        if (value instanceof Integer) {
            return (Integer) value;
        }
        if (value instanceof IntegerWrapper) {
            return ((IntegerWrapper) value).getValue();
        }
        if (value instanceof BigInteger) {
            return ((BigInteger) value).intValue();
        }
        if (value instanceof String) {
            return convertString((String) value);
        }
        throw new ConverterException("Unsupported type: " + value.getClass().getCanonicalName());
    }

    private int convertString(String inValue) {
        String value = inValue;

        // Check sign
        int signMulti = 1;
        if (value.startsWith("-")) {
            signMulti = -1;
            value = value.substring(1);
        }

        // Check radix
        int radix = 10;
        if (value.startsWith("0x")) {
            radix = 16;
            value = value.substring(2);
        } else if (value.startsWith("0") && value.length() > 1) {
            radix = 8;
            value = value.substring(1);
        }

        // Convert
        try {
            return signMulti * Integer.parseInt(value, radix);
        } catch (NumberFormatException e) {
            throw new ConverterException("Invalid string value: " + value, e);
        }
    }

}
