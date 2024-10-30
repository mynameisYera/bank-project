import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/features/main/widgets/leaderboard_tile.dart';
import 'package:gradus/src/features/main/widgets/podium_widget.dart';

class LeaderboardsPage extends StatefulWidget {
  const LeaderboardsPage({super.key});

  @override
  State<LeaderboardsPage> createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');
  List<Map<String, dynamic>> _leaderboardData = [];

  Future<void> _loadLeaderBoardsData() async {
    try {
      QuerySnapshot snapshot = await _firestore.get();
      final allData = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      log(allData.toString() as num);

      // data sorting
      allData.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

      setState(() {
        _leaderboardData = allData;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _loadLeaderBoardsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      appBar: const CustomAppBar(
        title: 'LeaderBoards',
        backgroundColor: AppColors.mainColor,
        popAble: true,
      ),
      body: Center(
        child: _leaderboardData.isEmpty
            ? const CircularProgressIndicator(
                color: AppColors.buttonColor,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Stack(
                    children: [
                      // podium
                      SizedBox(
                        height: 310,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // rank2
                            if (_leaderboardData.length > 1)
                              PodiumWidget(
                                rankPicture: 'Rank2.svg',
                                score: _leaderboardData[1]['score'],
                                teamName: _leaderboardData[1]['teamName'],
                                imageLogo: 'Avatar.png',
                              ),

                            // rank1
                            if (_leaderboardData.isNotEmpty)
                              PodiumWidget(
                                rankPicture: 'rank1.svg',
                                score: _leaderboardData[0]['score'],
                                teamName: _leaderboardData[0]['teamName'],
                                imageLogo: 'Avatar.png',
                              ),

                            // rank3
                            if (_leaderboardData.length > 2)
                              PodiumWidget(
                                rankPicture: 'rank3.svg',
                                score: _leaderboardData[2]['score'],
                                teamName: _leaderboardData[2]['teamName'],
                                imageLogo: 'Avatar.png',
                              ),
                          ],
                        ),
                      ),

                      // list of the items starting from 4 place
                      Container(
                        margin: const EdgeInsets.only(top: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff262626),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: _leaderboardData.length * 70,
                          child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _leaderboardData.length - 3,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16);
                              },
                              itemBuilder: (context, index) {
                                final item = _leaderboardData[index + 3];

                                return CustomTile(
                                  place: index + 4,
                                  score: item['score'],
                                  teamName: item['teamName'],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
