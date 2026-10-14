package com.dexterous.flutterlocalnotifications.models.styles;

import androidx.annotation.Keep;
import java.util.ArrayList;

@Keep
public class MetricStyleInformation extends DefaultStyleInformation {
  public ArrayList<NotificationMetric> metrics;
  public Integer criticalMetricIndex;

  public MetricStyleInformation(
      Boolean htmlFormatTitle,
      Boolean htmlFormatBody,
      ArrayList<NotificationMetric> metrics,
      Integer criticalMetricIndex) {
    super(htmlFormatTitle, htmlFormatBody);
    this.metrics = metrics;
    this.criticalMetricIndex = criticalMetricIndex;
  }
}
