import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/bloc/experience_detail_bloc.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_detail_card.dart';

class ExperienceDetailPage extends StatelessWidget {
  final int id;

  const ExperienceDetailPage({
    super.key,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExperienceDetailBloc(id: id),
        ),
      ],
      child: _ExperienceDetailPageContent(id: id),
    );
  }
}

class _ExperienceDetailPageContent extends StatelessWidget {
  final int id;

  const _ExperienceDetailPageContent({required this.id});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExperienceDetailBloc>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(112, 158, 158, 158),
      body: LayoutBuilder(builder: (context, boxConstraints) {
        /// TODO: maybe can merge the logic with home screen, and put the screen
        /// type in the app status.
        final screenSizeType = _getScreenSizeType(
            screenHeight: boxConstraints.maxHeight,
            screenWidth: boxConstraints.maxWidth);

        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Beamer.of(context).popToNamed(AppPath.experience);
              },
            ),
            Center(
              child: SizedBox(
                width: 600,
                child: Hero(
                  tag: 'hero_tag_for_timeline_event_id:$id',
                  child:
                      BlocBuilder<ExperienceDetailBloc, ExperienceDetailState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is ExperienceDetailLoadSuccess) {
                        return Center(
                          child: SelectedTimelineCard(
                            data: state.data,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: const Color.fromARGB(255, 219, 202, 202),
                              border: Border.all(width: 1),
                            ),
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 2),
                            padding: const EdgeInsets.all(20),
                            screenSizeType: screenSizeType,
                          ),
                        );
                      }

                      if (state is ExperienceDetailLoadFailed) {
                        return const Center(
                          child: Text('failed to load the data'),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
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
