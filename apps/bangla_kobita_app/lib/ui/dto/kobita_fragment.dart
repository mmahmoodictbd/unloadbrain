import 'package:html/parser.dart' show parse;

class KobitaFragment {
  final String title;
  final String author;
  final String body;

  KobitaFragment({this.title, this.author, this.body});

  factory KobitaFragment.fromJson(Map<String, dynamic> json) {
    var document = parse(json['excerpt'] as String);
    // print(document.outerHtml);

    return KobitaFragment(
      title: json['title'] as String,
      author: json['author'] as String,
      body: parse(json['excerpt'] as String).body.text,
    );
  }
}
