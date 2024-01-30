import 'package:flutter/material.dart';

class SalomonBottomBar extends StatelessWidget {
  /// A bottom bar that faithfully follows the design by Aurélien Salomon
  ///
  /// https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern/
  SalomonBottomBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.textFontSize,
    this.textFontWeight,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<SalomonBottomBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  /// The background color of the bar.
  final Color? backgroundColor;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected.
  final double? selectedColorOpacity;

  /// The fontSize of the text.
  final double? textFontSize;

  /// The fontWeight of the text.
  final FontWeight? textFontWeight;

  /// The border shape of each item.
  final ShapeBorder itemShape;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: SafeArea(
        minimum: margin,
        child: Row(
          /// Using a different alignment when there are 2 items or less
          /// so it behaves the same as BottomNavigationBar.
          mainAxisAlignment: items.length <= 2 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              TweenAnimationBuilder<double>(
                tween: Tween(
                  end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                ),
                curve: curve,
                duration: duration,
                builder: (context, t, _) {
                  final _selectedColor = item.selectedColor ?? selectedItemColor ?? theme.primaryColor;

                  final _unselectedColor = item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color;

                  final children = [
                    IconTheme(
                      data: IconThemeData(
                        color: Color.lerp(_unselectedColor, _selectedColor, t),
                        size: 24,
                      ),
                      child: items.indexOf(item) == currentIndex ? item.activeIcon ?? item.icon : item.icon,
                    ),
                    ClipRect(
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        height: 20,
                        child: Align(
                          alignment: Alignment(-0.2, 0.0),
                          widthFactor: t,
                          child: Padding(
                            padding: item.iconAtRight
                                ? EdgeInsets.only(right: itemPadding.left / 2)
                                : EdgeInsets.only(left: itemPadding.right / 2),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Color.lerp(_selectedColor.withOpacity(0.0), _selectedColor, t),
                                fontWeight: textFontWeight ?? FontWeight.w600,
                                fontSize: textFontSize
                              ),
                              child: item.title,
                            ),
                          ),
                        ),
                      ),
                    )
                  ];

                  return Material(
                    color: Color.lerp(
                        _selectedColor.withOpacity(0.0), _selectedColor.withOpacity(selectedColorOpacity ?? 0.1), t),
                    shape: itemShape,
                    child: InkWell(
                      onTap: () => onTap?.call(items.indexOf(item)),
                      customBorder: itemShape,
                      focusColor: _selectedColor.withOpacity(0.1),
                      highlightColor: _selectedColor.withOpacity(0.1),
                      splashColor: _selectedColor.withOpacity(0.1),
                      hoverColor: _selectedColor.withOpacity(0.1),
                      child: Padding(
                        padding: itemPadding,
                        child: Row(
                          children: item.iconAtRight ? children.reversed.toList() : children,
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
class SalomonBottomBarItem {
  /// An icon to display.
  final Widget icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  /// The icon is set to the right of label
  final bool iconAtRight;

  SalomonBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
    this.iconAtRight = false,
  });
}
