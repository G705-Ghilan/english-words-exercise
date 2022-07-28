import 'package:english_words_exercise/source/constance.dart';

import 'package:flutter/material.dart';

class ExpandedButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final bool isOutline;
  final bool isAcive;
  const ExpandedButton(
      {super.key,
      required this.text,
      this.onTap,
      this.isOutline = false,
      this.isAcive = true});

  @override
  State<ExpandedButton> createState() => _ExpandedButtonState();
}

class _ExpandedButtonState extends State<ExpandedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isOutline
          ? Colors.transparent
          : CONSTANCE.primaryColor.withOpacity(widget.isAcive ? 1 : 0.4),
      borderRadius: widget.isOutline ? null : CONSTANCE.defaultBorderRadius,
      shape: widget.isOutline
          ? RoundedRectangleBorder(
              borderRadius: CONSTANCE.defaultBorderRadius,
              side: BorderSide(
                  color: CONSTANCE.primaryColor
                      .withOpacity(widget.isAcive ? 1 : 0.4),
                  width: 1),
            )
          : null,
      child: InkWell(
        borderRadius: CONSTANCE.defaultBorderRadius,
        onTap: widget.isAcive ? widget.onTap : null,
        child: Padding(
          padding: CONSTANCE.defaultPadding,
          child: Center(
              child: Text(
            widget.text,
            style: CONSTANCE.itemTitleTextStyle.copyWith(
              color: widget.isOutline
                  ? CONSTANCE.primaryColor.withOpacity(widget.isAcive ? 1 : 0.4)
                  : Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}
