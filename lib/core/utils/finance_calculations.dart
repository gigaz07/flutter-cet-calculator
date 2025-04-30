import 'package:cet_app/core/constants/app_constants.dart';
import 'dart:math';

class FinanceCalculations {
  double calculateMonthlyRate(
    double financedValue,
    double installmentValue,
    int numInstallments,
  ) {
    double interestRate = 0.0;

    double guessRate = AppConstants.initialGuess; // Initial interest rate guess
    double tolerance = AppConstants.tolerance; // Desired precision
    int maxIterations =
        AppConstants.maxIterations; // The maximum number of iterations

    for (int i = 0; i < maxIterations; i++) {
      double f = -financedValue;
      double df = 0.0;

      for (int n = 0; n < numInstallments; n++) {
        double discountFactor = pow(1 + guessRate, n + 1).toDouble();
        f += installmentValue / discountFactor;
        df += -n * installmentValue / (discountFactor * (1 + guessRate));
      }

      double newRate = guessRate - f / df; // Newton-Raphson method

      if ((newRate - guessRate).abs() < tolerance) {
        interestRate = guessRate;
        return interestRate; // Interest rate in decimal format
      }

      guessRate = newRate;
    }

    throw Exception("Failed calculating monthly rate, conversion failed.");
  }

  double calculateInstallmentValue(
    double financedValue,
    double interestRate,
    int numInstallments,
  ) {
    if (interestRate == 0) {
      return financedValue / numInstallments;
    }

    double rate = interestRate; // Interest rate in decimal format

    double numerator = rate * pow(1 + rate, numInstallments);
    double denominator = pow(1 + rate, numInstallments) - 1;

    double installmentValue = financedValue * (numerator / denominator);

    return installmentValue;
  }

  double calculateRealValue(
    double entryValue,
    int numInstallments,
    double installmentValue,
  ) {
    double realValue = entryValue + installmentValue * numInstallments;

    return realValue;
  }

  double calculateAddedValue(
    double financedValue,
    double realValue,
  ) {
    double addedValue = realValue - financedValue;

    return addedValue;
  }
}
