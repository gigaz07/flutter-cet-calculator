import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateInstallmentValue(
  FinancingModel financing,
) {
  return installmentValue(
    financing.financedValue,
    financing.interestValue,
    financing.numInstallments,
  );
}
