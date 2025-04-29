import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateAddedInstallmentValue(FinancingModel financing) {
  return calculateAddedValue(
    financing.financedValue,
    financing.numInstallments
  ); // Convert to percentage
}
