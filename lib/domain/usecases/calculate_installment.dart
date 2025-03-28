import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateInstallment(FinancingModel financing) {
  return calculateDesiredInstallmentValue(
      financing.financedValue,
      financing.interestValue,
      financing.numInstallments); // Convert to percentage
}
