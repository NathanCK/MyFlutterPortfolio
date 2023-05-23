import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/screens/experience_detail_screen.dart';
import 'package:my_flutter_website/screens/experience_screen.dart';

class ExperienceLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final List<BeamPage> pages = [
      const BeamPage(
          key: ValueKey('ExperienceScreen'), child: ExperienceScreen()),
    ];

    if (state.pathParameters.containsKey('experienceId')) {
      final id = int.parse(state.pathParameters['experienceId']!);

      pages.add(
        BeamPage(
          key: ValueKey('experienceId-$id'),
          child: ExperienceDetailPage(id: id),
        ),
      );
    }

    return pages;
  }

  @override
  List<Pattern> get pathPatterns => [
        AppPath.experience,
        AppPath.experienceDetail,
      ];
}
