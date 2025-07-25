import 'package:ltdmed/fhir/data_type/v_quantity.dart';
import 'package:ltdmed/fhir/primitive.dart';

class VSampleData {
  VSimpleQuantity? sampleQuantity; // Sample quantity of the data
  Vdecimal? interval;
  VCode? intervalUnit; // Unit of the interval
  Vdecimal? factor;
  Vdecimal? lowerLimit; // Lower limit of the sample data
  Vdecimal? upperLimit; // Upper limit of the sample data
  VpositiveInt? dimension; // Dimension of the sample data
}
