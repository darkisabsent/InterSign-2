import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;

  const FormContainerWidget(
      {super.key,
      this.controller,
      this.fieldKey,
      this.isPasswordField,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType,
      this.onChanged,});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double horizontalPadding = screenWidth * 0.01; // 1% of screen width
    double horizontalMargin = screenWidth * 0.02; // 2% of screen width
    double containerWidth = screenWidth * 0.8; // 80% of screen width
    double containerHeight = screenHeight * 0.08; // 8% of screen height

    return Container(
        //height: 60,
        //width: double.infinity,
        height: containerHeight,
        width: containerWidth,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldKey,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.black45),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: widget.isPasswordField == true
                    ? Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color:
                            _obscureText == false ? Colors.blue : Colors.grey,
                      )
                    : const Text(""),
              )),
        ));
  }
}
