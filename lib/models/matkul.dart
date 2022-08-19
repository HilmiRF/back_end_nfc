class Matkul {
  final String namaMatkul;
  final String kodeMatkul;
  final String sksMatkul;
  final String hariMatkul;
  final String waktuMulaiMatkul;
  final String waktuSelesaiMatkul;
  final String ruangMatkul;
  final String jumlahMHS;
  final String id;

  Matkul({
    required this.namaMatkul,
    required this.kodeMatkul,
    required this.sksMatkul,
    required this.hariMatkul,
    required this.waktuMulaiMatkul,
    required this.waktuSelesaiMatkul,
    required this.ruangMatkul,
    required this.jumlahMHS,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'nama_kelas': namaMatkul,
        'kode_kelas': kodeMatkul,
        'sks_kelas': sksMatkul,
        'hari_kelas': hariMatkul,
        'waktu_kelas_mulai': waktuMulaiMatkul,
        'waktu_kelas_selesai': waktuSelesaiMatkul,
        'ruang_kelas': ruangMatkul,
        'jumlah_mhs': jumlahMHS,
        'id': id,
      };

  static Matkul fromJson(Map<String, dynamic> json) => Matkul(
        namaMatkul: json['nama_kelas'],
        kodeMatkul: json['kode_kelas'],
        sksMatkul: json['sks_kelas'],
        hariMatkul: json['hari_kelas'],
        waktuMulaiMatkul: json['waktu_kelas_mulai'],
        waktuSelesaiMatkul: json['waktu_kelas_selesai'],
        ruangMatkul: json['ruang_kelas'],
        jumlahMHS: json['jumlah_mhs'],
        id: json['id'],
      );
}
