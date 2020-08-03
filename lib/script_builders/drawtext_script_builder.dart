import 'package:flutter_video_editor/filters/drawtext_filter.dart';
import 'package:flutter_video_editor/script_builders/base_script_builder.dart';

class DrawTextScriptBuilder extends BaseScriptBuilder {
  final List<DrawTextFilter> textFilters;
  final String fontPath;

  DrawTextScriptBuilder(this.textFilters, this.fontPath);

  /// Takes text filters list passed in constructor and builds a script to return
  @override
  String build() {
    var filter = '';

    // Todo: Add support for colors passed in textFilters for ffmpeg
    // drawtext and drawbox are two different filters and must be comma separated
    for (var i = 0; i < textFilters.length; i++) {
      final textFilter = textFilters[i];
      if (textFilter.hasBox) {
        filter +=
            "drawbox=enable='between(t\\,${textFilter.startTimeInSeconds}\\,${textFilter.endTimeInSeconds})':y=${textFilter.textPosition.boxPosition}:color=black:width=iw:height=350:t=fill, ";
      }

      var separator = ', ';
      if (i == textFilters.length - 1) {
        // No need to separate by comma
        separator = '';
      }

      filter +=
          "drawtext=fontfile='$fontPath':fontsize=${textFilter.fontSize}:fontcolor=white:${textFilter.textPosition.textPosition}:text='${textFilter.text}':enable='between(t\\,${textFilter.startTimeInSeconds}\\,${textFilter.endTimeInSeconds})'$separator";
    }

    return filter;
  }

  //Todo: Make a text processor for long strings
}
