import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({super.key, required this.place, required this.score, required this.teamName});
  final int place;
  final int score;
  final String teamName;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff4A4A4A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              '$place',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 25,
            child: Image.asset("assets/images/Avatar.png"),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                teamName,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
               Text(
                '$score points',
                style: const TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}