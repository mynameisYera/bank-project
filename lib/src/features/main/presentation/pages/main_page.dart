import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradus/main.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:gradus/src/features/main/widgets/current_book_widget.dart';
import 'package:gradus/src/features/main/widgets/enter_quiz_widget.dart';
import 'package:gradus/src/features/main/widgets/message_send_field.dart';
import 'package:gradus/src/features/main/widgets/message_tile_widget.dart';
import 'package:gradus/src/features/main/widgets/podium_widget.dart';
import 'package:gradus/src/features/main/widgets/profile_tile.dart';
import 'package:gradus/src/features/main/widgets/vote_tile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradus/src/features/unauth/presentation/log_in_page.dart';

import '../../widgets/leaderboard_tile.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LeaderboardsPage(),
    ChatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mainColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person_2),
              label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      'image':
          'https://simg.marwin.kz/media/catalog/product/cache/8d1771fdd19ec2393e47701ba45e606d/f/u/fullimage_68_1.jpg',
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
                    physics: NeverScrollableScrollPhysics(),
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
      log(allData.toString());

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
        popAble: false,
      ),
      body: Center(
        child: _leaderboardData.isEmpty
            ? const CircularProgressIndicator(
                color: AppColors.buttonColor,
              )
            : Padding(
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
                      child: ListView.separated(
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
                  ],
                ),
              ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Open Chat',
        backgroundColor: AppColors.mainColor,
        popAble: false,
      ),
      body: userData == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : BlocProvider(
              create: (context) => MessageBloc()..add(LoadMessagesEvent()),
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is LoadingMessageState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ));
                  } else if (state is FailureMessageState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is SuccessMessageState) {
                    return Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/chat_bg.png'),
                              fit: BoxFit.cover)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  reverse: true,
                                  itemCount: state.items.length,
                                  itemBuilder: (context, index) {
                                    final message = state.items[index];
                                    if (state.items[index].username ==
                                        userData?['teamName']) {
                                      return MessageTileWidget(
                                        username: message.username,
                                        message: message.messages,
                                        isMe: true,
                                      );
                                    } else {
                                      return MessageTileWidget(
                                        isMe: false,
                                        username: message.username,
                                        message: message.messages,
                                      );
                                    }
                                  },
                                ),
                              ),
                              MessageInputField(
                                formKey: _formKey,
                                controller: _messageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Write something, please';
                                  }
                                  return null;
                                },
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('chat')
                                          .add({
                                        'message': _messageController.text,
                                        'username': userData?['teamName']
                                      });
                                      _messageController.clear();

                                      context
                                          .read<MessageBloc>()
                                          .add(LoadMessagesEvent());
                                    } catch (e) {
                                      print('Error adding document: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Failed to add message')),
                                      );
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  // how to get user data: userData?['teamName']
  // CustomButton(
  //                   onTap: () async {
  //                     await FirebaseAuth.instance.signOut();
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => InitializationPage()));
  //                   },
  //                   btnText: 'Sign Out',
  //                 )

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Profile',
          backgroundColor: AppColors.mainColor,
          popAble: false),
      body: userData == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        // one tile
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // icon
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff535353),
                                    ),
                                    child: const Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Account',
                                        style: TextStyles.miniText,
                                      ),
                                      Text(
                                        'Make changes to your account',
                                        style: TextStyles.tileText,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        ProfileTile(
                            onTap: () {},
                            icon: Icons.person,
                            title: "Saved Bebeficiary",
                            subtitle: "Make changes to your account"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
