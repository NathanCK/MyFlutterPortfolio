import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/my_theme.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

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

    return Container(
      color: drawerTheme.backgroundColor,
      width: drawerWidth,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
      child: _getDrawerButtonList(path),
    );
  }

  Widget _getDrawerButtonList(String currentPath) {
    const navItemList = NavItem.values;

    return ListView.separated(
        itemBuilder: (context, index) {
          final navItem = navItemList[index];
          return DrawerButton(
              onPressed: () => _beamerDelegate.beamToNamed(navItem.url),
              isSelected: currentPath.contains(navItem.url),
              child: Text(navItem.label));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: navItemList.length);
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
  late final MaterialStatesController materialStatesController;

  @override
  void initState() {
    materialStatesController = MaterialStatesController();
    materialStatesController.update(MaterialState.selected, widget.isSelected);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawerButton oldWidget) {
    materialStatesController.update(MaterialState.selected, widget.isSelected);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final drawerTheme = Theme.of(context).extension<MyDrawerTheme>()!;
    final buttonWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: drawerTheme.buttonTheme.style!,
        statesController: materialStatesController,
        child: widget.child,
      ),
    );

    if (widget.isSelected) {
      return Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: Alignment.centerLeft,
          colors: [const Color(0xFF0dd83d), drawerTheme.backgroundColor],
        )),
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
