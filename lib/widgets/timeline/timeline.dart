import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_event_box_painter.dart';
import 'package:my_flutter_website/widgets/timeline/timeline_settings.dart';

class Timeline extends StatefulWidget {
  final List<TimelineEventModel> timelineDataList;
  final TimelineSettings settings;
  final Widget Function(BuildContext buildContext, int index) cardBuilder;
  final void Function(BuildContext buildContext, int index)? onCardTap;
  final EdgeInsetsGeometry? cardPadding;
  final EdgeInsetsGeometry? cardMargin;

  final Decoration? decoration;

  const Timeline({
    super.key,
    required this.timelineDataList,
    required this.cardBuilder,
    this.settings = const TimelineSettings(),
    this.decoration,
    this.cardMargin,
    this.cardPadding,
    this.onCardTap,
  });

  @override
  State<StatefulWidget> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  static const TextStyle _defaultMonthTextStyle =
      TextStyle(fontSize: 10, color: Colors.black);
  static const TextStyle _defaultYearTextStyle =
      TextStyle(fontSize: 16, color: Colors.black);

  late final ScrollController _scrollController;

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _jumpToIndex(0));
  }

  Future<void> _jumpToIndex(int index) async {
    double scrollToOffset = (index) * (widget.settings.eventItemWidth) +
        (widget.settings.eventItemWidth / 2);

    await _scrollController.animateTo(scrollToOffset,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextStyle monthTextStyle = widget.settings.monthTextStyle ??
        themeData.textTheme.labelMedium ??
        _defaultMonthTextStyle;
    final TextStyle yearTextStyle = widget.settings.yearTextStyle ??
        themeData.textTheme.labelLarge ??
        _defaultYearTextStyle;

    return Center(
      child: SizedBox(
        height: 550, // TODO: should dynamically change the height.
        child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.unknown
            }),
            child: Listener(
              onPointerSignal: (PointerSignalEvent event) {
                if (event is PointerScrollEvent) {
                  _scrollController
                      .jumpTo(_scrollController.offset + event.scrollDelta.dy);
                }
              },
              child: CustomScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    child:
                        SizedBox(width: MediaQuery.of(context).size.width / 2),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final Widget card = widget.cardBuilder(context, index);

                        final Widget outerCard = Hero(
                          tag:
                              'hero_tag_for_timeline_event_id:${widget.timelineDataList[index].id}',
                          child: Center(
                            child: Container(
                              width: widget.settings.eventItemWidth,
                              decoration: widget.decoration,
                              margin: widget.cardMargin,
                              child: InkWell(
                                onTap: () async {
                                  await _jumpToIndex(index);
                                  if (widget.onCardTap != null && mounted) {
                                    widget.onCardTap!(context, index);
                                  }
                                },
                                child: Container(
                                  padding: widget.cardPadding,
                                  child: card,
                                ),
                              ),
                            ),
                          ),
                        );

                        return _TimelineCardHolder(
                          data: widget.timelineDataList[index],
                          card: outerCard,
                          isFirst: index == 0,
                          isLast: index == widget.timelineDataList.length - 1,
                          cardWidth: widget.settings.eventItemWidth,
                          width: widget.settings.eventItemWidth,
                          timelineBarHeight: widget.settings.bottomAreaHeight,
                          timelineGap: index.isEven
                              ? widget.settings.connectorHeightOnEven
                              : widget.settings.connectorHeightOnOdd,
                          makerIconSize: widget.settings.eventMakerSize,
                          isSelected: false,
                          displayEventTime:
                              widget.settings.shouldDisplayEventTime,
                          monthTextStyle: monthTextStyle,
                          yearTextStyle: yearTextStyle,
                          strokeColor: widget.settings.lineColor,
                          strokeWidth: widget.settings.lineWidth,
                        );
                      },
                      childCount: widget.timelineDataList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child:
                        SizedBox(width: MediaQuery.of(context).size.width / 2),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class _TimelineCardHolder extends StatelessWidget {
  final TimelineEventModel data;
  final Widget card;
  final double cardWidth;
  final bool isFirst;
  final bool isLast;
  final bool isSelected;
  final TextStyle monthTextStyle;
  final TextStyle yearTextStyle;
  final double width;
  final double timelineGap;
  final double makerIconSize;
  final double timelineBarHeight;
  final bool displayEventTime;
  final Color strokeColor;
  final double strokeWidth;

  const _TimelineCardHolder({
    required this.data,
    required this.card,
    required this.cardWidth,
    required this.isFirst,
    required this.isLast,
    required this.width,
    required this.isSelected,
    required this.monthTextStyle,
    required this.yearTextStyle,
    required this.timelineGap,
    required this.makerIconSize,
    required this.timelineBarHeight,
    required this.displayEventTime,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          child: CustomPaint(
            size: Size.fromWidth(width),
            painter: TimelineEventBoxPainter(
              date: data.startDate,
              makerIconSize: makerIconSize,
              timelineGap: timelineGap,
              isFirst: isFirst,
              isLast: isLast,
              monthTextStyle: monthTextStyle,
              yearTextStyle: yearTextStyle,
              timelineBarHeight: timelineBarHeight,
              displayEventTime: displayEventTime,
              strokeColor: strokeColor,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
        Positioned(
          bottom: timelineBarHeight - (makerIconSize / 2),
          right: 0,
          left: 0,
          child: SizedBox.square(
            dimension: makerIconSize,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fill,
                child: data.timelineDotWidget ??
                    Icon(
                      Icons.event,
                      size: makerIconSize,
                    ),
              ),
            ),
          ),
        ),
        Positioned.directional(
          bottom: timelineGap,
          textDirection: TextDirection.ltr,
          start: -cardWidth / 2 + width / 2,
          width: cardWidth,
          child: card,
        ),
      ],
    );
  }
}
