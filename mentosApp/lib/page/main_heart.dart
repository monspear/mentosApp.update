import 'package:flutter/material.dart';
import 'package:mentos/page/main_home.dart';


class MainHeart extends StatefulWidget {
  final int number;
  final List<Post> likedPosts;
  final Function(Post) toggleLike;

  const MainHeart({
    required this.number,
    required this.likedPosts,
    required this.toggleLike,
    Key? key,
  }) : super(key: key);

  @override
  _MainHeartState createState() => _MainHeartState();
}

class _MainHeartState extends State<MainHeart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('찜 목록'),
      ),
      body: ListView.builder(
        itemCount: widget.likedPosts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.likedPosts[index].title),
            subtitle: Text(widget.likedPosts[index].contents),
          );
        },
      ),
      ),
    );
  }
}
