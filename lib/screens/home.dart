import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List buku = [];
  bool tambah = false;
  bool refresh = false;
  @override
  Widget build(BuildContext context) {
    var baseUrl = 'http://10.0.2.2:8000/api';

    final Map<String, dynamic> user =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    getData() async {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user['token']}'
      };

      var response = await http.get(
        Uri.parse('$baseUrl/master/buku'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        setState(() {
          buku = jsonDecode(response.body)['data']['data'];
        });
      } else {
        print(response.body);
      }
    }

    getLogout() async {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user['token']}'
      };

      var response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        print(response);
      }
    }

    hapus(id) async {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user['token']}'
      };

      var response = await http.delete(
        Uri.parse('$baseUrl/master/buku/hapus/$id'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        getData();
      } else {
        print(response.body);
      }
    }

    header() {
      getData();
      return Container(
        color: const Color(0xff123456),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'HAllo ${user['data']['name']}',
                    style: const TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user['data']['email'],
                    style: const TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    logout() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
        onPressed: getLogout,
        child: const Text('LogOut'),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: logout(),
      body: SafeArea(
        child: Column(
          children: [
            header(),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/tambah',
                              arguments: user);
                        },
                        child: const Text('Tambah Data'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            refresh = !refresh;
                          });
                        },
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text('Data'),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Text('Judul'),
                      SizedBox(width: 70),
                      Text('Edisi Ke'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buku == [null]
                      ? const Text('Tidak Ada Data')
                      : Column(
                          children: buku
                              .map(
                                (e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e['judul']),
                                    Text(
                                      e['edisi_ke'].toString(),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/ubah',
                                            arguments: {
                                              'user': user,
                                              'data': e
                                            });
                                      },
                                      child: const Text('Ubah'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        hapus(
                                          e['id'].toString(),
                                        );
                                      },
                                      child: const Text('Hapus'),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
