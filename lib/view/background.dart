import 'package:flutter/material.dart';

LinearGradient gradient(var begin,var end,bottomColor,topColor){
  return LinearGradient(
      begin: begin, end: end, colors: [bottomColor, topColor]);
}