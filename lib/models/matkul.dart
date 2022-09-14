class Matkul {
  final String namaMatkul;
  final String kodeMatkul;
  final String sksMatkul;
  final String id;

  Matkul({
    required this.namaMatkul,
    required this.kodeMatkul,
    required this.sksMatkul,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'nama_kelas': namaMatkul,
        'kode_kelas': kodeMatkul,
        'sks_kelas': sksMatkul,
        'id': id,
      };

  static Matkul fromJson(Map<String, dynamic> json) => Matkul(
        namaMatkul: json['nama_kelas'],
        kodeMatkul: json['kode_kelas'],
        sksMatkul: json['sks_kelas'],
        id: json['id'],
      );
}
