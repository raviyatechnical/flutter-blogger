import 'package:blogger/blogger.dart';
import 'show_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HTMLView extends StatefulWidget {
  final PostItemModel data;
  const HTMLView({super.key, required this.data});

  @override
  State<HTMLView> createState() => _HTMLViewState();
}

class _HTMLViewState extends State<HTMLView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title!),
        actions: [
          InkWell(
            onTap: () {
              print(widget.data.replies!.postComments!);
              ShowComments().displayshowModalBottomSheet(
                context,
                widget.data.replies!.postComments!,
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.comment),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              widget.data.content!,
              customStylesBuilder: (element) {
                if (element.classes.contains('foo')) {
                  return {'color': 'red'};
                }

                return null;
              },
              //customWidgetBuilder: (element) {},
              onTapUrl: (url) async {
                if (!await launchUrl(Uri.parse(url))) {
                  throw 'Could not launch $url';
                }
                return true;
              },
              onErrorBuilder: (context, element, error) =>
                  Text('$element error: $error'),
              onLoadingBuilder: (context, element, loadingProgress) =>
                  const CircularProgressIndicator(),
              renderMode: RenderMode.column,
              textStyle: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
