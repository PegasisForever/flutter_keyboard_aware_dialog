part of 'flutter_keyboard_aware_dialog.dart';

/// Dialog that moves up when soft keyboard is shown and scrollable when there's
/// not enough vertical space.
///
/// All the arguments are identical to [Dialog].
///
/// Note: `barrierDismissible` of [showDialog] will have no effect, you
/// can't dismiss dialog by clicking the outside of the dialog.
class KeyboardAwareDialog extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final double elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder shape;

  const KeyboardAwareDialog({
    Key key,
    @required this.child,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40),
    this.clipBehavior = Clip.none,
    this.shape,
  }) : super(key: key);

  @override
  _KeyboardAwareDialogState createState() => _KeyboardAwareDialogState();
}

class _KeyboardAwareDialogState extends State<KeyboardAwareDialog> {
  Size dialogSize;
  Size parentSize;

  @override
  Widget build(BuildContext context) {
    Widget w;
    EdgeInsets padding;

    if (dialogSize != null && parentSize != null) {
      final keyboardInsert = MediaQuery.of(context).viewInsets.bottom;
      final visibleHeight = parentSize.height - keyboardInsert;
      final verticalPadding = (visibleHeight - dialogSize.height) / 2;
      var topPadding = verticalPadding;
      if (topPadding < widget.insetPadding.top)
        topPadding = widget.insetPadding.top;
      var bottomPadding = verticalPadding;
      if (bottomPadding < widget.insetPadding.bottom)
        bottomPadding = widget.insetPadding.bottom;

      padding = EdgeInsets.only(
        left: widget.insetPadding.left,
        right: widget.insetPadding.right,
        top: topPadding,
        bottom: bottomPadding,
      );
    }

    final dialog = Dialog(
      insetPadding: padding ?? widget.insetPadding,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      insetAnimationCurve: widget.insetAnimationCurve,
      clipBehavior: widget.clipBehavior,
      shape: widget.shape,
      child: MeasureSize(
        onChange: (size) {
          setState(() {
            dialogSize = size;
          });
        },
        child: widget.child,
      ),
    );
    if (padding != null) {
      w = ScrollConfiguration(
        behavior: _NoOverScrollBehavior(),
        child: SingleChildScrollView(
          child: dialog,
        ),
      );
    } else {
      w = dialog;
    }

    return MeasureSize(
      onChange: (size) {
        setState(() {
          parentSize = size;
        });
      },
      child: w,
    );
  }
}

class _NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
