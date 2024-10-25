import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/features/main/widgets/current_book_widget.dart';
import 'package:gradus/src/features/main/widgets/enter_quiz_widget.dart';
import 'package:gradus/src/features/main/widgets/vote_tile_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> voteTile = [
      {'bookName': 'Harry Potter II', 'page': 325, 'vote': 23},
      {'bookName': 'Harry Potter II', 'page': 325, 'vote': 23},
      {'bookName': 'Harry Potter II', 'page': 325, 'vote': 23},
    ];

    final Map<String, dynamic> currentBook = {
      'bookName': 'Shoko Alem',
      'page': 343,
      'image': '',
    };
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Current Book',
                style: TextStyles.headerText,
              ),
              SizedBox(
                height: 20,
              ),
              CurrentBookWidget(
                bookName: currentBook['bookName'],
                page: currentBook['page'],
                image: currentBook['image'],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Next Book',
                style: TextStyles.headerText,
              ),
              SizedBox(
                height: (77 * 3) + (20 * 3),
                child: ListView.builder(
                    itemCount: voteTile.length,
                    itemBuilder: (context, index) {
                      return VoteTileWidget(
                          bookName: voteTile[index]['bookName'],
                          page: voteTile[index]['page'],
                          vote: voteTile[index]['vote']);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Quiz',
                    style: TextStyles.headerText,
                  ),
                  Text(
                    'See all',
                    style: TextStyles.miniText
                        .copyWith(color: AppColors.buttonColor),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              EnterQuizWidget(
                bookName: currentBook['bookName'],
                round: 5,
                questions: 25,
                image: 'assets/images/Frame.png',
              )
            ],
          ),
        ),
      ),
    );
  }
}
