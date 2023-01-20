import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_api_flutter/models/wp-api.dart';
import 'package:wordpress_api_flutter/screens/post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          child: FutureBuilder(
              future: fetchPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      Map wppost = snapshot.data[index];

                      return PostTile(
                        href: wppost['_links']['wp:featuredmedia'][0]['href'],
                        title: wppost['title']['rendered'].replaceAll(
                            "&#8217;", "'"),
                        desc: wppost['excerpt']['rendered'],
                        content: wppost['content']['rendered'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

class PostTile extends StatefulWidget {
  final String title, desc, href, content;

  PostTile({required this.title,
    required this.desc,
    required this.href,
    required this.content});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  var imageUrl = "";

  Widget shortDescView (){
    return Html(data: widget.desc);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Post(
          imageUrl: imageUrl,
          title: widget.title,
          desc: widget.content,
        )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: fetchPostImageUrl(widget.href),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  imageUrl = snapshot.data['guid']['rendered'];
                  return Image.network(snapshot.data['guid']['rendered']);
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 8,
            ),
            Text(widget.title, style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 5,
            ),
            shortDescView(),
          ],
        ),
      ),
    );
  }
}
