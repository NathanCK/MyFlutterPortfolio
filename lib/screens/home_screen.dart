import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/bloc/my_home_page_bloc.dart';
import 'package:my_flutter_website/enum/external_profile_type.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/utils/text_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyHomePageBloc>(
          create: (context) => MyHomePageBloc(),
        ),
      ],
      child: _MyHomeScreen(),
    );
  }
}

class _MyHomeScreen extends StatefulWidget {
  @override
  State<_MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<_MyHomeScreen> {
  late double top;
  late double left;

  @override
  Widget build(BuildContext context) {
    final welcomeGreetingTextSize = TextUtils.calculateTextSize('Hello world !',
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ));

    return Scaffold(
      body: LayoutBuilder(
        builder: (buildContext, boxConstraints) {
          final width = boxConstraints.maxWidth;
          final height = boxConstraints.maxHeight;

          final screenSizeType =
              _getScreenSizeType(screenHeight: height, screenWidth: width);

          EdgeInsetsGeometry screenPadding =
              screenSizeType == ScreenSizeType.big
                  ? const EdgeInsets.all(50)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 50);

          return BlocBuilder<MyHomePageBloc, MyHomePageState>(
            builder: (context, state) {
              if (state is MyHomePageInitial ||
                  state is HomePageWelcomeGreetingSuccess) {
                return _AnimatedGreetingSentenceWidget(
                  screenSizeType: screenSizeType,
                  height: height,
                  width: width,
                  shouldMove: state is HomePageWelcomeGreetingSuccess,
                  shouldShow: state is MyHomePageInitial,
                  welcomeGreetingTextSize: welcomeGreetingTextSize,
                  padding: screenPadding,
                );
              }

              if (screenSizeType == ScreenSizeType.big) {
                return _LargeScreenContent(
                  height: height,
                  width: width,
                  welcomeGreetingTextSize: welcomeGreetingTextSize,
                  padding: screenPadding,
                );
              }

              /// should be small or medium screens.
              return _SmallScreenContent(
                padding: screenPadding,
                welcomeGreetingTextSize: welcomeGreetingTextSize,
              );
            },
          );
        },
      ),
    );
  }

  ScreenSizeType _getScreenSizeType(
      {required double screenHeight, required double screenWidth}) {
    if (screenHeight <= 400 || screenWidth <= 375) {
      return ScreenSizeType.small;
    }

    if (screenWidth >= 820) {
      return ScreenSizeType.big;
    }

    return ScreenSizeType.medium;
  }
}

class _SmallScreenContent extends StatelessWidget {
  final Size welcomeGreetingTextSize;
  final EdgeInsetsGeometry padding;
  final double horizontalPadding;
  final double verticalPadding;

  _SmallScreenContent({
    required this.welcomeGreetingTextSize,
    required this.padding,
  })  : horizontalPadding = padding.horizontal / 2,
        verticalPadding = padding.vertical / 2;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      children: [
        SizedBox(
          height: welcomeGreetingTextSize.height + verticalPadding,
          child: const Text(
            'Hello world !',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const _MyPhotoWidget(),
        const _IntroductionWidget(),
        const _ExternalLinkWidget(),
      ],
    );
  }
}

class _LargeScreenContent extends StatelessWidget {
  final double height;
  final double width;
  final Size welcomeGreetingTextSize;
  final EdgeInsetsGeometry padding;
  final double horizontalPadding;
  final double verticalPadding;

  _LargeScreenContent({
    required this.height,
    required this.width,
    required this.welcomeGreetingTextSize,
    required this.padding,
  })  : horizontalPadding = padding.horizontal / 2,
        verticalPadding = padding.vertical / 2;

  @override
  Widget build(BuildContext context) {
    final top = (height / 2) - verticalPadding - 100;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: welcomeGreetingTextSize.height + top,
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Hello world !',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (width / 2),
                  height: (height - welcomeGreetingTextSize.height) / 4,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: _IntroductionWidget(),
                  ),
                ),
                const _ExternalLinkWidget(),
                SizedBox(
                  height: height * 0.2,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _MyPhotoWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedGreetingSentenceWidget extends StatelessWidget {
  final bool shouldMove;
  final bool shouldShow;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final Size welcomeGreetingTextSize;
  final ScreenSizeType screenSizeType;

  const _AnimatedGreetingSentenceWidget({
    required this.height,
    required this.width,
    required this.padding,
    required this.welcomeGreetingTextSize,
    required this.screenSizeType,
    required this.shouldMove,
    required this.shouldShow,
  });

  @override
  Widget build(BuildContext context) {
    double top;
    double left;
    if (shouldShow) {
      // center the greeting
      top = (height / 2) - (padding.vertical / 2);
      left = ((width / 2) - (padding.horizontal / 2)) -
          welcomeGreetingTextSize.width / 2;
    } else if (screenSizeType == ScreenSizeType.big) {
      // center left for big screen
      top = (height / 2) - (padding.vertical / 2) - 100;
      left = 0;
    } else {
      // top left for small screen
      top = 0;
      left = 0;
    }

    return Padding(
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
              context
                  .read<MyHomePageBloc>()
                  .add(HomePageWelcomeGreetingEnded());
            },
            animatedTexts: [
              TypewriterAnimatedText(
                'Hello world !',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 200),
                curve: Curves.bounceInOut,
              ),
            ],
          ),
          onEnd: () {
            if (shouldMove) {
              context
                  .read<MyHomePageBloc>()
                  .add(HomePageWelcomeGreetingMoved());
            }
          },
        ),
      ]),
    );
  }
}

class _IntroductionWidget extends StatelessWidget {
  const _IntroductionWidget();

  @override
  Widget build(BuildContext context) {
    return const AutoSizeText(
      'My name is Kin Chan, but you can call me Nathan.\n'
      'I am a Software Engineer, who develops both frontend and backend application.',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 15,
    );
  }
}

class _ExternalLinkWidget extends StatelessWidget {
  final List<ExternalProfileType> _externalTypeList =
      ExternalProfileType.values;

  const _ExternalLinkWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_externalTypeList.length, (index) {
        final externalType = _externalTypeList[index];
        return IconButton(
            iconSize: 32,
            onPressed: () async {
              final uri = Uri.parse(externalType.url);
              if (!await launchUrl(uri)) {
                throw Exception('Could not launch $uri');
              }
            },
            icon: Image.asset(externalType.iconPath));
      }),
    );
  }
}

class _MyPhotoWidget extends StatelessWidget {
  const _MyPhotoWidget();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Image.asset(
      'assets/images/gumwall.jpeg',
      height: height * 0.6,
    );
  }
}
