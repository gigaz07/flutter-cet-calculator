import 'package:cet_app/data/models/financing_model.dart';
import 'package:cet_app/domain/usecases/calculate_cet.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{
  double totalValue = 0.0;
  double entryValue = 0.0;
  int numInstallments = 0;
  double installmentValue = 0.0;

  double? cetValue; 

  void setTotalValue(String value) {
    String numericValue = value
      .replaceAll('R\$', '')
      .replaceAll('.', '')
      .replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    totalValue = parsedValue;
    notifyListeners();
  }

  void setEntryValue(String value) {
    String numericValue = value
      .replaceAll('R\$', '')
      .replaceAll('.', '')
      .replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    entryValue = parsedValue;
    notifyListeners();
  }

  void setInstallmentValue(String value) {
    String numericValue = value
      .replaceAll('R\$', '')
      .replaceAll('.', '')
      .replaceAll(',', '.');
    double parsedValue = double.tryParse(numericValue) ?? 0.0;

    installmentValue = parsedValue;
    notifyListeners();
  }

  void setNumInstallments(String value) {
    numInstallments = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void calculateCETValue() {
      if (totalValue <= 0 || numInstallments <= 0 || installmentValue <= 0) {
      return; // Avoid invalid calculations
    }

    double financedValue = totalValue - entryValue;

    FinancingModel financing = FinancingModel(
      financedValue: financedValue,
      numInstallments: numInstallments,
      installmentValue: installmentValue,
    );

    cetValue = calculateCET(financing);
    notifyListeners(); // Updates the UI
  }
}