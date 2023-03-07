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
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: LayoutBuilder(
          builder: (buildContext, boxConstraints) {
            final width = boxConstraints.maxWidth;
            final height = boxConstraints.maxHeight;

            final screenSizeType =
                _getScreenSizeType(screenHeight: height, screenWidth: width);

            return BlocBuilder<MyHomePageBloc, MyHomePageState>(
              builder: (context, state) {
                if (screenSizeType == ScreenSizeType.big) {
                  return _LargeScreenContent(
                    height: height,
                    width: width,
                    state: state,
                    welcomeGreetingTextSize: welcomeGreetingTextSize,
                  );
                }

                // if (screenSizeType == ScreenSizeType.small ||
                //     screenSizeType == ScreenSizeType.medium) {
                //   if (state is MyHomePageInitial) {
                //     top = height / 2;
                //     left = (width / 2) - welcomeGreetingTextSize.width / 2;
                //   }

                //   if (state is HomePageWelcomeGreetingSuccess) {
                //     top = 0;
                //     left = 0;
                //   }

                //   if (state is MyHomePageInitial ||
                //       state is HomePageWelcomeGreetingSuccess) {
                //     return Stack(children: [
                //       AnimatedPositioned(
                //         curve: Curves.fastOutSlowIn,
                //         duration: const Duration(seconds: 3),
                //         left: left,
                //         top: top,
                //         child: AnimatedTextKit(
                //           isRepeatingAnimation: false,
                //           pause: Duration.zero,
                //           onFinished: () {
                //             context
                //                 .read<MyHomePageBloc>()
                //                 .add(HomePageWelcomeGreetingEnded());
                //           },
                //           animatedTexts: [
                //             TypewriterAnimatedText(
                //               'Hello world !',
                //               textStyle: const TextStyle(
                //                 fontSize: 32.0,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //               speed: const Duration(milliseconds: 200),
                //               curve: Curves.bounceInOut,
                //             ),
                //           ],
                //         ),
                //         onEnd: () {
                //           if (state is HomePageWelcomeGreetingSuccess) {
                //             context
                //                 .read<MyHomePageBloc>()
                //                 .add(HomePageWelcomeGreetingMoved());
                //           }
                //         },
                //       ),
                //     ]);
                //   }

                //   if (state is HomePageWelcomeGreetingSuccess) {
                //     return ListView(
                //       children: [

                //       ],
                //     )
                //   }
                // }

                return _LargeScreenContent(
                  height: height,
                  width: width,
                  state: state,
                  welcomeGreetingTextSize: welcomeGreetingTextSize,
                );
              },
            );
          },
        ),
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

class _LargeScreenContent extends StatelessWidget {
  final MyHomePageState state;
  final double height;
  final double width;
  final Size welcomeGreetingTextSize;

  const _LargeScreenContent({
    super.key,
    required this.state,
    required this.height,
    required this.width,
    required this.welcomeGreetingTextSize,
  });

  @override
  Widget build(BuildContext context) {
    double top;
    double left;
    if (state is MyHomePageInitial) {
      // center the greeting
      top = height / 2;
      left = (width / 2) - welcomeGreetingTextSize.width / 2;
    } else {
      top = height / 2 - 100;
      left = 0;
    }

    return Stack(children: [
      AnimatedPositioned(
        curve: Curves.fastOutSlowIn,
        duration: (state is MyHomePageInitial ||
                state is HomePageWelcomeGreetingSuccess)
            ? const Duration(seconds: 1)
            : Duration.zero,
        left: left,
        top: top,
        child: const _AnimatedGreetingSentenceWidget(),
        onEnd: () {
          if (state is HomePageWelcomeGreetingSuccess) {
            context.read<MyHomePageBloc>().add(HomePageWelcomeGreetingMoved());
          }
        },
      ),
      Opacity(
        opacity: state is HomePageWelcomeGreetingMoveSuccess ? 1.0 : 0.0,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: welcomeGreetingTextSize.height + top,
                  ),
                  AnimatedOpacity(
                    opacity:
                        state is HomePageWelcomeGreetingMoveSuccess ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: SizedBox(
                      width: (width / 2),
                      height: (height - welcomeGreetingTextSize.height) / 4,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: _IntroductionWidget(),
                      ),
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
              child: AnimatedOpacity(
                opacity:
                    state is HomePageWelcomeGreetingMoveSuccess ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _MyPhotoWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _AnimatedGreetingSentenceWidget extends StatelessWidget {
  const _AnimatedGreetingSentenceWidget();

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      pause: Duration.zero,
      onFinished: () {
        context.read<MyHomePageBloc>().add(HomePageWelcomeGreetingEnded());
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
    return Expanded(
      child: Row(
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
      ),
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
      height: height * 0.8,
    );
  }
}
