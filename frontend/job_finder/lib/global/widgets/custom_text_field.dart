import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  bool obscure;
  TextInputType keyboardType;
  final void Function(String) onSaved;
  final String? Function(String?) validate;
  double? width;
  double? height;
  CustomTextFormField({
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.onSaved,
    required this.validate,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.width ,
    this.height,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? MediaQuery.sizeOf(context).height * .06,
      width: widget.width ?? MediaQuery.sizeOf(context).width - 40,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.black.withOpacity(0.5),
            size: 25,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          filled: true,
          fillColor: const Color(0xffD9E9FC),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          isCollapsed: true,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 194, 110, 104),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          suffixIcon: widget.labelText == "Password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscure = !widget.obscure;
                    });
                  },
                  icon: Icon(
                    widget.obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              : null,
          label: Text(
            widget.labelText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * .06,
            minHeight: MediaQuery.sizeOf(context).height * .06,
          ),
        ),
        onSaved: (value) {
          widget.onSaved(value!);
        },
        validator: (value) {
          return widget.validate(value);
        },
      ),
    );
  }
}
