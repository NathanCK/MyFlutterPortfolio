import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/bloc/experience_detail_bloc.dart';
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
      child: _ExperienceDetailPageContent(),
    );
  }
}

class _ExperienceDetailPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(112, 158, 158, 158),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Beamer.of(context).popToNamed(AppPath.experience);
            },
          ),
          BlocBuilder<ExperienceDetailBloc, ExperienceDetailState>(
            builder: (context, state) {
              if (state is ExperienceDetailLoadSuccess) {
                return Center(
                  child: SelectedTimelineCard(
                    data: state.data,
                    width: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(255, 219, 202, 202),
                      border: Border.all(width: 1),
                    ),
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                    padding: const EdgeInsets.all(8),
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
          )
        ],
      ),
    );
  }
}
