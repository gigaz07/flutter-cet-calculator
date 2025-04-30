import 'package:cet_app/core/theme/app_theme.dart';
import 'package:cet_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:cet_app/widgets/common/custom_button.dart';
import 'package:cet_app/widgets/common/number_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CetView extends StatelessWidget {
  const CetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.watch<HomeViewmodel>().cetValue != null
                    ? context
                        .watch<HomeViewmodel>()
                        .cetValue!
                        .toStringAsFixed(2)
                    : "0",
                style: AppFonts.resultTextFont,
              ),
              Text(
                "% / mês",
                style: AppFonts.resultUnitTextFont,
              ),
              Text(
                context.watch<HomeViewmodel>().realValue != null
                    ? "Montante pago: R\$ ${context.watch<HomeViewmodel>().realValue!.toStringAsFixed(2)}"
                    : "Calcule para saber o valor real.",
                style: AppFonts.mainTextFont,
              ),
              Text(
                context.watch<HomeViewmodel>().addedValue != null
                    ? "Valor dos juros: R\$ ${context.watch<HomeViewmodel>().addedValue!.toStringAsFixed(2)}"
                    : "",
                style: AppFonts.mainTextFont,
              )
            ],
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NumberInputField(
                      title: "Valor financiado:",
                      hint: "RS 100.000,00",
                      onChanged: (value) {
                        context.read<HomeViewmodel>().setTotalValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      title: "Valor de entrada:",
                      hint: "RS 10.000,00",
                      onChanged: (value) {
                        context.read<HomeViewmodel>().setEntryValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      key: ValueKey('installmentValueInput'),
                      title: "Valor de parcela:",
                      hint: "RS 900,00",
                      onChanged: (value) {
                        context
                            .read<HomeViewmodel>()
                            .setInstallmentValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      title: "Quantidade de parcelas:",
                      hint: "100",
                      inputType: InputType.integer,
                      onChanged: (value) {
                        context.read<HomeViewmodel>().setNumInstallments(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
                title: "Calcular CET",
                onTap: () =>
                    context.read<HomeViewmodel>().calculateMonthlyRate()),
          ],
        ),
      ],
    );
  }
}
