import 'package:cet_app/core/constants/app_values.dart';
import 'dart:math';

double calculateEffectiveMonthlyRate(
    double financedValue, double installmentValue, int numInstallments) {
  double interestRate = 0.0;

  double guessRate = AppValues.initialGuess; // Chute inicial da taxa
  double tolerance = AppValues.tolerance; // Precisão desejada
  int maxIterations = AppValues.maxIterations; // Máximo de iterações

  for (int i = 0; i < maxIterations; i++) {
    double f = -financedValue;
    double df = 0.0;

    for (int n = 0; n < numInstallments; n++) {
      double discountFactor = pow(1 + guessRate, n + 1).toDouble();
      f += installmentValue / discountFactor;
      df += -n * installmentValue / (discountFactor * (1 + guessRate));
    }

    double newRate = guessRate - f / df; // Método de Newton-Raphson

    if ((newRate - guessRate).abs() < tolerance) {
      interestRate = guessRate;
      return interestRate; // Retorna a taxa em porcentagem
    }

    guessRate = newRate;
  }

  throw Exception("Falha ao calcular o CET. Pode não ter convergido.");
}

double calculateDesiredInstallmentValue(
    double financedValue, double interestRate, int numInstallments) {
  if (interestRate == 0) {
    // Se a taxa de juros for zero, simplesmente dividimos o valor financiado pelo número de prestações
    return financedValue / numInstallments;
  }

  double rate = interestRate; // Taxa já em formato decimal

  // Fórmula para cálculo da prestação
  double numerator = rate * pow(1 + rate, numInstallments);
  double denominator = pow(1 + rate, numInstallments) - 1;

  double installmentValue = financedValue * (numerator / denominator);

  return installmentValue;
}

double calculateRealFinancedValue(
    double entryValue, int numInstallments, double installmentValue) {
  double realValue = entryValue + installmentValue * numInstallments;

  return realValue;
}

double calculateAddedValue(
    double financedValue, int numInstallments) {
  double addedInstallmentValue = financedValue / numInstallments;

  return addedInstallmentValue;
}


