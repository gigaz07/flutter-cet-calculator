import 'package:cet_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

enum InputType { currency, percentage, integer }

class NumberInputField extends StatelessWidget {
  final InputType inputType;
  final String title;
  final String hint;
  final Function(String) onChanged;

  const NumberInputField({
    super.key,
    required this.onChanged,
    required this.title,
    required this.hint,
    this.inputType = InputType.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppFonts.mainTextFont),
        TextField(
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppFonts.hintTextFont,
              contentPadding: EdgeInsets.only(left: 6),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightTextColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.lightTextColor,
                width: 2,
              ))),
          inputFormatters: _getInputFormatters(),
          onChanged: _handleOnChanged,
          style: AppFonts.mainTextFont,
          keyboardType: _getKeyboardType(),
        ),
      ],
    );
  }

  void _handleOnChanged(String value) {
    if (inputType == InputType.percentage) {
      // For percentage, we want to remove the % symbol before passing to the callback
      String numericValue = value.replaceAll('%', '').trim();
      onChanged(numericValue);
    } else {
      onChanged(value);
    }
  }

  List<TextInputFormatter> _getInputFormatters() {
    switch (inputType) {
      case InputType.currency:
        return [
          CurrencyInputFormatter(
            thousandSeparator: ThousandSeparator.Period,
            mantissaLength: 2,
            leadingSymbol: 'R\$ ',
            useSymbolPadding: true,
          )
        ];
      case InputType.percentage:
        return [
          // Custom percentage formatter
          TextInputFormatter.withFunction((oldValue, newValue) {
            // Remove any existing % symbols first
            String text = newValue.text.replaceAll('%', '').trim();

            if (text.isEmpty) {
              return const TextEditingValue(
                text: '',
                selection: TextSelection.collapsed(offset: 0),
              );
            }

            // Check if the input is a valid number
            double? value = double.tryParse(text);
            if (value == null) return oldValue;

            // Add the % symbol
            String formattedText = '$text%';

            return TextEditingValue(
              text: formattedText,
              selection: TextSelection.collapsed(offset: text.length),
            );
          }),

          // Only allow digits and one decimal point
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}%?')),
        ];
      case InputType.integer:
        return [
          FilteringTextInputFormatter.digitsOnly,
        ];
    }
  }

  TextInputType _getKeyboardType() {
    switch (inputType) {
      case InputType.currency:
      case InputType.percentage:
        return TextInputType.numberWithOptions(decimal: true);
      case InputType.integer:
        return TextInputType.number;
    }
  }
}
