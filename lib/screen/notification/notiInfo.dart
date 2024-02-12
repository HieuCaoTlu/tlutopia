// ignore_for_file: file_names
class NotificationInformation {
  final String title;
  final String source;
  final String description;

  NotificationInformation(this.title, this.source, this.description);

  String getTitle() {
    return title;
  }

  String getSource() {
    return source;
  }

  String getDescription() {
    return description;
  }
}
