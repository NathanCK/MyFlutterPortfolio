import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_website/screens/experience_screen.dart';

class ExperienceLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return <BeamPage>[
      const BeamPage(
          key: ValueKey('ExperienceScreen'), child: ExperienceScreen())
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/experience/*'];
}
