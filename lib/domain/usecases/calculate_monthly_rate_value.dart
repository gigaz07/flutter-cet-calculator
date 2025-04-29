import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateMonthlyRateValue(
  FinancingModel financing,
) {
  return monthlyRate(
        financing.financedValue,
        financing.installmentValue,
        financing.numInstallments,
      ) *
      100; // Convert to percentage
}
