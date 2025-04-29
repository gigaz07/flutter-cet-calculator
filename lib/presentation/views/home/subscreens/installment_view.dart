import 'package:cet_app/core/theme/app_theme.dart';
import 'package:cet_app/presentation/viewmodels/home_view_model.dart';
import 'package:cet_app/widgets/custom_button.dart';
import 'package:cet_app/widgets/number_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstallmentView extends StatelessWidget {
  const InstallmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.watch<HomeViewModel>().desiredInstallmentValue != null
                    ? context
                        .watch<HomeViewModel>()
                        .desiredInstallmentValue!
                        .toStringAsFixed(2)
                    : "0",
                style: AppFonts.resultTextFont,
              ),
              Text(
                "R\$ / mês",
                style: AppFonts.resultUnitTextFont,
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
                        context.read<HomeViewModel>().setTotalValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      title: "Valor de entrada:",
                      hint: "RS 10.000,00",
                      onChanged: (value) {
                        context.read<HomeViewModel>().setEntryValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      key: ValueKey('interestRateInput'),
                      title: "Valor dos juros:",
                      hint: "2.25%",
                      inputType: InputType.percentage,
                      onChanged: (value) {
                        context.read<HomeViewModel>().setInterestValue(value);
                      },
                    ),
                    SizedBox(height: 12),
                    NumberInputField(
                      title: "Quantidade de parcelas:",
                      hint: "100",
                      inputType: InputType.integer,
                      onChanged: (value) {
                        context.read<HomeViewModel>().setNumInstallments(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
                title: "Calcular Parcela",
                onTap: () =>
                    context.read<HomeViewModel>().calculateInstallment()),
          ],
        ),
      ],
    );
  }
}
