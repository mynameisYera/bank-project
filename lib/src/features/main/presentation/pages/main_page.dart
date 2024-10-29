import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradus/main.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/main/presentation/bloc/current_bloc/current_bloc.dart';
import 'package:gradus/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:gradus/src/features/main/presentation/bloc/next_book_bloc/next_book_bloc.dart';
import 'package:gradus/src/features/main/widgets/current_book_widget.dart';
import 'package:gradus/src/features/main/widgets/enter_quiz_widget.dart';
import 'package:gradus/src/features/main/widgets/message_send_field.dart';
import 'package:gradus/src/features/main/widgets/message_tile_widget.dart';
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
              BlocProvider(
                create: (context) => CurrentBloc()..add(LoadCurrentEvent()),
                child: BlocBuilder<CurrentBloc, CurrentState>(
                  builder: (context, state) {
                    if (state is LoadingCurrentState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      );
                    } else if (state is SuccessCurrentState) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 77,
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return CurrentBookWidget(
                              bookName: state.items[index].bookName,
                              page: state.items[index].page,
                              image: state.items[index].image,
                            );
                          },
                        ),
                      );
                    } else {
                      return CustomButton(onTap: () {}, btnText: 'Try again');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Next Book',
                style: TextStyles.headerText,
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => NextBookBloc()..add(LoadNextBookEvent()),
                child: BlocBuilder<NextBookBloc, NextBookState>(
                  builder: (context, state) {
                    if (state is LoadingNextBookState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      );
                    }
                    if (state is SuccessNextBookState) {
                      return SizedBox(
                        height: (77 * state.items.length) +
                            (20 * state.items.length.toDouble()),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return VoteTileWidget(
                                  bookName: state.items[index].name,
                                  page: state.items[index].page,
                                  vote: state.items[index].vote);
                            }),
                      );
                    } else {
                      return CustomButton(
                          onTap: () {}, btnText: 'Error accused');
                    }
                  },
                ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Stack(
            children: [
              // podium
              SizedBox(
                height: 310,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset("assets/images/Avatar.png"),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Alena Donin',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            '1,230S',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SvgPicture.asset("assets/images/Rank2.svg")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/images/Avatar.png"),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Davis Curtis',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            '2,5430S',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SvgPicture.asset("assets/images/rank1.svg")
                      ],
                    ),
                    Column(
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
                            "assets/images/Avatar.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Graig Gouse',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            '1,020S',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            child: SvgPicture.asset("assets/images/rank3.svg"))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xff262626),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return CustomTile(place: index + 1);
                    }),
              )),
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
        title: 'Open Chat ',
        backgroundColor: AppColors.mainColor,
        popAble: false,
      ),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : BlocProvider(
              create: (context) => MessageBloc()..add(LoadMessagesEvent()),
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is LoadingMessageState) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ));
                  } else if (state is FailureMessageState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is SuccessMessageState) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/chat_bg.png'),
                              fit: BoxFit.cover)),
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
                                      'username': userData?['teamName'],
                                    });
                                    _messageController.clear();

                                    context
                                        .read<MessageBloc>()
                                        .add(LoadMessagesEvent());
                                  } catch (e) {
                                    print('Error adding document: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Failed to add message')),
                                    );
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 20),
                          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Profile',
          backgroundColor: AppColors.mainColor,
          popAble: false),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team Name: ${userData?['teamName'] ?? ''}',
                    style: TextStyles.headerText,
                  ),
                  Text(
                    'Email: ${userData?['email'] ?? ''}',
                    style: TextStyles.headerText,
                  ),
                  Text(
                    'Members: ${userData?['memberNames']?.join(', ') ?? ''}',
                    style: TextStyles.headerText,
                  ),
                  Text(
                    'Score: ${userData?['score']}',
                    style: TextStyles.headerText,
                  ),
                  CustomButton(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitializationPage()));
                      },
                      btnText: 'Sign Out')
                ],
              ),
            ),
    );
  }
}
