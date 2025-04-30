import 'package:cet_app/core/utils/finance_calculations.dart';
import 'package:cet_app/data/models/finance_model.dart';

class CalculateValue {
  double calculateMonthlyRateValue(
    FinancingModel financing,
  ) {
    return FinanceCalculations().calculateMonthlyRate(
          financing.financedValue,
          financing.installmentValue,
          financing.numInstallments,
        ) *
        100; // Convert to percentage
  }

  double calculateInstallmentValue(
    FinancingModel financing,
  ) {
    return FinanceCalculations().calculateInstallmentValue(
      financing.financedValue,
      financing.interestValue,
      financing.numInstallments,
    );
  }

  double calculateRealValue(
    FinancingModel financing,
    double cetValue,
    double entryValue,
  ) {
    return FinanceCalculations().calculateRealValue(
      entryValue,
      financing.numInstallments,
      financing.installmentValue,
    );
  }

  double calculateAddedValue(
    FinancingModel financing,
    double realValue,
  ) {
    return FinanceCalculations().calculateAddedValue(
      financing.financedValue,
      realValue,
    );
  }
}
