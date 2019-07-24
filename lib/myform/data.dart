class Data {
  final int id;
  final String title;
  final String descp;
  final int phone;
  final int pin;


  Data._({this.id, this.title, this.descp, this.phone, this.pin});

  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data._(
      id: json['id'],
      title: json['title'],
      descp: json['descp'],
      phone: json['phone'],
      pin: json['pin'],
    );
  }
}