import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:gradus/src/features/main/widgets/vote_tile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradus/src/features/unauth/presentation/log_in_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LeaderboardPage(),
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

class LeaderboardPage extends StatefulWidget {
  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Leaderboard Page"));
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
        title: 'Chat Page',
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
                    return Center(child: CircularProgressIndicator());
                  } else if (state is FailureMessageState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is SuccessMessageState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                final message = state.items[index];
                                return MessageTileWidget(
                                  username: message.username,
                                  message: message.messages,
                                );
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
                              if (_formKey.currentState?.validate() ?? false) {
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Failed to add message')),
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(height: 20),
                        ],
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
