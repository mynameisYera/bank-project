import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/admin/presentation/pages/create_post_page.dart';
import 'package:gradus/src/features/admin/presentation/pages/current_book_page.dart';
import 'package:gradus/src/features/admin/presentation/pages/next_book_page.dart';
import 'package:gradus/src/features/admin/widgets/drawer_tile.dart';
import 'package:gradus/src/features/admin/widgets/setups_widget.dart';
import 'package:gradus/src/features/main/presentation/pages/main_page.dart';
import 'package:gradus/src/features/unauth/presentation/log_in_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyles.headerText,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.sectionColor,
      ),
      backgroundColor: AppColors.sectionColor,
      drawer: Drawer(
          backgroundColor: AppColors.notBlack,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Alisher Zhunissov',
                      style: TextStyles.headerText,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'alisher.zhunissov@gmail.com',
                      style: TextStyles.miniText,
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              DrawerTile(
                isCurrent: true,
                onTap: () {},
                text: 'Home',
                icon: Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
              ),
              DrawerTile(
                isCurrent: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardsPage()));
                },
                text: 'Leaderboard',
                icon: Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomButton(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                    btnText: 'Sign Out'),
              ),
              SizedBox(
                height: 50,
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SetupsWidget(
                title: 'Current Book',
                text: 'Choose Current Book',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentBookPage()));
                },
              ),
              SetupsWidget(
                title: 'Next Book',
                text: 'Choose Next Book',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NextBookPage()));
                },
              ),
              SetupsWidget(
                title: 'Quiz',
                text: 'Create Quiz',
                onTap: () {},
              ),
              SetupsWidget(
                title: 'Post',
                text: 'Create Post',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePostPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
