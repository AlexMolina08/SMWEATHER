import 'package:flutter/material.dart';

class cityTextField extends StatefulWidget {
  const cityTextField(
      {required this.screenWidth,required this.onSubmitted,required this.onChanged});

  final double screenWidth;
  final void Function(String) onSubmitted; // si el user pulsa enter en el navegador
  final void Function(String) onChanged;

  @override
  State<cityTextField> createState() => _cityTextFieldState();
}

class _cityTextFieldState extends State<cityTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenWidth <= 844 ? 60 : 50,
      width: widget.screenWidth <= 844
          ? widget.screenWidth / 1.5
          : widget.screenWidth / 2,
      child: TextField(
        cursorColor: Colors.grey.shade800,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "Buscar una localidad",
          contentPadding: EdgeInsets.only(bottom: 1.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),

          )
        ),
        style: TextStyle(
          fontSize: 30,
          color: Colors.grey.shade800
        ),
      ),
    );
  }
}
