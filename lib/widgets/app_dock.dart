import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

/// TODO: maybe can combine with the game controller.
class AppDock extends StatefulWidget {
  const AppDock({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AppDockState();
}

class _AppDockState extends State<AppDock> {
  static const double height = 40; // TODO: should resize based on screen size.
  static const double width = 160;
  static const List<NavItem> navItems = NavItem.values;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFB19E6D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          navItems.length,
          (index) => _ControlButton(
            iconWidget: navItems[index].icon,
            onPressed: () {
              context.goNamed(navItems[index].locationName);
            },
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  static const double _iconSize = 25;
  static const double _iconButtonSize = 30;
  final void Function()? onPressed;
  final Widget iconWidget;

  const _ControlButton({
    this.onPressed,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: _iconButtonSize,
      splashRadius: 2,
      onPressed: onPressed,
      icon: Center(
        child: Container(
          padding: EdgeInsets.zero,
          height: _iconButtonSize,
          width: _iconButtonSize,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          child: SizedBox.square(
            dimension: _iconSize,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fill,
                child: iconWidget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
