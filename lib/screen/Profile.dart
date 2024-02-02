import 'package:application/screen/TravelList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application/screen/Home.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final response = await http.get(
      Uri.parse(
          'http://teamproject.ddns.net:81/project/api/profile.php?username=0640986563'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userProfile = json.decode(response.body);
      return userProfile;
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<String?> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> _saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  Future<void> _saveUserPhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userPhoneNumber', phoneNumber);
  }

  Future<String?> _fetchUserPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userPhoneNumber');
  }

  Future<void> _saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', email);
  }

  Future<String?> _fetchUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  Future<void> _saveUserBirthDate(String birthDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userBirthDate', birthDate);
  }

  Future<String?> _fetchUserBirthDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userBirthDate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
        ),
        title: const Text(
          "ข้อมูลพนักงาน",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF0464F5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/Profile.png"),
                    radius: 55,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "วิศุทธิ์ พรนิมิตร",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: _fetchUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String id = snapshot.data?['id'].toString() ?? "";
                      String firstname =
                          snapshot.data?['firtsname'].toString() ?? "";

                      return Column(
                        children: [
                          const Text(
                            "ID :",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            id,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                            subtitle: Text(
                              "แผนก",
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              "ผู้จัดการ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.cake,
                              size: 30,
                              color: Colors.white,
                            ),
                            subtitle: Text(
                              "วันเกิด",
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              "16 มีนาคม 2566",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.white,
                            ),
                            subtitle: Text(
                              "อีเมล",
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              "wisutphonnimit@gmail.com",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.phone,
                              size: 30,
                              color: Colors.white,
                            ),
                            subtitle: Text(
                              "หมายเลขโทรศัพท์",
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              "098-758-9631",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                InkWell(
                  onTap: () async {
                    try {
                      final Map<String, dynamic> userProfile =
                          await _fetchUserProfile();
                      final String id = userProfile['id'].toString();
                      final String firstname =
                          userProfile['firstname'].toString();

                      print('ID: $id');
                      print('firstname: $firstname');

                      await _saveUserId(id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailScreen(
                            userProfiles: [userProfile],
                          ),
                        ),
                      );
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Container(
                        width: 250.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF0D99FF),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, color: Colors.white, size: 20),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'ออกจากระบบ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

class ProfileDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> userProfiles;

  const ProfileDetailScreen({Key? key, required this.userProfiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดพนักงาน'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('รายละเอียดของพนักงาน:'),
            for (var userProfile in userProfiles)
              Text('${userProfile['id']} - ${userProfile['name']}'),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black38,
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "หน้าหลัก"),
          NavigationDestination(icon: Icon(Icons.person), label: "ผู้ใช้"),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/app_logo.png"),
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelListScreen(),
                            ),
                          );
                        },
                        child: const Image(
                          image: AssetImage("assets/images/truck.png"),
                          color: Colors.white,
                          height: 90,
                          width: 90,
                        ),
                      ),
                      const Text(
                        "รายการ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "เดินทาง",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Image(
                          image: AssetImage("assets/images/qr.png"),
                          color: Colors.white,
                          height: 70,
                          width: 70,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "รายละเอียด",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "สินค้า",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
