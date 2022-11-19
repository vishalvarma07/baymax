import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final bool enabled;
  final String? hintText;
  final Widget? suffixIcon;
  final bool takeFullWidth;
  final bool takeFullHeight;
  const CustomTextField({Key? key,required this.label,this.obscureText=false,this.prefixIcon,this.controller,this.onTap, this.onChanged,this.readOnly=false, this.enabled=true, this.textInputType, this.hintText, this.suffixIcon, this.takeFullWidth=true, this.takeFullHeight=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: takeFullHeight?double.infinity:50,
        maxWidth: takeFullWidth?double.infinity:300,
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        maxLines: takeFullHeight?200:1,
        keyboardType: textInputType,
        enabled: true,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(label),
          filled: true,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          prefixIcon: prefixIcon,
        ),
        obscureText: takeFullHeight?false:obscureText,
        onChanged: (value){
          if(onChanged!=null){
            onChanged!(value);
          }
        },
      ),
    );
  }
}
