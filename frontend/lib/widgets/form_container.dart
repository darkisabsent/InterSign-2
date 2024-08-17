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
        this.inputType});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
        ),
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child:
        Container(
          width: 270,
          child:TextFormField(
            style: const TextStyle(color: Colors.black),
            controller: widget.controller,
            keyboardType: widget.inputType,
            key: widget.fieldKey,
            obscureText: widget.isPasswordField == true ? _obscureText : false,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                labelText: widget.labelText,
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.black45),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: widget.isPasswordField == true
                      ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false ? Colors.blue : Colors.grey,
                  )
                      : const Text(""),
                )),
          ),
        )
    );
  }
}