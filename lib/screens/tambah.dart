import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tambah extends StatelessWidget {
  const Tambah({super.key});

  @override
  Widget build(BuildContext context) {
    var baseUrl = 'http://10.0.2.2:8000/api';
    final Map<String, dynamic> user =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final TextEditingController judul = TextEditingController();
    final TextEditingController edisi = TextEditingController();
    final TextEditingController penerbit = TextEditingController();
    addData() async {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user['token']}'
      };

      var body = {
        'judul': judul.text,
        'edisi_ke': edisi.text,
        'penerbit_id': penerbit.text,
      };

      var response = await http.post(
        Uri.parse('$baseUrl/master/buku/tambah'),
        headers: headers,
        body: body,
      );
      print(response.body);

      if (response.statusCode == 201) {
        print('oke');
      } else {
        print('tes');
      }
    }

    formTambah() {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: judul,
              decoration: const InputDecoration(hintText: 'Judul Buku'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: edisi,
              decoration: const InputDecoration(hintText: 'Edisi Ke'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: penerbit,
              decoration: const InputDecoration(hintText: 'Penerbit'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formTambah(),
            ElevatedButton(
              onPressed: () {
                addData();
                Navigator.pop(context);
              },
              child: const Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }
}
