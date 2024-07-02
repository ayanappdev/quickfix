import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const IndicatorWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          width: 111,
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.green)
              : null,
          child: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: !isSelected ? Colors.green : Colors.white,
                  // fontFamily: FontConstantc.gilroySemiBold,
                ),
          )),
        ),
      ),
    );
  }
}
