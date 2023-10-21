import 'package:blogger/blogger.dart';
import 'package:flutter/material.dart';
import 'html_view.dart';

class PagesView extends StatefulWidget {
  final String blogId;
  final String apiKey;
  const PagesView({super.key, required this.blogId, required this.apiKey});

  @override
  State<PagesView> createState() => _PageViewState();
}

class _PageViewState extends State<PagesView> {
  Future<PageModel> getPages() async {
    final res =
        await Blogger(apiKey: widget.apiKey, blogId: widget.blogId).getPages();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pages'),
      ),
      body: FutureBuilder(
          future: getPages(),
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
                  itemCount: snapshot.data!.items!.length,
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
