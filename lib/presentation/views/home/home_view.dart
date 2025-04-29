import 'package:cet_app/core/theme/app_theme.dart';
import 'package:cet_app/presentation/viewmodels/home_view_model.dart';
import 'package:cet_app/presentation/views/home/subscreens/cet_view.dart';
import 'package:cet_app/presentation/views/home/subscreens/installment_view.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final safeAreaHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: safeAreaHeight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                  Expanded(
                    child: _buildContent(
                      context.watch<HomeViewModel>().currentScreenId,
                      context,
                    ),
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
        return CetView().build(context);
      case 2:
        return InstallmentView().build(context);
      default:
        return Text(
          "Error: Invalid Screen ID",
          style: AppFonts.mainTextFont,
        );
    }
  }
}
