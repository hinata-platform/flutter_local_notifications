package com.dexterous.flutterlocalnotifications.models.styles;

import androidx.annotation.Keep;
import java.io.Serializable;

@Keep
public class NotificationMetric implements Serializable {
  public static final int KIND_TIMER = 0;
  public static final int KIND_STOPWATCH = 1;
  public static final int KIND_PAUSED_TIMER = 2;
  public static final int KIND_PAUSED_STOPWATCH = 3;
  public static final int KIND_TEXT = 4;

  public static final int FORMAT_ADAPTIVE = 0;
  public static final int FORMAT_CHRONOMETER = 1;

  public Integer kind;
  public String label;
  public Long timeMillis;
  public Long durationMillis;
  public String text;
  public String unit;
  public Integer format;

  public NotificationMetric(
      Integer kind,
      String label,
      Long timeMillis,
      Long durationMillis,
      String text,
      String unit,
      Integer format) {
    this.kind = kind;
    this.label = label;
    this.timeMillis = timeMillis;
    this.durationMillis = durationMillis;
    this.text = text;
    this.unit = unit;
    this.format = format;
  }
}
