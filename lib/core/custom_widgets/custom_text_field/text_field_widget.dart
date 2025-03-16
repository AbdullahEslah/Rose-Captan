import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/lang/app_language_provider.dart';

class CustomTextFieldForm extends StatelessWidget {
  final void Function(String)? onChanged;
  final String emptyValueText;
  final String? Function(String?)? validator;
  final String? placeholder;
  final String? topPlaceholder;
  final String? textFieldDescription;
  final Color? placeholderColor;
  final Widget? rightIcon;
  final Widget? leftWidget;
  final Color? backgroundColor;
  final bool? secureText;
  final TextEditingController? controller;

  final TextInputType? keyboardType;

  final FocusNode? focus;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const CustomTextFieldForm({
    super.key,
    this.focus,
    this.rightIcon,
    this.leftWidget,
    required this.placeholder,
    this.textFieldDescription,
    this.placeholderColor,
    this.backgroundColor,
    this.secureText,
    this.topPlaceholder,
    this.controller,
    this.validator,
    required this.emptyValueText,
    this.onChanged,
    this.keyboardType,
    this.textDirection,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguage>(context, listen: false);
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        textDirection: textDirection,
        focusNode: focus,
        onTapOutside: (event) {
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // if (!currentFocus.hasPrimaryFocus &&
          //     currentFocus.focusedChild != null) {
          //   FocusManager.instance.primaryFocus?.unfocus();
          // }
        },
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return emptyValueText;
          }
          return null;
        },
        controller: controller,
        cursorOpacityAnimates: true,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        autocorrect: false,
        enableSuggestions: true,
        obscureText: secureText ?? false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide:
                BorderSide(width: 2, color: Colors.red[700] ?? Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide:
                BorderSide(width: 2, color: Colors.red[700] ?? Colors.red),
          ),
          labelText: topPlaceholder,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 2, color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 2, color: Colors.black),
          ),
          fillColor: backgroundColor,
          border: const OutlineInputBorder(),
          hintStyle: TextStyle(color: placeholderColor ?? Colors.black54),
          prefixIcon: leftWidget,
          suffixIcon: rightIcon,
          hintText: placeholder,
          helperText: textFieldDescription,
          filled: true,
        ),
      ),
    );
  }
}
