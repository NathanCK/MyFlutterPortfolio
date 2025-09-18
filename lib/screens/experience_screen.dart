import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/beam_locations/constants.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/utils/my_experience_data.dart';
import 'package:my_flutter_website/widgets/timeline/timeline.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_card.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_settings.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, boxConstraints) {
        /// TODO: maybe can merge the logic with home screen, and put the screen
        /// type in the app status.
        final screenSizeType = _getScreenSizeType(
            screenHeight: boxConstraints.maxHeight,
            screenWidth: boxConstraints.maxWidth);

        TimelineSettings timelineSettings;

        switch (screenSizeType) {
          case ScreenSizeType.big:
            timelineSettings = const TimelineSettings(eventItemWidth: 500);
            break;
          case ScreenSizeType.medium:
            timelineSettings = const TimelineSettings(eventItemWidth: 400);

            break;

          case ScreenSizeType.small:
            timelineSettings = const TimelineSettings();
        }

        return Timeline(
          cardBuilder: (context, index) {
            return TimelineCard(
              data: timelineEventModels[index],
              screenSizeType: screenSizeType,
            );
          },
          onCardTap: (context, index) {
            context.pushNamed(
              AppRouteNames.experienceDetails,
              pathParameters: {'id': timelineEventModels[index].id.toString()},
            );
          },
          settings: timelineSettings,
          timelineDataList: timelineEventModels,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: const Color.fromARGB(255, 219, 202, 202),
            border: Border.all(),
          ),
          cardMargin: const EdgeInsets.only(left: 48, right: 48, bottom: 2),
          cardPadding: const EdgeInsets.all(16),
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
