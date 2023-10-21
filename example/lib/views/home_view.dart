import 'package:flutter/material.dart';
import 'package:blogger/blogger.dart';

import 'page_view.dart';
import 'post_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String key = const String.fromEnvironment('API_KEY');
  List<String> blogIds = const String.fromEnvironment('BLOG_IDS').split(',');
  Future<List<BlogsModel>> getAllBlogs() async {
    final res = await Blogger(apiKey: key, blogId: blogIds[0])
        .getBlogs(blogIds: blogIds);

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<BlogsModel>>(
          future: getAllBlogs(),
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Blog ${index + 1} - ${snapshot.data![index].name}'),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PagesView(
                                              blogId: blogIds[index],
                                              apiKey: key,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.pages),
                                label: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Pages'),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostView(
                                              blogId: blogIds[index],
                                              apiKey: key,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.post_add),
                                label: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Posts'),
                                )),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
        ),
      ),
    );
  }
}
