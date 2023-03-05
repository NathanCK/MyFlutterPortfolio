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
  final List<ExternalProfileType> _externalTypeList =
      ExternalProfileType.values;
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
                  if (state is MyHomePageInitial) {
                    // center the greeting
                    top = height / 2;
                    left = (width / 2) - welcomeGreetingTextSize.width / 2;
                  }

                  if (state is HomePageWelcomeGreetingSuccess ||
                      state is HomePageWelcomeGreetingMoveSuccess) {
                    top = height / 2 - 100;
                    left = 0;
                  }

                  if (state is MyHomePageInitial ||
                      state is HomePageWelcomeGreetingSuccess ||
                      state is HomePageWelcomeGreetingMoveSuccess) {
                    return Stack(children: [
                      AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        duration: (state is MyHomePageInitial ||
                                state is HomePageWelcomeGreetingSuccess)
                            ? const Duration(seconds: 1)
                            : Duration.zero,
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
                          if (state is HomePageWelcomeGreetingSuccess) {
                            context
                                .read<MyHomePageBloc>()
                                .add(HomePageWelcomeGreetingMoved());
                          }
                        },
                      ),
                      Opacity(
                        opacity: state is HomePageWelcomeGreetingMoveSuccess
                            ? 1.0
                            : 0.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height:
                                        welcomeGreetingTextSize.height + top,
                                  ),
                                  AnimatedOpacity(
                                    opacity: state
                                            is HomePageWelcomeGreetingMoveSuccess
                                        ? 1.0
                                        : 0.0,
                                    duration: const Duration(seconds: 1),
                                    child: SizedBox(
                                      width: (width / 2),
                                      height: (height -
                                              welcomeGreetingTextSize.height) /
                                          4,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: AutoSizeText(
                                          'My name is Kin Chan, but you can call me Nathan.\n'
                                          'I am a Software Engineer, who develops both frontend and backend application.',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: List.generate(
                                          _externalTypeList.length, (index) {
                                        final externalType =
                                            _externalTypeList[index];
                                        return IconButton(
                                            iconSize: 32,
                                            onPressed: () async {
                                              final uri =
                                                  Uri.parse(externalType.url);
                                              if (!await launchUrl(uri)) {
                                                throw Exception(
                                                    'Could not launch $uri');
                                              }
                                            },
                                            icon: Image.asset(
                                                externalType.iconPath));
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: AnimatedOpacity(
                                opacity:
                                    state is HomePageWelcomeGreetingMoveSuccess
                                        ? 1.0
                                        : 0.0,
                                duration: const Duration(seconds: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/gumwall.jpeg',
                                      height: height * 0.8,
                                    ),
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
                //       state is HomePageWelcomeGreetingSuccess ||
                //       state is HomePageWelcomeGreetingMoveSuccess) {
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
                //       Positioned(
                //         top: top + welcomeGreetingTextSize.height,
                //         left: left,
                //         child: AnimatedOpacity(
                //             opacity: state is HomePageWelcomeGreetingMoveSuccess
                //                 ? 1.0
                //                 : 0.0,
                //             duration: const Duration(seconds: 1),
                //             child: SizedBox(
                //               width: width,
                //               height: height,
                //               child: const AutoSizeText(
                //                 'My name is Kin Chan, but you can call me Nathan.\n'
                //                 'I am a Software Engineer, who develops both frontend and backend application.',
                //                 style: TextStyle(
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //                 maxLines: 15,
                //               ),
                //             )),
                //       )
                //     ]);
                //   }
                // }

                return const Center(
                  child: CircularProgressIndicator(),
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
