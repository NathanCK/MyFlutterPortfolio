import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

/// TODO: maybe can combine with the game controller.
class AppDock extends StatefulWidget {
  final GlobalKey<BeamerState> beamerKey;

  const AppDock({super.key, required this.beamerKey});

  @override
  State<StatefulWidget> createState() => _AppDockState();
}

class _AppDockState extends State<AppDock> {
  static const double hight = 40; // TODO: should resize based on screen size.
  static const double wight = 160;
  static const List<NavItem> navItems = NavItem.values;

  void _setStateListener() => setState(() {});

  late final BeamerDelegate _beamerDelegate;

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => widget
        .beamerKey.currentState?.routerDelegate
        .addListener(_setStateListener));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: wight,
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
                      _beamerDelegate.beamToNamed(
                        navItems[index].url,
                      );
                    },
                  ))),
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
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
