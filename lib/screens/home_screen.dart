import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/bloc/my_home_page_bloc.dart';
import 'package:my_flutter_website/utils/text_utils.dart';

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

          return BlocBuilder<MyHomePageBloc, MyHomePageState>(
            builder: (context, state) {
              if (state is MyHomePageInitial) {
                top = height / 2;
                left = (width / 2) - welcomeGreetingTextSize.width / 2;
              }

              if (state is HomePageWelcomeGreetingSuccess) {
                top = 50;
                left = 50;
              }

              if (state is MyHomePageInitial ||
                  state is HomePageWelcomeGreetingSuccess ||
                  state is HomePageWelcomeGreetingMoveSuccess) {
                return Stack(children: [
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
                    onEnd: () => context
                        .read<MyHomePageBloc>()
                        .add(HomePageWelcomeGreetingMoved()),
                  ),
                  Positioned(
                    top: top + welcomeGreetingTextSize.height,
                    left: left,
                    child: AnimatedOpacity(
                        opacity: state is HomePageWelcomeGreetingMoveSuccess
                            ? 1.0
                            : 0.0,
                        duration: const Duration(seconds: 1),
                        child: SizedBox(
                          width: width - 100,
                          height: height - 100,
                          child: const AutoSizeText(
                            'My name is Kin Chan, but you can call me Nathan.\n'
                            'I am a Software Engineer, who develops both frontend and backend application.',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 15,
                          ),
                        )),
                  )
                ]);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
