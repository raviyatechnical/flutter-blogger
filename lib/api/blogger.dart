import 'dart:convert';
import 'package:blogger/config/constants.dart';
import 'package:blogger/models/bloglocale.model.dart';
import 'package:blogger/models/blogpage.model.dart';
import 'package:blogger/models/blogpost.model.dart';
import 'package:blogger/models/blogs.models.dart';
import 'package:blogger/models/pages.model.dart';
import 'package:blogger/models/post.model.dart';
import 'package:blogger/models/postcomments.dart';
import 'package:blogger/models/postitem.model.dart';
import 'package:blogger/models/replies.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// [Blogger] This package will help to get all the blogger data from google and it's need API
///
/// if you don't have API go to https://console.cloud.google.com/ and create your API
class Blogger {
  String apiKey;
  String blogId;
  Blogger({required this.apiKey, required this.blogId});

  /// [getBlogs] This function will return all [Blog].
  ///
  /// We need to pass listof [BlogIds].
  ///
  /// if the [statusCode] is 200 then the API call is Successful elase the will be updated in [BlogsModel.error] field.
  ///
  /// if [BlogsModel.error] is null then your all is Successful.
  Future<List<BlogsModel>> getBlogs({required List<String> blogIds}) async {
    List<BlogsModel> blogsModels = [];

    for (int i = 0; i < blogIds.length; i++) {
      BlogsModel blogsModel = BlogsModel(error: 'API Call Failed');
      try {
        final res = await http.get(
          Uri.parse('$baseUrlBlog/${blogIds[i]}?key=$apiKey'),
        );
        switch (res.statusCode) {
          /// if the status code is 2000 then you API call is Successful and we got the datat from server
          case 200:
            blogsModel = BlogsModel.fromJson(res.body);
            blogsModel = blogsModel
                .copyWith(pages: BlogPage.fromJson(blogsModel.pages!.toJson()))
                .copyWith(posts: BlogPost.fromJson(blogsModel.posts!.toJson()))
                .copyWith(
                    locale: BlogLocale.fromJson(blogsModel.locale!.toJson()))
                .copyWith(error: null);

            break;
          default:

            /// we got some error so it;s update in [Error] column
            blogsModel = BlogsModel(error: res.body);
        }
      } catch (e) {
        /// we got some error so it;s update in [Error] column
        blogsModel = BlogsModel(error: e.toString());
      }
      blogsModels.add(blogsModel);
    }

    return blogsModels;
  }

  /// [getBlog] This function will return [Blog], [Post] and [Page] details.
  ///
  /// We need to pass [BlogId].
  ///
  /// if the [statusCode] is 200 then the API call is Successful elase the will be updated in [BlogsModel.error] field.
  ///
  /// if [BlogsModel.error] is null then your all is Successful.
  Future<BlogsModel> getBlog({required String blogId}) async {
    BlogsModel blogsModel = BlogsModel(error: 'API Call Failed');
    try {
      final res = await http.get(
        Uri.parse('$baseUrlBlog/$blogId?key=$apiKey'),
      );
      switch (res.statusCode) {
        /// if the status code is 2000 then you API call is Successful and we got the datat from server
        case 200:
          blogsModel = BlogsModel.fromJson(res.body);
          blogsModel = blogsModel
              .copyWith(pages: BlogPage.fromJson(blogsModel.pages!.toJson()))
              .copyWith(posts: BlogPost.fromJson(blogsModel.posts!.toJson()))
              .copyWith(
                  locale: BlogLocale.fromJson(blogsModel.locale!.toJson()))
              .copyWith(error: null);

          break;
        default:

          /// we got some error so it;s update in [Error] column
          blogsModel = BlogsModel(error: res.body);
      }
    } catch (e) {
      /// we got some error so it;s update in [Error] column
      blogsModel = BlogsModel(error: e.toString());
    }
    return blogsModel;
  }

  /// [getPosts] This function will return all [Post] in the [blog]
  ///
  /// if the [statusCode] is 200 then the API call is Successful elase the will be updated in [BlogsModel.error] field.
  ///
  /// if [BlogsModel.error] is null then your all is Successful.
  ///
  /// Post Comment is included [Replies.postComments] so this function will take some time to get all [post] and [Comments] based on [blog] size.
  Future<PostModel> getPosts({bool includeComment = false}) async {
    PostModel postModel = PostModel(error: 'API Call Failed', items: []);
    List<PostItemModel>? items = [];
    try {
      final res =
          await http.get(Uri.parse('$baseUrlBlog/$blogId/posts?key=$apiKey'));

      switch (res.statusCode) {
        /// if the status code is 2000 then you API call is Successful and we got the datat from server
        case 200:
          if (jsonDecode(res.body)['items'] != null) {
            for (int i = 0; i < jsonDecode(res.body)['items'].length; i++) {
              PostItemModel postItemModel =
                  PostItemModel(error: 'API Call Failed');
              List<PostComments>? postCommentslist = [];
              postItemModel = PostItemModel.fromJson(
                  jsonEncode(jsonDecode(res.body)['items'][i]));

              Response? res1;
              try {
                if (includeComment) {
                  res1 = await http.get(Uri.parse(
                      '${postItemModel.replies!.selfLink!}?key=$apiKey'));

                  if (jsonDecode(res1.body)['items'] != null) {
                    for (int k = 0;
                        k < jsonDecode(res1.body)['items'].length;
                        k++) {
                      PostComments postComments = PostComments.fromJson(
                          jsonEncode(jsonDecode(res1.body)['items'][k]));
                      postCommentslist.add(postComments);
                    }
                    postItemModel = PostItemModel.fromJson(
                            jsonEncode(jsonDecode(res.body)['items'][i]))
                        .copyWith(
                            replies: Replies(
                      postComments: postCommentslist,
                      selfLink: postItemModel.replies!.selfLink,
                      totalItems: postItemModel.replies!.totalItems,
                    ));
                  } else {
                    postItemModel = PostItemModel.fromJson(
                            jsonEncode(jsonDecode(res.body)['items'][i]))
                        .copyWith(
                            replies: Replies(
                      postComments: [],
                      selfLink: postItemModel.replies!.selfLink,
                      totalItems: postItemModel.replies!.totalItems,
                    ));
                  }
                } else {
                  postItemModel = PostItemModel.fromJson(
                          jsonEncode(jsonDecode(res.body)['items'][i]))
                      .copyWith(
                    replies: Replies(
                      postComments: [],
                      selfLink: postItemModel.replies!.selfLink,
                      totalItems: postItemModel.replies!.totalItems,
                    ),
                  );
                }
              } catch (e) {
                //print(e.toString());
              }
              items.add(postItemModel);
            }
            postModel = PostModel(
              items: items,
              error: null,
              etag: jsonDecode(res.body)['etag'],
              kind: jsonDecode(res.body)['kind'],
            );
          } else {
            /// it means no items in the Blog
            postModel = PostModel(
              items: [],
              error: null,
              etag: jsonDecode(res.body)['etag'],
              kind: jsonDecode(res.body)['kind'],
            );
          }
          break;
        default:

          /// we got some error so it;s update in [Error] column
          postModel = PostModel(error: res.body, items: null);
      }
    } catch (e) {
      /// we got some error so it;s update in [Error] column
      postModel = PostModel(error: e.toString());
    }
    return postModel;
  }

  /// [getPages] This function will return all [Pages] in the [blog]
  ///
  /// if the [statusCode] is 200 then the API call is Successful elase the will be updated in [BlogsModel.error] field.
  ///
  /// if [PageModel.error] is null then your all is Successful.
  ///
  /// As of  the API Not return Page Comments so [Replies] is null for all the pages
  Future<PageModel> getPages() async {
    PageModel pageModel = PageModel(error: 'API Call Failed');
    List<PostItemModel>? items = [];
    try {
      final res =
          await http.get(Uri.parse('$baseUrlBlog/$blogId/pages?key=$apiKey'));

      switch (res.statusCode) {
        /// if the status code is 2000 then you API call is Successful and we got the datat from server
        case 200:
          if (jsonDecode(res.body)['items'] != null) {
            for (int i = 0; i < jsonDecode(res.body)['items'].length; i++) {
              PostItemModel postItemModel = PostItemModel.fromJson(
                      jsonEncode(jsonDecode(res.body)['items'][i]))
                  .copyWith(
                      replies: Replies(
                          postComments: [], selfLink: '', totalItems: 0));

              items.add(postItemModel);
            }

            pageModel = PageModel(
              error: null,
              etag: jsonDecode(res.body)['etag'],
              kind: jsonDecode(res.body)['kind'],
              items: items,
            );
          } else {
            /// it means no items in the Blog
            pageModel = PageModel(
              error: null,
              etag: jsonDecode(res.body)['etag'],
              kind: jsonDecode(res.body)['kind'],
              items: items,
            );
          }

          break;
        default:

          /// we got some error so it;s update in [Error] column
          pageModel = PageModel(error: res.body, items: null);
      }
    } catch (e) {
      /// we got some error so it;s update in [Error] column
      pageModel = PageModel(error: e.toString());
    }
    return pageModel;
  }
}
