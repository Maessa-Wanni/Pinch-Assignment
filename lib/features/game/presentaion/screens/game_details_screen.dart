import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helpers/app_texts.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../data/models/game_model.dart';

/// details scrren
class GameDetailScreen extends StatelessWidget {
  final GameModel game;

  const GameDetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name ?? AppTexts.gameDetails,
            style: TextStyles.font18BlackRegular),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                    imageHeight: 50,
                    imageWidth: 80,
                    imgUrl: game.cover?.url ?? "",
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Game Name
              Text(
                game.name ?? "No Name",
                style: TextStyles.font18BlackBold,
              ),
              const SizedBox(height: 8),

              /// Storyline
              if (game.storyline != null && game.storyline!.isNotEmpty)
                Text(
                  game.storyline ?? "No storyline available.",
                  style: TextStyles.font16GrayRegular,
                ),
              const SizedBox(height: 16),

              /// Summary
              if (game.summary != null && game.summary!.isNotEmpty)
                Text(
                  game.summary ?? "No summary available.",
                  style: TextStyles.font16GrayRegular,
                ),
              const SizedBox(height: 16),

              /// Age Ratings
              if (game.ageRatings != null && game.ageRatings!.isNotEmpty) ...[
                Text(
                  "Age Ratings",
                  style: TextStyles.font18BlackBold,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: game.ageRatings!.map((rating) {
                    return Text(
                      "Category: ${rating.category ?? "Unknown"}, Rating: ${rating.rating ?? "Not Rated"}",
                      style: TextStyles.font16GrayRegular,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],

              /// Alternative Names
              if (game.alternativeNames != null &&
                  game.alternativeNames!.isNotEmpty) ...[
                Text(
                  "Alternative Names",
                  style: TextStyles.font18BlackBold,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: game.alternativeNames!.map((name) {
                    return Text(
                      name.name ?? "No name available",
                      style: TextStyles.font16GrayRegular,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],

              /// Screenshots
              if (game.screenshots != null && game.screenshots!.isNotEmpty) ...[
                Text(
                  "Screenshots",
                  style: TextStyles.font18BlackBold,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: game.screenshots!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomNetworkImage(
                            imageHeight: 200,
                            imageWidth: 75,
                            imgUrl: game.screenshots?[0].url ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],

              /// Websites
              if (game.websites != null && game.websites!.isNotEmpty) ...[
                Text(
                  "Official Websites",
                  style: TextStyles.font18BlackBold,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: game.websites!.map((website) {
                    return GestureDetector(
                      onTap: () => _launchURL(website.url ?? ""),
                      child: Text(
                        website.url ?? "No URL available",
                        style: TextStyles.font16GrayRegular.copyWith(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          decorationColor: Colors.blue
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],

              /// Game Localizations
              if (game.gameLocalizations != null &&
                  game.gameLocalizations!.isNotEmpty) ...[
                Text(
                  "Game Localizations",
                  style: TextStyles.font18BlackBold,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: game.gameLocalizations!.map((localization) {
                    return Text(
                      localization.name ?? "Unknown Language",
                      style: TextStyles.font16GrayRegular,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
  void _launchURL(String url) async {
    try {
      /// Always try to open the URL in the default browser
      if (await canLaunch(url)) {
        /// Ensure the URL opens in a browser, even for iOS-specific URLs
        await launch(url, forceWebView: false, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      /// Print the error for debugging
      print("Error launching URL: $e");
    }
  }

}
