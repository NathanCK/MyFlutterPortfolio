import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/my_theme.dart';
import 'package:my_flutter_website/utils/nav_item.dart';
import 'package:my_flutter_website/widgets/button_selection_clipper_path.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<BeamerState> beamerKey;

  const AppDrawer({super.key, required this.beamerKey});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
    final drawerTheme = Theme.of(context).extension<MyDrawerTheme>()!;
    final path = (context.currentBeamLocation.state as BeamState).uri.path;
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.4;
    return Drawer(
      width: drawerWidth,
      backgroundColor: drawerTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
      child: _getDrawerButtonList(path, drawerTheme),
    );
  }

  Widget _getDrawerButtonList(String currentPath, MyDrawerTheme drawerTheme) {
    const navItemList = NavItem.values;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final navItem = navItemList[index];
            return DrawerButton(
                onPressed: () => _beamerDelegate.beamToNamed(navItem.url),
                isSelected: currentPath.contains(navItem.url),
                child: Row(
                  children: [
                    navItem.icon,
                    const SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      child: Text(
                        navItem.label,
                        maxLines: 1,
                        style: drawerTheme.labelStyle,
                      ),
                    ),
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: navItemList.length),
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}

class DrawerButton extends StatefulWidget {
  const DrawerButton({
    super.key,
    this.isSelected = false,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool isSelected;

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  late final WidgetStatesController materialStatesController;

  @override
  void initState() {
    materialStatesController = WidgetStatesController();
    materialStatesController.update(WidgetState.selected, widget.isSelected);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawerButton oldWidget) {
    materialStatesController.update(WidgetState.selected, widget.isSelected);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final drawerTheme = Theme.of(context).extension<MyDrawerTheme>()!;
    final buttonWidget = SizedBox(
      width: 120,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: drawerTheme.buttonTheme.style!,
          statesController: materialStatesController,
          child: widget.child,
        ),
      ),
    );

    if (widget.isSelected) {
      return LimitedBox(
        maxHeight: 35,
        maxWidth: 120,
        child: Stack(children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            left: 0,
            child: buttonWidget,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: ButtonSelectionClipperPath(),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: drawerTheme.buttonSelectedIndicatorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 120,
                height: 50,
              ),
            ),
          ),
        ]),
      );
    }

    return buttonWidget;
  }
}
