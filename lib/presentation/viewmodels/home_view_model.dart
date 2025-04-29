import 'package:cet_app/data/models/financing_model.dart';
import 'package:cet_app/domain/usecases/calculate_added_installment_value.dart';
import 'package:cet_app/domain/usecases/calculate_cet.dart';
import 'package:cet_app/domain/usecases/calculate_installment.dart';
import 'package:cet_app/domain/usecases/calculate_real_value.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
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

  void calculateCETValue() {
    double financedValue = totalValue - entryValue;

    if (financedValue <= 0 || numInstallments <= 0 || installmentValue <= 0) {
      return; // Avoid invalid calculations
    }

    FinancingModel financing = FinancingModel(
      financedValue: financedValue,
      numInstallments: numInstallments,
      installmentValue: installmentValue,
    );

    cetValue = calculateCET(financing);
    realValue = calculateRealValue(financing, cetValue!, entryValue);
    addedValue = calculateAddedInstallmentValue(financing);
    notifyListeners(); // Updates the UI
  }

  void calculateInstallmentValue() {
    double financedValue = totalValue - entryValue;

    if (financedValue <= 0 || numInstallments <= 0 || interestValue <= 0) {
      return; // Avoid invalid calculations
    }

    FinancingModel financing = FinancingModel(
      financedValue: financedValue,
      numInstallments: numInstallments,
      interestValue: interestValue,
    );

    desiredInstallmentValue = calculateInstallment(financing);
    notifyListeners(); // Updates the UI
  }
}
