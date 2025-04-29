import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateRealValue(FinancingModel financing, double cetValue, double entryValue) {
  return calculateRealFinancedValue(
    entryValue,
    financing.numInstallments,
    financing.installmentValue
  ); // Convert to percentage
}
