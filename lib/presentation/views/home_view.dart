import 'package:cet_app/core/theme/app_theme.dart';
import 'package:cet_app/presentation/viewmodels/home_view_model.dart';
import 'package:cet_app/widgets/custom_button.dart';
import 'package:cet_app/widgets/number_input_field.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
              child: Column(
                children: [
                  CustomSlidingSegmentedControl<int>(
                    innerPadding: EdgeInsets.all(6),
                    height: 60,
                    isStretch: true,
                    initialValue:
                        context.watch<HomeViewModel>().currentScreenId,
                    children: {
                      1: Text(
                        'Calcular CET',
                        textAlign: TextAlign.center,
                        style: AppFonts.titleTextFont,
                      ),
                      2: Text(
                        'Calcular Parcela',
                        textAlign: TextAlign.center,
                        style: AppFonts.titleTextFont,
                      ),
                    },
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    thumbDecoration: BoxDecoration(
                      color: AppColors.darkTextColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onValueChanged: (int value) {
                      context.read<HomeViewModel>().setScreenSelection(value);
                    },
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: _buildContent(
                        context.watch<HomeViewModel>().currentScreenId,
                        context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(int currentScreenId, BuildContext context) {
    switch (currentScreenId) {
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  context.watch<HomeViewModel>().cetValue != null
                      ? context
                          .watch<HomeViewModel>()
                          .cetValue!
                          .toStringAsFixed(2)
                      : "0",
                  style: AppFonts.resultTextFont,
                ),
                Text(
                  "% / mês",
                  style: AppFonts.resultUnitTextFont,
                )
              ],
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
                          title: "Valor total:",
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
                          title: "Valor de parcela:",
                          hint: "RS 900,00",
                          onChanged: (value) {
                            context
                                .read<HomeViewModel>()
                                .setInstallmentValue(value);
                          },
                        ),
                        SizedBox(height: 12),
                        NumberInputField(
                          title: "Quantidade de parcelas:",
                          hint: "100",
                          inputType: InputType.integer,
                          onChanged: (value) {
                            context
                                .read<HomeViewModel>()
                                .setNumInstallments(value);
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
                        context.read<HomeViewModel>().calculateCETValue()),
              ],
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  "reais / mês",
                  style: AppFonts.resultUnitTextFont,
                )
              ],
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
                          title: "Valor total:",
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
                          title: "Valor dos juros:",
                          hint: "2.25%",
                          inputType: InputType.percentage,
                          onChanged: (value) {
                            context
                                .read<HomeViewModel>()
                                .setInterestValue(value);
                          },
                        ),
                        SizedBox(height: 12),
                        NumberInputField(
                          title: "Quantidade de parcelas:",
                          hint: "100",
                          inputType: InputType.integer,
                          onChanged: (value) {
                            context
                                .read<HomeViewModel>()
                                .setNumInstallments(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomButton(
                    title: "Calcular Parcela",
                    onTap: () => context
                        .read<HomeViewModel>()
                        .calculateInstallmentValue()),
              ],
            ),
          ],
        );
      default:
        return SizedBox();
    }
  }
}
