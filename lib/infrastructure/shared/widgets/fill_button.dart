import 'package:flutter/material.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';

class FillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final bool disable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  const FillButton({
    super.key,
    this.onPressed,
    this.child,
    this.color,
    this.margin,
    this.width = double.infinity,
    this.height = 50,
    this.padding,
    this.disable = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: disable ? kAccentColor.withOpacity(0.4) : color ?? kAccentColor,
        boxShadow: [
          BoxShadow(
            color: kAccentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: kAccentColor.withOpacity(0.1),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  padding: padding,
                  child: child,
                ),
              ),
            ),
    );
  }
}
