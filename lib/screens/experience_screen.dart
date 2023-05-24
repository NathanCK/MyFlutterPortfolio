import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/utils/my_experience_data.dart';
import 'package:my_flutter_website/widgets/timeline/timeline.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_card.dart';

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

        return Timeline(
          cardBuilder: (context, index) {
            return TimelineCard(
              data: timelineEventModels[index],
              screenSizeType: screenSizeType,
            );
          },
          onCardTap: (context, index) {
            context.beamToNamed(
                AppPath.getExperienceDetailUri(timelineEventModels[index].id));
          },
          timelineDataList: timelineEventModels,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: const Color.fromARGB(255, 219, 202, 202),
            border: Border.all(),
          ),
          cardMargin: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
          cardPadding: const EdgeInsets.all(8),
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
