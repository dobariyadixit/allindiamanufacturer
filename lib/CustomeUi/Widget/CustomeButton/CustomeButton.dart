import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget{


  CustomeButton({
    required this.onTap,
    required this.ButtonName,
    this.ButtonHeight,
    this.ButtonWidth,
    this.ButtonColor,
    this.BorderColor,
    this.BorderWidth,
    this.BorderRadiuss,
    this.TextColor,
    this.TextSize,
    this.TextFontWeight,
    this.TopMargin,
    this.BottomMargin,
    this.RightMargin,
    this.LeftMargin,
    this.alignment,
    this.BottomPadding,
    this.LeftPadding,
    this.RightPadding,
    this.TopPadding,
});

  VoidCallback onTap;
  String? ButtonName;
  double? ButtonHeight;
  double? ButtonWidth;
  Color? ButtonColor;
  Color? BorderColor;
  double? BorderWidth;
  double? BorderRadiuss;
  Color? TextColor;
  double? TextSize;
  FontWeight? TextFontWeight;
  double? RightMargin;
  double? TopMargin;
  double? BottomMargin;
  double? LeftMargin;
  double? LeftPadding;
  double? TopPadding;
  double? BottomPadding;
  double? RightPadding;
  Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: RightMargin ?? 0,top: TopMargin ?? 0,
          bottom: BottomMargin ?? 0,left: LeftMargin ?? 0),
      padding: EdgeInsets.only(
          right: RightPadding ?? 0,top: TopPadding ?? 0,
          bottom: BottomPadding ?? 0,left: LeftPadding ?? 0),

      child: InkWell(
        onTap: onTap,
        child: Container(
            alignment: alignment ?? Alignment.center,
          decoration: BoxDecoration(
            color: ButtonColor ?? Colors.grey.shade600,
            border: Border.all(
              color: BorderColor ?? Colors.black,
              width: BorderWidth ?? 0,
            ),
            borderRadius: BorderRadius.circular(BorderRadiuss ?? 0),
          ),
            height: ButtonHeight ?? MediaQuery.of(context).size.height,
            width: ButtonWidth ?? MediaQuery.of(context).size.width,
            child: Text(ButtonName ?? "ButtonName",
              style: TextStyle(
                  color: TextColor ?? Colors.black,
                  fontSize: TextSize ?? 15,
                  fontWeight: TextFontWeight ?? FontWeight.normal,
              ),)),
      ),
    );
  }
}

