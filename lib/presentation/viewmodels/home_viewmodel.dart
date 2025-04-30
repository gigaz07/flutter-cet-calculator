import 'package:cet_app/data/models/finance_model.dart';
import 'package:cet_app/domain/usecases/calculate_value.dart';
import 'package:flutter/material.dart';

class HomeViewmodel extends ChangeNotifier {
  int currentScreenId = 1;

  double totalValue = 0.0;
  double entryValue = 0.0;
  int numInstallments = 0;
  double installmentValue = 0.0;
  double interestValue = 0.0;

  double? cetValue;
  double? desiredInstallmentValue;
  double? realValue;
  double? addedValue;

  void setScreenSelection(int value) {
    currentScreenId = value;
    notifyListeners();
  }

  void setTotalValue(String value) {
    String numericValue =
        value.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    totalValue = parsedValue;
    notifyListeners();
  }

  void setEntryValue(String value) {
    String numericValue =
        value.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    entryValue = parsedValue;
    notifyListeners();
  }

  void setInstallmentValue(String value) {
    String numericValue =
        value.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    installmentValue = parsedValue;
    notifyListeners();
  }

  void setNumInstallments(String value) {
    numInstallments = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void setInterestValue(String value) {
    double percentageNumber = double.tryParse(value) ?? 0.0;
    interestValue = percentageNumber / 100;
    notifyListeners();
  }

  void calculateMonthlyRate() {
    double financedValue = totalValue - entryValue;

    if (financedValue <= 0 || numInstallments <= 0 || installmentValue <= 0) {
      return; // Avoid invalid calculations
    }

    FinancingModel financing = FinancingModel(
      financedValue: financedValue,
      numInstallments: numInstallments,
      installmentValue: installmentValue,
    );

    cetValue = CalculateValue().calculateMonthlyRateValue(financing);
    realValue =
        CalculateValue().calculateRealValue(financing, cetValue!, entryValue);
    addedValue = CalculateValue().calculateAddedValue(financing, realValue!);
    notifyListeners(); // Updates the UI
  }

  void calculateInstallment() {
    double financedValue = totalValue - entryValue;

    if (financedValue <= 0 || numInstallments <= 0 || interestValue <= 0) {
      return; // Avoid invalid calculations
    }

    FinancingModel financing = FinancingModel(
      financedValue: financedValue,
      numInstallments: numInstallments,
      interestValue: interestValue,
    );

    desiredInstallmentValue =
        CalculateValue().calculateInstallmentValue(financing);
    notifyListeners(); // Updates the UI
  }
}
