import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void bottomSheet(BuildContext context, Widget sheetBody) {
  showModalBottomSheet(
    context: context,
    builder: (context) => sheetBody,
  );
}
