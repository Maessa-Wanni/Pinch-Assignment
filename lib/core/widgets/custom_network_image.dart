import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/theming/colors.dart';
import '../helpers/app_constants.dart';
import '../helpers/app_regex.dart';

/// general image views
class CustomNetworkImage extends StatelessWidget {

  final String imgUrl;
  final double? imageWidth, imageHeight;
  const CustomNetworkImage({
    super.key,
    required this.imgUrl,
    this.imageWidth,
    this.imageHeight,
  });

  String extractUrl(String input) {
    // Regular expression to match URLs
    // Search for the first match
    final match = AppRegex.isImageURLValid(imgUrl);

    // Return the matched URL or an empty string if no match is found
    return match != null ? input.substring(match.start) : "";
  }


  @override
  Widget build(BuildContext context) {

    String extractedUrl =
    extractUrl(imgUrl);

    return extractedUrl.isNotEmpty?Image.network(
      "https://$extractedUrl",
      width: imageWidth?.sp,
      height: imageHeight?.sp,
      fit: BoxFit.fill,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor,
              ),
            ),
          );
        }
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return  Image.asset(
          AssetsConstants.fullLogo,
          width: 40.sp,
          height: 40.sp,
          fit: BoxFit.fill,
        );
      },
    ):Image.asset(
      AssetsConstants.fullLogo,
      width: 40.sp,
      height: 40.sp,
      fit: BoxFit.fill,
    );
  }
}
