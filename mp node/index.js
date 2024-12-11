const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3000;

// MySQL Veritabanı Bağlantısı
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',  // Veritabanı kullanıcı adınız
  password: '',  // Veritabanı şifreniz
  database: 'ogrenci_veritabani'  // Veritabanı adı
});

// MySQL bağlantısını kontrol et
db.connect((err) => {
  if (err) {
    console.log('Veritabanı bağlantısı hatası:', err);
  } else {
    console.log('Veritabanına başarılı bir şekilde bağlanıldı...');
  }
});

// Body verisini almak için middleware
app.use(express.json());

// Öğrenci ekleme (POST)
app.post('/ogrenci', (req, res) => {
  const { ad, soyad, bolumId } = req.body;
  const query = 'INSERT INTO ogrenci (ad, soyad, bolumId) VALUES (?, ?, ?)';
  
  db.query(query, [ad, soyad, bolumId], (err, result) => {
    if (err) {
      res.status(500).json({ message: 'Öğrenci eklenirken hata oluştu' });
    } else {
      res.status(201).json({ message: 'Öğrenci başarıyla eklendi' });
    }
  });
});

// Öğrenci bilgilerini listeleme (GET)
app.get('/ogrenci', (req, res) => {
  db.query('SELECT * FROM ogrenci', (err, results) => {
    if (err) {
      res.status(500).json({ message: 'Öğrenciler alınırken hata oluştu' });
    } else {
      res.json(results);
    }
  });
});

// Öğrenci güncelleme (PUT)
app.put('/ogrenci/:id', (req, res) => {
  const { id } = req.params;
  const { ad, soyad, bolumId } = req.body;

  const query = 'UPDATE ogrenci SET ad = ?, soyad = ?, bolumId = ? WHERE ogrenciID = ?';
  db.query(query, [ad, soyad, bolumId, id], (err, result) => {
    if (err) {
      res.status(500).json({ message: 'Öğrenci güncellenirken hata oluştu' });
    } else {
      res.json({ message: 'Öğrenci başarıyla güncellendi' });
    }
  });
});

// Öğrenci silme (DELETE)
app.delete('/ogrenci/:id', (req, res) => {
  const { id } = req.params;

  const query = 'DELETE FROM ogrenci WHERE ogrenciID = ?';
  db.query(query, [id], (err, result) => {
    if (err) {
      res.status(500).json({ message: 'Öğrenci silinirken hata oluştu' });
    } else {
      res.json({ message: 'Öğrenci başarıyla silindi' });
    }
  });
});

// Sunucu başlatma
app.listen(port, () => {
  console.log(`Sunucu ${port} portunda çalışıyor...`);
});
