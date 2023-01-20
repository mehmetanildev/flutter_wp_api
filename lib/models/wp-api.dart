import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://oyungibi.com/wp-json/wp/v2/posts'), headers: {
    'Accept': 'application/json',
  });

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

Future fetchPostImageUrl(href) async {
  final response = await http.get(Uri.parse(href), headers: {
    'Accept': 'application/json',
  });

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}
