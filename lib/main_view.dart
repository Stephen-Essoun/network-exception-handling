// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
// import 'package:location/location.dart';

import 'post_model_class.dart';

class ErrorHandling extends StatefulWidget {
  const ErrorHandling({super.key});

  @override
  State<ErrorHandling> createState() => _ErrorHandlingState();
}

class _ErrorHandlingState extends State<ErrorHandling> {
  Future<Result<Post, Exception>> fetchPost() async {
    try {
      final Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

      final response = await http.get(url);

      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return Success(Post.fromJson(data));
        default:
          return Error(Exception(response.reasonPhrase));
      }
    } on SocketException catch (_) {
      return Error(_);
    }
  }

  Future<Post>? post;

  @override
  void initState() {
    super.initState();
    try {
      final post = fetchPost();
      // final  message =  post.when(
      //     (exception) => debugPrint(exception),
      //     (location) => debugPrint(location)
      //   );
    } on Exception catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<Post>(
        future: post,
        builder: (context, abc) {
          if (abc.hasData) {
            return Center(child: Text(abc.data!.title!));
          } else if (!abc.hasData) {
            return Center(child: Text("Nothing to show"));
          }

          // By default, it show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator(), Text('Loading...')],
            ),
          );
        },
      ),
    ));
  }
}
