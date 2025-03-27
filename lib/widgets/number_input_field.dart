import 'package:cet_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class NumberInputField extends StatelessWidget {
  final bool isCurrency;
  final String title;
  final String hint;
  final Function(String) onChanged;

  const NumberInputField({
    super.key, 
    required this.onChanged, 
    required this.title, 
    required this.hint,
    this.isCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.mainTextFont
        ),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppFonts.hintTextFont,
            contentPadding: EdgeInsets.only(left: 6),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightTextColor
              )
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightTextColor,
                width: 2,
              )
            )
          ),
          inputFormatters: isCurrency 
          ? [CurrencyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 2,
              leadingSymbol: 'R\$ ',
              useSymbolPadding: true, 
            )]
          : [],
          onChanged: onChanged,
          style: AppFonts.mainTextFont
        ),
      ],
    );
  }
}