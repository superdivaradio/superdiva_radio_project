import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WordpressScreen extends StatefulWidget {
  const WordpressScreen({super.key});

  @override
  _WordpressScreenState createState() => _WordpressScreenState();
}

class _WordpressScreenState extends State<WordpressScreen> {
  List _posts = [];

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://tu-sitio.com/wp-json/wp/v2/posts'));
    final data = json.decode(response.body);
    setState(() {
      _posts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WordPress Posts")),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(_posts[index]['title']['rendered']),
            subtitle: Text(_posts[index]['excerpt']['rendered']),
          );
        },
      ),
    );
  }
}