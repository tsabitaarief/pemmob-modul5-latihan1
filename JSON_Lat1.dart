import 'dart:convert'; // Berfungsi untuk mengkonversi JSON menjadi obyek di dart

void main() {
  String transkripJson = '''
    {
      "nama": "Puti Tsabita Najwa Arief",
      "NPM": "22082010065",
      "program_studi": {
        "nama": "Sistem informasi",
        "fakultas": "Ilmu Komputer"
      },
      "mata_kuliah": [
        {
          "kode": "SI351",
          "nama": "Pengantar Sistem Informasi",
          "sks": 3,
          "nilai": "A"
        },
        {
          "kode": "SI352",
          "nama": "Bahasa Pemrograman 1",
          "sks": 3,
          "nilai": "B"
        },
        {
          "kode": "SI353",
          "nama": "Tata Kelola Teknologi Informasi",
          "sks": 3,
          "nilai": "B+"
        }
      ]
    }
    ''';

  Map<String, dynamic> transkrip = jsonDecode(
      transkripJson); // jsonDecode berfungsi dalam membuat konversi string JSON menjadi obyek dart.

  double ipk = hitungIPK(
      transkrip); // Membuat total IPK berdasarkan nilai pada transkrip.
  print('Nama: ${transkrip['nama']}'); // Menampilkan nama mahasiswa.
  print('NPM: ${transkrip['NPM']}'); // Menampilkan NPM mahasiswa.
  print(
      'Program Studi: ${transkrip['program_studi']['nama']}'); // Menampilkan program studi mahasiswa.
  print(
      'Fakultas: ${transkrip['program_studi']['fakultas']}'); // Menampilkan fakultas mahasiswa.
  print('Mata Kuliah:'); // Menampilkan awalan sebelum daftar mata kuliah.
  for (var mataKuliah in transkrip['mata_kuliah']) {
    // Menampilkan setiap mata kuliah pada transkrip menggunakan iterasi.
    print(
        '- ${mataKuliah['kode']} - ${mataKuliah['nama']} (${mataKuliah['sks']} SKS)'); // Menampilkan informasi dari setiap mata kuliah berupa kode, nama, jumlah SKS, dan nilai.
    print('  Nilai: ${mataKuliah['nilai']}');
  }
  print('IPK: $ipk'); // Menampilkan hasil perhitungan IPK mahasiswa.
}

double hitungIPK(Map<String, dynamic> transkrip) {
  // Membuat fungsi untuk menghitung hasil IPK.
  int totalSks = 0; // Membuat variabel yang berfungsi menampung total SKS.
  double totalBobot =
      0.0; // Membuat variabel yang berfungsi menampung total bobot.

  for (var mataKuliah in transkrip['mata_kuliah']) {
    // Menjalankan iterasi pada setiap mata kuliah yang ada di dalam transkrip mahasiswa.
    int sks = mataKuliah[
        'sks']; // Mencari dan menyimpan jumlah SKS pada satu mata kuliah.
    totalSks +=
        sks; // Menghitung jumlah SKS dari setiap mata kuliah ke total SKS.
    String nilai = mataKuliah['nilai']; // Menyimpan hasil nilai mata kuliah.
    double bobot =
        0.0; // Membuat variabel yang berfungsi menampung bobot nilai.

    // Membuat fungsi untuk menghitung bobot berdasarkan nilai.
    if (nilai == 'A') {
      bobot = 4.0;
    } else if (nilai == 'A-') {
      bobot = 3.75;
    } else if (nilai == 'B+') {
      bobot = 3.5;
    } else if (nilai == 'B') {
      bobot = 3.25;
    }

    totalBobot += (bobot *
        sks); // Membuat penghitungan bobot nilai dikali SKS ke dalam total bobot.
  }

  if (totalSks == 0) {
    // Melakukan pengecekan pada total SKS adalah nol dengan tujuan untuk menghindari pembagian dengan nol.
    return 0.0;
  } else {
    return totalBobot /
        totalSks; // Return nilai IPK, dengan IPK = total bobot dibagi dengan total SKS.
  }
}
