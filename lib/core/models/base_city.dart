class BaseCity{
  final String title;
  final int id;

  BaseCity({this.title, this.id});

  factory BaseCity.fromJson(Map<String, dynamic> json){
    return BaseCity(
      id: json['woeid'],
      title: json['title']
    );
  }
}