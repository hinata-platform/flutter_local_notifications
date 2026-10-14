import 'default_style_information.dart';

/// How a [NotificationMetric] built from a time difference is written out.
enum MetricTimeFormat {
  /// The system picks a format that suits the length, e.g. `5 min` or
  /// `1 h 20 min`.
  ///
  /// Corresponds to `Notification.Metric.TimeDifference.FORMAT_ADAPTIVE`.
  adaptive,

  /// A running clock, e.g. `12:34`.
  ///
  /// Corresponds to `Notification.Metric.TimeDifference.FORMAT_CHRONOMETER`.
  chronometer,
}

/// The kind of value a [NotificationMetric] holds.
enum NotificationMetricKind {
  /// Counts down to [NotificationMetric.time].
  timer,

  /// Counts up from [NotificationMetric.time].
  stopwatch,

  /// A timer paused with [NotificationMetric.duration] left.
  pausedTimer,

  /// A stopwatch paused at [NotificationMetric.duration].
  pausedStopwatch,

  /// A fixed [NotificationMetric.text], with an optional unit.
  text,
}

/// A single value shown by a [MetricStyleInformation], with its [label].
///
/// The system keeps time based values up to date by itself, so the
/// notification does not need to be posted again for the value to move.
class NotificationMetric {
  /// A timer counting down to [endsAt].
  const NotificationMetric.timer(
    DateTime endsAt, {
    required this.label,
    this.format = MetricTimeFormat.chronometer,
  })  : kind = NotificationMetricKind.timer,
        time = endsAt,
        duration = null,
        text = null,
        unit = null;

  /// A stopwatch counting up from [startedAt].
  const NotificationMetric.stopwatch(
    DateTime startedAt, {
    required this.label,
    this.format = MetricTimeFormat.chronometer,
  })  : kind = NotificationMetricKind.stopwatch,
        time = startedAt,
        duration = null,
        text = null,
        unit = null;

  /// A paused timer with [remaining] left.
  const NotificationMetric.pausedTimer(
    Duration remaining, {
    required this.label,
    this.format = MetricTimeFormat.chronometer,
  })  : kind = NotificationMetricKind.pausedTimer,
        time = null,
        duration = remaining,
        text = null,
        unit = null;

  /// A paused stopwatch at [elapsed].
  const NotificationMetric.pausedStopwatch(
    Duration elapsed, {
    required this.label,
    this.format = MetricTimeFormat.chronometer,
  })  : kind = NotificationMetricKind.pausedStopwatch,
        time = null,
        duration = elapsed,
        text = null,
        unit = null;

  /// A fixed [value], optionally followed by its [unit], e.g. `3` and `laps`.
  const NotificationMetric.text(String value, {required this.label, this.unit})
      : kind = NotificationMetricKind.text,
        time = null,
        duration = null,
        text = value,
        format = MetricTimeFormat.adaptive;

  /// What kind of value this is.
  final NotificationMetricKind kind;

  /// The label shown with the value.
  final String label;

  /// The point in time a timer ends or a stopwatch started at.
  final DateTime? time;

  /// What is left of a paused timer, or the time on a paused stopwatch.
  final Duration? duration;

  /// The value of a [NotificationMetric.text].
  final String? text;

  /// The unit of a [NotificationMetric.text].
  final String? unit;

  /// How a time based value is written out.
  final MetricTimeFormat format;
}

/// Shows up to three [metrics] side by side, on Android 17 and newer.
///
/// It is one of the styles a notification may use to be promoted as a Live
/// Update, see [AndroidNotificationDetails.requestPromotedOngoing]. With
/// [criticalMetricIndex] one of the metrics is marked as the one that matters
/// most, which the system may show in places with room for only one value.
///
/// On older versions of Android the notification is shown with the default
/// style, so its title and body should make sense on their own.
class MetricStyleInformation extends DefaultStyleInformation {
  /// Constructs an instance of [MetricStyleInformation].
  const MetricStyleInformation(
    this.metrics, {
    this.criticalMetricIndex,
    bool htmlFormatContent = false,
    bool htmlFormatTitle = false,
  }) : super(htmlFormatContent, htmlFormatTitle);

  /// The values to show.
  final List<NotificationMetric> metrics;

  /// The index in [metrics] of the value that matters most, if any.
  final int? criticalMetricIndex;
}
