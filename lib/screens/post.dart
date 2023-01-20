import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Post extends StatefulWidget {
  final String imageUrl, title, desc;

  const Post(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  Widget postContent(htmlContent) {
    return Html(data: htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.imageUrl),
              SizedBox(height: 8),
              Text(widget.title, style: TextStyle(fontSize: 18)),
              SizedBox(height: 4),
              postContent(widget.desc)
            ],
          ),
        ),
      ),
    );
  }
}
