# Blogger API For Flutter

This Package Helping to implement of blogger api to flutter app 

## Platform integration 

You don't need to include the google-services.json file in your app unless you are using Google services that require it. You do need to enable the Blogger API using [Google Cloud Platform API manager](https://console.cloud.google.com/apis/library/blogger.googleapis.com?project=docs-372812), and Create New Project then Go to Credentials Page and Create New credentials For API Key.

### 💰 Support by donating or sponsoring us.,
 
 [![sponsor](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#white)](https://github.com/sponsors/bhargavraviya) [![Patreon](https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white)](https://www.patreon.com/raviyatechnical/membership) [![Buymeacoffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/raviyatechnical) [![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/raviyatechnical)
-----

## Features

- Posts
- Pages

## Screenshots

<img src="https://cdn-images-1.medium.com/max/800/1*CfdttDNjFUkOTU-2NUaQQg.png" width="250"> 
<img src="https://cdn-images-1.medium.com/max/800/1*Jb8jURyirMeec3Hr3D08Tw.png" width="250"> 
<img src="https://cdn-images-1.medium.com/max/800/1*6IYtVhySrTjUrSpL_xAT-A.png" width="250"> 
<img src="https://cdn-images-1.medium.com/max/800/1*Jb8jURyirMeec3Hr3D08Tw.png" width="250"> 

## Documentation

To use blogger, first start by importing the package.

```dart
import 'package:blogger/blogger.dart';
```

```
Blogger blogger = Blogger(
    apiKey: 'Your API Key',
    blogId: 'Your Blog Ids',
);
```

#### Get All the Blog Details By Ids

```
bloggerAPI.getBlogs(
    blogIds: ['Your Blog Ids'], 
)
```

Return Type `Future<List<BlogsModel>>` 


#### Get All the Post Details By Blog Id

```
bloggerAPI.getPosts(
    includeComment: false // If need you can read all the Comments from Posts.
)
```

Return Type `Future<PostModel>`

#### Get All the Page Details By Blog Id

```
bloggerAPI.getPages()
```

Return Type `Future<PageModel>`

`Author` and `Replies`  included in `PostItemModel` so can you read author and replies from Posts

#### Platform Support

| Android |  iOS  | MacOS |  Web  | Linux | Windows |
| :-----: | :---: | :---: | :---: | :---: | :-----: |
|    ✔️    |   ✔️   |   ✔️   |   ✔️   |   ✔️   |    ✔️    |

## Authors

- [@bhargavraviya](https://www.github.com/bhargavraviya)

## Contributing
Contributions are always welcome!
See `contributing.md` for ways to get started.
Please adhere to this project's `code of conduct`.

## License

[MIT](https://choosealicense.com/licenses/mit/)

This code inspection from blogger_api package.

[https://github.com/imtheguna/blogger_api](https://github.com/imtheguna/blogger_api)