import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_website/screens/home_screen.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return <BeamPage>[
      const BeamPage(key: ValueKey('Home'), child: MyHomePage())
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/home/*'];
}
