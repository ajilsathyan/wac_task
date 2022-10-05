import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  String url;
  double? width, height;
  CustomImage({Key? key, required this.url, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width ?? 60,
        height: height ?? 60,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
              height: 30,
              width: 30,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 3,
              ))),
          errorWidget: (context, url, error) => CachedNetworkImage(
            imageUrl:
                "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
          ),
        ),
      ),
    );
  }
}
