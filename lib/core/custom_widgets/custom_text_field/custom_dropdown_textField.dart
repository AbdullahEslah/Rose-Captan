import 'package:flutter/material.dart';

class CustomDropdownTextField extends StatelessWidget {
  final TextEditingController? controller;
  // final String label;
  final List<String> options;
  final void Function(String) onChanged;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final String? placeholder;
  final String? topPlaceholder;
  final String? textFieldDescription;
  final Color? placeholderColor;
  final String emptyValueText;
  final FocusNode? focusNode;

  const CustomDropdownTextField({
    super.key,
    required this.controller,
    // required this.label,
    required this.options,
    required this.onChanged,
    this.backgroundColor,
    this.validator,
    this.placeholderColor,
    this.placeholder,
    this.topPlaceholder,
    this.textFieldDescription,
    required this.emptyValueText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final arrowUpNotifier = ValueNotifier(false); // 👈 نستخدمها جوة الـ build

    return ValueListenableBuilder(
      valueListenable: arrowUpNotifier,
      builder: (context, arrowUp, _) {
        return GestureDetector(
          onTap: () => _showDropdown(context, arrowUpNotifier),
          child: AbsorbPointer(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyValueText;
                }
                return null;
              },
              autocorrect: false,
              enableSuggestions: true,
              cursorOpacityAnimates: true,
              readOnly: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                //   labelText: label,
                suffixIcon: AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: arrowUp ? 0.5 : 0.0, // 👈 rotate للسهم
                  child: const Icon(Icons.arrow_drop_down),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 2, color: Colors.red[700] ?? Colors.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 2, color: Colors.red[700] ?? Colors.red),
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
                hintText: placeholder,
                helperText: textFieldDescription,
                filled: true,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDropdown(BuildContext context, ValueNotifier arrowUpNotifier) {
    arrowUpNotifier.value = true;

    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              controller?.text = option; // 👈 هنا بنحدث قيمة الـ TextField
              Navigator.of(context).pop();
              arrowUpNotifier.value = false;
            },
          );
        }).toList(),
      ),
    ).whenComplete(() {
      // لو المستخدم قفل البوتوم شيت من غير ما يختار
      arrowUpNotifier.value = false;
    });
  }
}
