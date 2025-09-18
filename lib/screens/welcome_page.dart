import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/routes/constants.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/utils/text_utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, boxConstraints) {
        final width = boxConstraints.maxWidth;
        final height = boxConstraints.maxHeight;

        final screenSizeType =
            _getScreenSizeType(screenHeight: height, screenWidth: width);

        EdgeInsetsGeometry screenPadding;
        switch (screenSizeType) {
          case ScreenSizeType.big:
            screenPadding = const EdgeInsets.all(50);
            break;
          case ScreenSizeType.medium:
            screenPadding = const EdgeInsets.fromLTRB(20, 50, 20, 20);
            break;
          case ScreenSizeType.small:
            screenPadding =
                const EdgeInsets.symmetric(horizontal: 30, vertical: 50);
            break;
        }

        return _AnimatedGreetingSentenceWidget(
          height: height,
          width: width,
          padding: screenPadding,
          screenSizeType: screenSizeType,
          shouldMove: true,
          shouldShow: true,
        );
      }),
    );
  }

  ScreenSizeType _getScreenSizeType(
      {required double screenHeight, required double screenWidth}) {
    if (screenHeight <= 400 || screenWidth <= 412) {
      return ScreenSizeType.small;
    }

    if (screenWidth >= 820) {
      return ScreenSizeType.big;
    }

    return ScreenSizeType.medium;
  }
}

class _AnimatedGreetingSentenceWidget extends StatelessWidget {
  final bool shouldMove;
  final bool shouldShow;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final ScreenSizeType screenSizeType;

  const _AnimatedGreetingSentenceWidget({
    required this.height,
    required this.width,
    required this.padding,
    required this.screenSizeType,
    required this.shouldMove,
    required this.shouldShow,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    TextStyle titleStyle;

    switch (screenSizeType) {
      case ScreenSizeType.big:
        titleStyle = themeData.textTheme.displayLarge!;
        break;
      case ScreenSizeType.medium:
        titleStyle = themeData.textTheme.displayMedium!;
        break;
      case ScreenSizeType.small:
        titleStyle = themeData.textTheme.headlineSmall!;
        break;
    }

    final Size welcomeGreetingTextSize =
        TextUtils.calculateTextSize('Hello world !', style: titleStyle);

    double top;
    double left;

    // center the greeting
    top = (height / 2) - (padding.vertical / 2);
    left = ((width / 2) - (padding.horizontal / 2)) -
        welcomeGreetingTextSize.width / 2;

    return AnimatedOpacity(
      opacity: shouldShow ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      child: Padding(
        padding: padding,
        child: Stack(children: [
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
            left: left,
            top: top,
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              pause: Duration.zero,
              onFinished: () {
                context.goNamed(AppRouteNames.home);
              },
              animatedTexts: [
                TypewriterAnimatedText(
                  'Hello world !',
                  textStyle: titleStyle,
                  speed: const Duration(milliseconds: 200),
                  curve: Curves.bounceInOut,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
