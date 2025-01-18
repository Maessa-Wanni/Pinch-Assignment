import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../screens/game_details_screen.dart';
import '../../data/models/game_model.dart';


/// card of game
class SingleGameCard extends StatelessWidget {
  final GameModel game;

  const SingleGameCard({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: ListTile(
        leading: SizedBox(
          width: 40.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.sp),
            child: CustomNetworkImage(
              imageHeight: 60,
              imageWidth: 40,
              imgUrl: game.screenshots?[0].url ?? "",
            ),
          ),
        ),
        title: Text(game.name ?? "", style: TextStyles.font18BlackSemiBold),
        subtitle: Text(
          game.summary ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.font16GrayRegular,
        ),
        onTap: () {
          /// Navigate to detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailScreen(game: game),
            ),
          );
        },
      ),
    );
  }
}
