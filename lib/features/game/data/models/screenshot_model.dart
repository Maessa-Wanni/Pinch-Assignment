class ScreenShotsModel {
  final int? id;
  final String? url;

  ScreenShotsModel({
    this.id,
    this.url,
  });

  ScreenShotsModel copyWith({
    int? id,
    String? url,
  }) =>
      ScreenShotsModel(
        id: id ?? this.id,
        url: url ?? this.url,
      );
}
