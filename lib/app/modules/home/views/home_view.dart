import 'package:flutter/material.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/modules/contacts/views/contacts_view.dart';

// import 'package:get/get.dart';
// import 'package:kgchat/app/modules/authentication/authentication.dart';
// import 'package:kgchat/app/modules/contacts/views/contacts_view.dart';

// import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  final UserModel? currentUser;

  const HomeView({Key? key, this.currentUser}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final AuthenticationController _authenticationController =
  //     AuthenticationController.findAuthCont!;

  late PageController pageController;

  int bottomSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  void pageChanged(int index) {
    bottomSelectedIndex = index;
    setState(() {});
  }

  void bottomTapped(int index) {
    bottomSelectedIndex = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.ease);

    setState(() {});
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Red',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Blue',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'Green',
      )
    ];
  }

  ///Abstraction
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: pageChanged,
      children: <Widget>[
        ContactsView(currentUser: widget.currentUser),
        // Container(color: Colors.green),
        Container(color: Colors.red),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'HomeView is working',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                  onPressed: () async {
                    ///TODO(Azamat): add sign out
                    // await _authenticationController.signOut();
                  },
                  child: Text('sign out')),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
        onTap: bottomTapped,
      ),
    );
  }
}
