import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodiumWidget extends StatelessWidget {
  const PodiumWidget({
    super.key,
    required this.rankPicture,
    required this.score,
    required this.teamName,
    required this.imageLogo,
  });
  final String rankPicture;
  final int score;
  final String teamName;
  final String imageLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 60,
          width: 60,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "assets/images/$imageLogo",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          teamName,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(6)),
          child:  Text(
            score.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(child: SvgPicture.asset("assets/images/$rankPicture"))
      ],
    );
  }
}
