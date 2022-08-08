class MovieModel {
  final String title;
  final String desc;
  final String period;
  final String time;

  MovieModel(
      {required this.title,
      required this.desc,
      required this.period,
      required this.time});

  factory MovieModel.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final desc = data['desc'] as String;
    final period = data['period'] as String;
    final time = data['time'] as String;
    return MovieModel(
        title: title ?? '',
        desc: desc ?? '',
        period: period ?? '',
        time: time ?? '');
  }
}
