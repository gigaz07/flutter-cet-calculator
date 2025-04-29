import 'package:cet_app/core/utils/calculations.dart';
import 'package:cet_app/data/models/financing_model.dart';

double calculateAddedValue(
  FinancingModel financing,
  double realValue,
) {
  return addedValue(
    financing.financedValue,
    realValue,
  );
}
