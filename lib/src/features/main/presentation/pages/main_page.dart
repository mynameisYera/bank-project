import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bank/main.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:bank/src/features/main/presentation/bloc/current_bloc/current_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/next_book_bloc/next_book_bloc.dart';
import 'package:bank/src/features/main/widgets/current_book_widget.dart';
import 'package:bank/src/features/main/widgets/enter_quiz_widget.dart';
import 'package:bank/src/features/main/widgets/message_send_field.dart';
import 'package:bank/src/features/main/widgets/message_tile_widget.dart';
import 'package:bank/src/features/main/widgets/news_widget.dart';
import 'package:bank/src/features/main/widgets/podium_widget.dart';
import 'package:bank/src/features/main/widgets/profile_tile.dart';
import 'package:bank/src/features/main/widgets/quiz_question_widget.dart';
import 'package:bank/src/features/main/widgets/vote_tile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final Map<String, dynamic> currentBook = {
      'bookName': 'Shoko Alem',
      'page': 343,
      'image':
          'https://simg.marwin.kz/media/catalog/product/cache/8d1771fdd19ec2393e47701ba45e606d/f/u/fullimage_68_1.jpg',
    };
    return Scaffold(
      backgroundColor: AppColors.sectionColor,
      body: userData == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
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
                          create: (context) =>
                              CurrentBloc()..add(LoadCurrentEvent()),
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
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
                                return CustomButton(
                                    onTap: () {
                                      context
                                          .read<NewsBloc>()
                                          .add(LoadNewsEvent());
                                    },
                                    btnText: 'Try again');
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
                          create: (context) =>
                              NextBookBloc()..add(LoadNextBookEvent()),
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
                                        onTap: () {
                                          final bookId = state.items[index].id;
                                          context.read<NextBookBloc>().add(
                                              AddVoteEvent(bookId,
                                                  userData?['teamName']));
                                        },
                                        bookName: state.items[index].name,
                                        page: state.items[index].page,
                                        vote: state.items[index].vote,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return CustomButton(
                                  onTap: () {},
                                  btnText: 'You already voted',
                                );
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  BlocProvider(
                    create: (context) => NewsBloc()..add(LoadNewsEvent()),
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state is SuccessNewsState) {
                          return SizedBox(
                            height: state.items.length * 530,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                return NewsWidget(
                                    description: state.items[index].desc,
                                    url: state.items[index].images);
                              },
                            ),
                          );
                        } else if (state is LoadingNewsState) {
                          return CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          );
                        } else {
                          return CustomButton(
                              onTap: () {
                                context.read<NewsBloc>().add(LoadNewsEvent());
                              },
                              btnText: 'btnText');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Enter Quiz',
                  //       style: TextStyles.headerText,
                  //     ),
                  //     Text(
                  //       'See all',
                  //       style: TextStyles.miniText
                  //           .copyWith(color: AppColors.buttonColor),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QuizPage()));
                    },
                    child: EnterQuizWidget(
                      bookName: currentBook['bookName'],
                      round: 5,
                      questions: 25,
                      image: 'assets/images/Frame.png',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentRound = 1;
  int _currentQuestionIndex = 0;

  List<String> _currentQuestions = [];
  Map<String, Map<String, String>> _allAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestionsForRound();
  }

  Future<void> _loadQuestionsForRound() async {
    final doc =
        await FirebaseFirestore.instance.collection('quiz').doc('game1').get();
    final data = doc.data();

    if (data != null && data.containsKey('round$_currentRound')) {
      final roundData = Map<String, dynamic>.from(data['round$_currentRound']);
      final sortedQuestions = roundData.keys.toList()..sort();

      setState(() {
        _currentQuestions =
            sortedQuestions.map((key) => roundData[key].toString()).toList();
        _currentQuestionIndex = 0;
        _allAnswers['round$_currentRound'] = {};
      });
    } else {
      print("No more rounds available.");
    }
  }

  void _handleNextButton(BuildContext context) {
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _submitAnswers();
      if (_currentRound < 5) {
        _startNewRound();
      } else {
        _showQuizCompletionDialog(context);
      }
    }
  }

  Future<void> _submitAnswers() async {
    await FirebaseFirestore.instance.collection('answers').doc('game1').set({
      'round$_currentRound': _allAnswers['round$_currentRound'],
    }, SetOptions(merge: true));
  }

  void _startNewRound() {
    setState(() {
      _currentRound++;
    });
    _loadQuestionsForRound();
    _pageController.jumpToPage(0);
  }

  void _showQuizCompletionDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.grey,
        title: Text(
          "Quiz Completed",
          style: TextStyles.headerText,
        ),
        content: Text(
          "You've finished all rounds!",
          style: TextStyles.simpleText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                btnText: "OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Round $_currentRound",
          backgroundColor: AppColors.mainColor,
          popAble: true),
      body: Center(
        child: Stack(
          children: [
            if (_currentQuestions.isNotEmpty) ...[
              PageView.builder(
                controller: _pageController,
                itemCount: _currentQuestions.length,
                itemBuilder: (context, index) {
                  return QuizQuestionWidget(
                    question: _currentQuestions[index],
                    onAnswerChanged: (answer) {
                      _allAnswers['round$_currentRound']![
                          'question${index + 1}'] = answer;
                    },
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    onTap: () => _handleNextButton(context),
                    btnText:
                        _currentQuestionIndex == _currentQuestions.length - 1
                            ? "Finish"
                            : "Next"),
              ),
            ] else
              Center(
                  child: CircularProgressIndicator(
                color: AppColors.buttonColor,
              )),
          ],
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
                                  reverse: false,
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
                                      DateTime now = DateTime.now();
                                      int timestampInMilliseconds =
                                          now.toUtc().millisecondsSinceEpoch;
                                      await FirebaseFirestore.instance
                                          .collection('chat')
                                          .add({
                                        'message': _messageController.text,
                                        'username': userData?['teamName'],
                                        'timestamp': timestampInMilliseconds
                                      });
                                      _messageController.clear();

                                      context
                                          .read<MessageBloc>()
                                          .add(LoadMessagesEvent());
                                    } catch (e) {
                                      print('Error adding document: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? _userProfileData;
  int? _userRank;

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await _firestore.doc(user.uid).get();
      QuerySnapshot leaderboardSnapshot = await _firestore.get();

      final leaderboardData = leaderboardSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // sorting to get the place
      leaderboardData
          .sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

      // team rank
      _userRank = leaderboardData
              .indexWhere((team) => team['email'] == userSnapshot['email']) +
          1;

      setState(() {
        _userProfileData = userSnapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  // how to get user data: userData?['teamName']

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Profile',
          backgroundColor: AppColors.mainColor,
          popAble: false),
      body: _userProfileData == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff652DDC),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Text(
                              '#${_userRank ?? '-'}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _userRank! >= 10 ? 22 : 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userProfileData?['teamName'] ?? "NO DATA",
                                style: TextStyles.headerText,
                              ),
                              Text(
                                _userProfileData?['email'] ?? "NO DATA",
                                style: TextStyles.simpleText,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // settings list
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          // one tile
                          ProfileTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileInfoPage(
                                            userRank: _userRank,
                                            userProfileData: _userProfileData,
                                          )));
                            },
                            icon: Icons.person,
                            title: "My Account",
                            subtitle: "Make changes to your account",
                          ),
                          ProfileTile(
                            onTap: () {},
                            icon: Icons.person,
                            title: "Saved Beneficiary",
                            subtitle: "Make changes to your account",
                          ),

                          ProfileTile(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InitializationPage()));
                            },
                            icon: Icons.logout_outlined,
                            isLogout: true,
                            title: "Log out",
                            subtitle: "Log out from your Account",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // more and more
                    Text("More", style: TextStyles.headerText),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                            onTap: () {},
                            icon: Icons.notifications_outlined,
                            title: "Help & Support",
                            subtitle: "",
                          ),
                          ProfileTile(
                            onTap: () {},
                            icon: Icons.favorite_outline_rounded,
                            title: "About App",
                            subtitle: "",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage(
      {super.key, required this.userProfileData, required this.userRank});
  final int? userRank;
  final Map<String, dynamic>? userProfileData;

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CustomAppBar(
        title: "Profile",
        backgroundColor: AppColors.mainColor,
        popAble: true,
      ),
      body: Center(
        child: widget.userProfileData == null
            ? const CircularProgressIndicator(color: AppColors.buttonColor)
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff652DDC),
                              border: Border.all(
                                  color: const Color(0xff393939), width: 4)),
                          child: Text(
                            '#${widget.userRank ?? '-'}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.userRank! >= 10 ? 37 : 42,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.userProfileData?['teamName'] ?? 'NO DATA',
                          style: TextStyles.headerText,
                        ),
                        Text('Score: ${widget.userProfileData?['score']}',
                            style: TextStyles.miniText),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // captain name
                            Text('Captain Name', style: TextStyles.simpleText),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                widget.userProfileData?['memberNames'][0] ??
                                    'Captain',
                                style: TextStyles.simpleText,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // email
                            Text('Email', style: TextStyles.simpleText),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                widget.userProfileData?['email'] ?? 'Email',
                                style: TextStyles.simpleText,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          widget.userProfileData?['memberNames']
                                                  [0] ??
                                              'Player #1',
                                          style: TextStyles.simpleText,
                                        ),
                                        CircleAvatar(
                                            radius: 30,
                                            child: Image.asset(
                                                'assets/images/ava2.png')),
                                        Text('290 pages',
                                            style: TextStyles.miniText),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          widget.userProfileData?['memberNames']
                                                  [1] ??
                                              'Player #2',
                                          style: TextStyles.simpleText,
                                        ),
                                        CircleAvatar(
                                            radius: 30,
                                            child: Image.asset(
                                                'assets/images/ava2.png')),
                                        Text('290 pages',
                                            style: TextStyles.miniText),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          widget.userProfileData?['memberNames']
                                                  [2] ??
                                              'Player #3',
                                          style: TextStyles.simpleText,
                                        ),
                                        CircleAvatar(
                                            radius: 30,
                                            child: Image.asset(
                                                'assets/images/ava2.png')),
                                        Text('290 pages',
                                            style: TextStyles.miniText),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    CustomButton(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitializationPage()));
                      },
                      btnText: 'Sign Out',
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
