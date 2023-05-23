import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/my_experience_data.dart';
import 'package:my_flutter_website/widgets/timeline/timeline.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_card.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Timeline(
        cardBuilder: (buildContext, index) {
          return TimelineCard(
            data: timelineEventModels[index],
          );
        },
        onCardTap: (context, index) {
          /// TODO: use beamer
          // Navigator.of(context).push(PageRouteBuilder(
          //     opaque: false,
          //     transitionDuration: const Duration(seconds: 1),
          //     reverseTransitionDuration: const Duration(seconds: 1),
          //     pageBuilder: (context, _, _a) => TimelineItemDetailPage(
          //           tag: timelineEvents[index].title,
          //           card: SelectedTimelineCard(
          //             data: timelineEvents[index],
          //             width: 400,
          //             height: 400,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.rectangle,
          //               borderRadius: BorderRadius.all(Radius.circular(10)),
          //               color: Color.fromARGB(255, 219, 202, 202),
          //               border: Border.all(width: 1),
          //             ),
          //             margin:
          //                 const EdgeInsets.only(left: 8, right: 8, bottom: 2),
          //             padding: const EdgeInsets.all(8),
          //           ),
          //         )));
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
      ),
    );
  }
}
