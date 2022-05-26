import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';

class CustomFormField extends StatefulWidget {
  String label, placeholder;
  bool isPassword;

  CustomFormField(
      {required this.label,
      required this.placeholder,
      required this.isPassword,
      Key? key})
      : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12, bottom: 4),
          child: Text(widget.label, style: text_xs_bold),
        ),
        TextField(
          style: text_xs,
          obscureText: isHidden,
          decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(color: neutral_30),
              filled: true,
              fillColor: neutral_20,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: !isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: togglePasswordVisibility,
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: neutral_20),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary_20),
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ],
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
