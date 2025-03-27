class FinancingModel {
  final double financedValue;
  final int numInstallments;
  final double installmentValue;

  FinancingModel(
    {
      required this.financedValue,
      required this.numInstallments,
      required this.installmentValue,
    }
  );
}