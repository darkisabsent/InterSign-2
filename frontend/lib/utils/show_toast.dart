import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';

class ToastUtil {
  static void showSuccessToast(
    BuildContext context, {
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    AlignmentGeometry alignment = Alignment.topCenter,
    required String message,
  }) {
    // Instantiate
    ShowMToast toast = ShowMToast(context);

    toast.successToast(
      message: message,
      alignment: alignment,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static void showErrorToast(
    BuildContext context, {
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    AlignmentGeometry alignment = Alignment.topCenter,
    required String message,
  }) {
    // Instantiate
    ShowMToast toast = ShowMToast(context);

    toast.errorToast(
      message: message,
      alignment: alignment,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
