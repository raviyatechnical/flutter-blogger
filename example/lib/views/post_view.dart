import 'package:blogger/blogger.dart';
import 'package:flutter/material.dart';
import 'html_view.dart';

class PostView extends StatefulWidget {
  final String blogId;
  final String apiKey;
  const PostView({super.key, required this.blogId, required this.apiKey});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Future<PostModel> getAllpost() async {
    final res =
        await Blogger(apiKey: widget.apiKey, blogId: widget.blogId).getPosts(
      includeComment: true,
    );

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder(
          future: getAllpost(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Try Again'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.items?.length ?? 0,
                  itemBuilder: (ctx, index) {
                    return Center(
                      child: Card(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HTMLView(
                                      data: snapshot.data!.items![index],
                                    )),
                          );
                        },
                        child: Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child:
                                    Text(snapshot.data!.items![index].title!))),
                      )),
                    );
                  });
            }
          })),
    );
  }
}
