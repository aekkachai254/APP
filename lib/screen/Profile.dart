import 'package:application/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

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
          "ผู้ใช้",
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
                  radius: 65,
                  backgroundColor: Colors.white,
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
                // แสดง ID จากข้อมูลผู้ใช้
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchAllUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        children: snapshot.data!.map((userData) {
                          return Text(
                            'ID: ${userData['id'] ?? ""}',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // ... ส่วนอื่น ๆ ของ Widget
                InkWell(
                  onTap: () async {
                    final response = await http.get(Uri.parse(
                        'http://teamproject.ddns.net:81/project/api/profile.php?username=0640986563'));

                    if (response.statusCode == 200) {
                      List<Map<String, dynamic>> userProfiles =
                          List<Map<String, dynamic>>.from(
                              json.decode(response.body));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailScreen(
                            userProfiles: userProfiles,
                          ),
                        ),
                      );
                    } else {
                      print('Failed to load user data');
                    }
                  },
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Container(
                        width: 250.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF567BAE),
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

  // เพิ่ม Future function เพื่อดึงข้อมูลผู้ใช้ทั้งหมดจาก API
  Future<List<Map<String, dynamic>>> _fetchAllUserData() async {
    final response = await http.get(Uri.parse(
        'http://teamproject.ddns.net:81/project/api/profile.php?username=0640986563'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> userProfiles =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      return userProfiles;
    } else {
      throw Exception('Failed to load user data');
    }
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
        title: Text('รายละเอียดผู้ใช้'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: userProfiles.map((userData) {
            return Column(
              children: [
                Text('ID: ${userData['id']}'),
                Text('Name: ${userData['name']}'),
                // แสดงข้อมูลอื่น ๆ ตามที่ต้องการ
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
