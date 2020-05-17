import 'package:flutter/material.dart';

/// An implicitly animated builder that tweens from 0.0 to 1.0 based on `isActive` property
class ImplicitlyAnimatedBuilder extends ImplicitlyAnimatedWidget {
  ImplicitlyAnimatedBuilder({
    Key key,
    @required Curve curve,
    @required Duration duration,
    @required this.isActive,
    @required this.builder,
  }) : super(key: key, curve: curve, duration: duration);

  /// When active, tweens to 1.0. When inactive, tweens to 0.0.
  final bool isActive;

  final Widget Function(BuildContext, double) builder;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _ImplicitlyAnimatedBuilderState();
}

class _ImplicitlyAnimatedBuilderState
    extends AnimatedWidgetBaseState<ImplicitlyAnimatedBuilder> {
  Tween<double> _value;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value.evaluate(animation));
  }

  @override
  void forEachTween(visitor) {
    _value = visitor(
      _value,
      widget.isActive ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(begin: value),
    );
  }
}
