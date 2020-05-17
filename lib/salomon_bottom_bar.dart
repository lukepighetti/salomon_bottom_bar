library salomon_bottom_bar;

import 'package:flutter/material.dart';

import 'implicitly_animated_builder.dart';

class SalomonBottomBar extends StatelessWidget {
  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<SBBItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int) onTap;

  /// The color of the icon and text when the item is selected.
  final Color selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color unselectedItemColor;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  SalomonBottomBar({
    Key key,
    @required this.items,
    this.currentIndex,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.margin,
    this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _itemPadding = itemPadding ??
        const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0);

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final item in items)
            ImplicitlyAnimatedBuilder(
              isActive: items.indexOf(item) == currentIndex,
              curve: Curves.easeOutQuint,
              duration: Duration(milliseconds: 500),
              builder: (context, t) {
                final _selectedColor =
                    item.selectedColor ?? selectedItemColor ?? Colors.black;

                final _unselectedColor =
                    item.unselectedColor ?? unselectedItemColor ?? Colors.black;

                return Material(
                  color: Color.lerp(
                      Colors.transparent, _selectedColor.withOpacity(0.10), t),
                  shape: StadiumBorder(),
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: StadiumBorder(),
                    child: Padding(
                      padding: _itemPadding -
                          EdgeInsets.only(right: _itemPadding.right * t),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: Color.lerp(
                                  _unselectedColor, _selectedColor, t),
                              size: 24,
                            ),
                            child: item.icon ?? SizedBox.shrink(),
                          ),
                          ClipRect(
                            child: SizedBox(
                              /// TODO: Constrain item height without a fixed value
                              ///
                              /// The Align property appears to make these full height, would be
                              /// best to find a way to make it respond only to padding.
                              height: 20,
                              child: Align(
                                alignment: Alignment(-0.2, 0.0),
                                widthFactor: t,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: _itemPadding.right / 2,
                                      right: _itemPadding.right),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Color.lerp(Colors.transparent,
                                          _selectedColor, t),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    child: item.title ?? SizedBox.shrink(),
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
    );
  }
}

/// A tab to display in a [SalomonBottomBar]
class SBBItem {
  /// An icon to display.
  final Widget icon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color selectedColor;

  /// The color to display when this tab is not selected.
  final Color unselectedColor;

  SBBItem({this.icon, this.title, this.selectedColor, this.unselectedColor})
      : assert(icon != null, "Every SBBItem requires an icon."),
        assert(title != null, "Every SBBItem requires a title.");
}
