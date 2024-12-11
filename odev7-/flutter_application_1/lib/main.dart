import 'package:flutter/material.dart';
import 'api_service.dart'; // api_service.dart dosyasını import ediyoruz

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OgrenciPage(),
    );
  }
}

class OgrenciPage extends StatefulWidget {
  @override
  _OgrenciPageState createState() => _OgrenciPageState();
}

class _OgrenciPageState extends State<OgrenciPage> {
  final ApiService apiService =
      ApiService(); // ApiService nesnesi oluşturuluyor
  TextEditingController adController =
      TextEditingController(); // Ad için TextEditingController
  TextEditingController soyadController =
      TextEditingController(); // Soyad için TextEditingController
  TextEditingController bolumIdController =
      TextEditingController(); // Bölüm ID için TextEditingController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci CRUD İşlemleri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ad TextField
            TextField(
              controller: adController,
              decoration: InputDecoration(labelText: 'Ad'),
            ),
            // Soyad TextField
            TextField(
              controller: soyadController,
              decoration: InputDecoration(labelText: 'Soyad'),
            ),
            // Bölüm ID TextField
            TextField(
              controller: bolumIdController,
              decoration: InputDecoration(labelText: 'Bölüm ID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20), // Butonlar arasında boşluk ekliyoruz
            // Öğrenci Ekleme Butonu
            ElevatedButton(
              onPressed: () {
                // API üzerinden yeni öğrenci ekleme
                apiService.addOgrenci(
                  adController.text,
                  soyadController.text,
                  int.parse(bolumIdController
                      .text), // Bölüm ID'si integer'a çevriliyor
                );
              },
              child: Text('Öğrenci Ekle'),
            ),
            // Öğrencileri Listeleme Butonu
            ElevatedButton(
              onPressed: () {
                // API üzerinden öğrenci listesini alıyoruz
                apiService.getOgrenciler();
              },
              child: Text('Öğrencileri Listele'),
            ),
          ],
        ),
      ),
    );
  }
}
