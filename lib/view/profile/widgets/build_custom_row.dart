import 'package:flutter/cupertino.dart';

import '../../../constants/colors.dart';
import '../../global_widgets/texts.dart';

Widget buildCustomRow(String keyText, String valueText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleText(keyText, size: 14, fontWeight: FontWeight.w600),
        subTitleText(valueText, color: black)
      ],
    ),
  );
}