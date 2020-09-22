import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  PhotoViewPage(this.picUrl);

  final String picUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("查看照片"),
      ),
      body: Container(
        color: Colors.black87,
        child: PhotoView(
          imageProvider: NetworkImage(picUrl),
          loadingBuilder: (BuildContext context, ImageChunkEvent event) {
            return Container(
              child: Stack(
                children: <Widget>[
                  Center(child: Image.asset('static/image/bg_default.png', height: 180.0, width: 180.0)),
                  Center(child: SpinKitFoldingCube(color: Colors.white30, size: 60.0)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
