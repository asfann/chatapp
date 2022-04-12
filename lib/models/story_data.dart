import 'package:meta/meta.dart';

@immutable
class StoryData {
  const StoryData({
    required this.url,
    required this.name
});

final String name;
final String url;
}