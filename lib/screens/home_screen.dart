import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/bloc/analytics_bloc.dart';
import 'package:my_flutter_website/bloc/my_home_page_bloc.dart';
import 'package:my_flutter_website/enum/external_profile_type.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/generated/l10n.dart';
import 'package:my_flutter_website/utils/text_utils.dart';
import 'package:my_flutter_website/utils/themed_texts.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (buildContext, boxConstraints) {
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

          return BlocBuilder<MyHomePageBloc, MyHomePageState>(
            builder: (context, state) {
              if (screenSizeType == ScreenSizeType.big ||
                  screenSizeType == ScreenSizeType.medium) {
                return _LargeScreenContent(
                  height: height,
                  width: width,
                  padding: screenPadding,
                );
              }

              /// should be small or medium screens.
              return _SmallScreenContent(
                padding: screenPadding,
              );
            },
          );
        },
      ),
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

class _SmallScreenContent extends StatelessWidget {
  static const double _iconAndInfoSpacing = 16;
  static const double _photoSize = 32;
  static const double _photoBorderRadius = 4;
  final EdgeInsetsGeometry padding;
  final double horizontalPadding;
  final double verticalPadding;

  _SmallScreenContent({
    required this.padding,
  })  : horizontalPadding = padding.horizontal / 2,
        verticalPadding = padding.vertical / 2;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final nameWidth = width -
        (horizontalPadding * 2) -
        ((_photoSize + _photoBorderRadius) * 2) -
        _iconAndInfoSpacing;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.ease,
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double opacity, Widget? child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: ListView(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const _MySmallPhotoWidget(
                photoSize: _photoSize,
                borderRadius: _photoBorderRadius,
              ),
              const SizedBox(
                width: _iconAndInfoSpacing,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: nameWidth,
                    child: const DisplayLargeText(
                      'Kin (Nathan) Chan',
                      textAlign: TextAlign.center,
                      maxFontSize: 32,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const _ExternalLinkWidget(
                    iconSize: 32,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ],
              )
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Divider(thickness: 2),
              SizedBox(
                height: 8,
              ),
              _IntroductionWidget(),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LargeScreenContent extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double horizontalPadding;
  final double verticalPadding;

  _LargeScreenContent({
    required this.height,
    required this.width,
    required this.padding,
  })  : horizontalPadding = padding.horizontal / 2,
        verticalPadding = padding.vertical / 2;

  @override
  Widget build(BuildContext context) {
    final welcomeGreetingTextStyle = Theme.of(context).textTheme.displayLarge!;
    final Size welcomeGreetingTextSize = TextUtils.calculateTextSize(
        'Hello world !',
        style: welcomeGreetingTextStyle);

    return Center(
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double opacity, Widget? child) {
            return Opacity(
              opacity: opacity,
              child: Padding(
                padding: padding,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: welcomeGreetingTextSize.height,
                                child: const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: DisplayLargeText('Hello world !')),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: _IntroductionWidget(),
                              ),
                              const _ExternalLinkWidget(),
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox.shrink(),
                        ),
                        const Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _MyLargePhotoWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _IntroductionWidget extends StatelessWidget {
  const _IntroductionWidget();

  @override
  Widget build(BuildContext context) {
    return BodyLargeText(
      S.of(context).home_page_intro_statement,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
      maxLines: 15,
      stepGranularity: 0.1,
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

              if (context.mounted) {
                context
                    .read<AnalyticsBloc>()
                    .add(AnalyticsOutLinkButtonPressed(externalType.name));
              }
            },
            icon: Image.asset(
              externalType.iconPath,
              height: iconSize,
              width: iconSize,
            ));
      }),
    );
  }
}

class _MySmallPhotoWidget extends StatelessWidget {
  final double photoSize;
  final double borderRadius;

  const _MySmallPhotoWidget(
      {required this.photoSize, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: photoSize + borderRadius,
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/gum_wall.jpeg',
        height: height * 0.5,
      ),
    );
  }
}
