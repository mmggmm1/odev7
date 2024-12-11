import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000/ogrenci';

  // 1. Öğrenci Ekleme (POST)
  Future<void> addOgrenci(String ad, String soyad, int bolumId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ad': ad,
        'soyad': soyad,
        'bolumId': bolumId,
      }),
    );

    if (response.statusCode == 201) {
      print('Öğrenci başarıyla eklendi!');
    } else {
      print('Başarısız oldu: ${response.statusCode}');
    }
  }

  // 2. Öğrenci Listeleme (GET)
  Future<void> getOgrenciler() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print('Öğrenciler:');
      data.forEach((ogrenci) {
        print(
            'ID: ${ogrenci['ogrenciID']}, Ad: ${ogrenci['ad']}, Soyad: ${ogrenci['soyad']}');
      });
    } else {
      print('Başarısız oldu: ${response.statusCode}');
    }
  }

  // 3. Öğrenci Güncelleme (PUT)
  Future<void> updateOgrenci(
      int ogrenciID, String ad, String soyad, int bolumId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$ogrenciID'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ad': ad,
        'soyad': soyad,
        'bolumId': bolumId,
      }),
    );

    if (response.statusCode == 200) {
      print('Öğrenci başarıyla güncellendi!');
    } else {
      print('Başarısız oldu: ${response.statusCode}');
    }
  }

  // 4. Öğrenci Silme (DELETE)
  Future<void> deleteOgrenci(int ogrenciID) async {
    final response = await http.delete(Uri.parse('$baseUrl/$ogrenciID'));

    if (response.statusCode == 200) {
      print('Öğrenci başarıyla silindi!');
    } else {
      print('Başarısız oldu: ${response.statusCode}');
    }
  }
}
