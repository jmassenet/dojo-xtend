package dojo.xtend.kata3.solution

import dojo.xtend.kata3.GeneralizedMeanifier$Converter
import dojo.xtend.kata3.GeneralizedMeanifier$ConverterException
import dojo.xtend.kata3.IntegerWrapper
import java.math.BigInteger
import dojo.xtend.kata3.solution.StringConverter

class XtendConverter implements Converter {
    
    override int convert(Object value) throws ConverterException {
        if (value == null) {
            throw new ConverterException("Object is null");
        }
        doConvert(value);
    }
    
    def static dispatch doConvert(Integer value) {
        value
    }
    
    def static dispatch doConvert(IntegerWrapper wrapper) {
        wrapper.value
    }
    
    def static dispatch doConvert(BigInteger value) {
        value.intValue
    }
    
    def static dispatch doConvert(String value) {
        var valueConverter = new StringConverter(value)
        
        var signMulti = if (valueConverter.removeHead('-')) -1 else 1
        
        val radix = switch valueConverter {
            case valueConverter.removeHead('0x'): 16
            case valueConverter.value.length > 1 && valueConverter.removeHead('0'): 8
            default: 10
        }
        
        try {
            Integer::parseInt(valueConverter.value, radix) * signMulti
        } catch (NumberFormatException e) {
            throw new ConverterException("Invalid string value: " + value, e);
        }
    }
    
    def static dispatch int doConvert(Object value) {
        throw new ConverterException('Unsupported type: ' + value.^class.canonicalName);
    }
}

class StringConverter {
    private var String value
    
    new(String value) {
        super()
        this.value = value
    }
    
    def removeHead(String head) {
        if (value.startsWith(head)) {
            value = value.substring(head.length)
            true
        } else {
            false
        }
    }
    
    def getValue() {
        value
    }
}
