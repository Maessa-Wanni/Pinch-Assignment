import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/helpers/app_texts.dart';
import '../../../../core/theming/styles.dart';
import '../logic/games_cubit.dart';
import '../widgets/single_game_card.dart';

/// game screen
class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  bool _isLoadingMore = false;
  bool _isLoadingInitial = true;

  /// New state for initial loading
  late ScrollController _scrollController;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isLoadingMore && _scrollController.position.extentAfter < 200) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoadingInitial = true;
    });

    await context.read<GamesCubit>().checkSource(offset);

    setState(() {
      _isLoadingInitial = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoadingInitial = true;

      /// Show the loading indicator during refresh
    });

    offset = 0;

    /// Reset the offset
    await context.read<GamesCubit>().resetGames();

    /// Clear existing data in the cubit
    await context.read<GamesCubit>().checkSource(offset);

    /// Fetch data from the beginning

    setState(() {
      _isLoadingInitial = false;

      /// Hide the loading indicator after refresh
    });
  }

  Future<void> _fetchMoreData() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    offset += 10;
    await context.read<GamesCubit>().checkSource(offset);

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GamesCubit gamesCubit = context.read<GamesCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.gamesList, style: TextStyles.font18BlackRegular),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: BlocBuilder<GamesCubit, GamesState>(
            builder: (context, state) {
              if (_isLoadingInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetGamesDataError) {
                return Text(state.errorMessage);
              }

              return ListView.separated(
                controller: _scrollController,
                itemCount: gamesCubit.games.length + (_isLoadingMore ? 1 : 0),

                /// Add extra item for loader
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 4.0),
                itemBuilder: (context, index) {
                  if (index == gamesCubit.games.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final game = gamesCubit.games[index];
                  return SingleGameCard(game: game);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
