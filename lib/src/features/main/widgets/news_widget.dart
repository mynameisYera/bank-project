import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class NewsWidget extends StatelessWidget {
  final List<String> url;
  final String description;

  const NewsWidget({super.key, required this.url, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: AppColors.notBlack),
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '451.gradus.official',
                      style: TextStyles.headerText.copyWith(fontSize: 20),
                    ),
                    Text(
                      'Suggested for you',
                      style: TextStyles.miniText,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CarouselSlider(
              items: url.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: MediaQuery.of(context).size.width + 5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover)),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width,
                viewportFraction: 1.0,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              description,
              style: TextStyles.simpleText,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Alisher Zhunissov',
              style: TextStyles.miniText.copyWith(color: AppColors.buttonColor),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
