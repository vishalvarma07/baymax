import 'package:flutter/material.dart';

bool isMobileDevice({BoxConstraints? constraints,BuildContext? context}){
  if(constraints==null && context==null){
    throw Exception("constraints==null and context==null");
  }
  if(constraints!=null && constraints.maxWidth<700){
    return true;
  }
  if(context!=null && MediaQuery.of(context).size.width<700){
    return true;
  }
  return false;
}