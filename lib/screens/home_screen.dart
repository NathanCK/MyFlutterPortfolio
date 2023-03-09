import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/bloc/my_home_page_bloc.dart';
import 'package:my_flutter_website/enum/external_profile_type.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/generated/l10n.dart';
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
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double opacity, Widget? child) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _MySmallPhotoWidget(photoSize: 32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Kin (Nathan) Chan',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _ExternalLinkWidget(
                        iconSize: 16,
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  )
                ],
              ),
              Opacity(
                opacity: opacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 8,
                    ),
                    Divider(thickness: 2),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Hello world !',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _IntroductionWidget(),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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

    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double opacity, Widget? child) {
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
                      Opacity(
                        opacity: opacity,
                        child: Column(
                          children: [
                            SizedBox(
                              width: (width / 2),
                              height:
                                  (height - welcomeGreetingTextSize.height) / 4,
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
                    ],
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity: opacity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _MyLargePhotoWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// class _GreetingToRealContentTransitWidget extends StatelessWidget {

// }

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
    return AutoSizeText(
      S.of(context).home_page_intro_statement,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 15,
    );
  }
}

class _ExternalLinkWidget extends StatelessWidget {
  final double iconSize;
  final EdgeInsetsGeometry? padding;
  final List<ExternalProfileType> _externalTypeList =
      ExternalProfileType.values;

  const _ExternalLinkWidget({this.iconSize = 32, this.padding});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_externalTypeList.length, (index) {
        final externalType = _externalTypeList[index];
        return IconButton(
            padding: padding,
            iconSize: iconSize,
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

class _MySmallPhotoWidget extends StatelessWidget {
  final double photoSize;

  const _MySmallPhotoWidget({required this.photoSize});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: photoSize + 4,
      child: CircleAvatar(
        radius: photoSize,
        backgroundImage: const AssetImage(
          'assets/images/gum_wall.jpeg',
        ),
      ),
    );
  }
}

class _MyLargePhotoWidget extends StatelessWidget {
  const _MyLargePhotoWidget();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Image.asset(
      'assets/images/gum_wall.jpeg',
      height: height * 0.5,
    );
  }
}
