library salomon_bottom_bar;

import 'package:flutter/material.dart';

import 'implicitly_animated_builder.dart';

class SalomonBottomBar<T> extends StatelessWidget {
  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<SBBTab<T>> tabs;

  /// The intial tab to highly, based on matching value.
  final T selectedValue;

  /// Returns the value of the tab that was tapped.
  final Function(T) onValueTapped;

  SalomonBottomBar({
    Key key,
    @required this.tabs,
    this.selectedValue,
    this.onValueTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final tab in tabs)
              ImplicitlyAnimatedBuilder(
                isActive: tab.value == selectedValue,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 250),
                builder: (context, t) {
                  return Material(
                    color: Color.lerp(
                        Colors.transparent, tab.color.withOpacity(0.10), t),
                    shape: StadiumBorder(),
                    child: InkWell(
                      onTap: () => onValueTapped?.call(tab.value),
                      customBorder: StadiumBorder(),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16) -
                                EdgeInsets.only(right: 16 * t),
                        child: Row(
                          children: [
                            IconTheme(
                              data: IconThemeData(
                                color: Color.lerp(Colors.black, tab.color, t),
                                size: 24,
                              ),
                              child: tab.icon ?? SizedBox.shrink(),
                            ),
                            ClipRect(
                              child: SizedBox(
                                height: 20,
                                child: Align(
                                  alignment: Alignment(-0.2, 0.0),
                                  widthFactor: t,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 16),
                                    child: Text(
                                      tab.title,
                                      style: TextStyle(
                                        color: Color.lerp(
                                            Colors.transparent, tab.color, t),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// A tab to display in a [SalomonBottomBar]
class SBBTab<T> {
  /// A value to attach to this tab item.
  final T value;

  /// An icon to display.
  final Widget icon;

  /// Text to display, ie `Home`
  final String title;

  /// A primary color to use for this tab.
  final Color color;

  SBBTab({this.value, this.icon, this.title, this.color});
}
