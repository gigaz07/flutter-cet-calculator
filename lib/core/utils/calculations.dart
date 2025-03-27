import 'package:cet_app/core/constants/app_values.dart';
import 'dart:math';

double calculateEffectiveMonthlyRate(double financedValue, double installmentValue, int numInstallments) {
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
    print("Iteration $i: guessRate = $guessRate, calculatedValue = $f");
  }

  throw Exception("Falha ao calcular o CET. Pode não ter convergido.");
}