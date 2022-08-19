class Mahasiswa {
  final String namaMahasiswa;
  final String nimMahasiswa;
  final String id;
  final String imageURL;

  Mahasiswa({
    required this.namaMahasiswa,
    required this.nimMahasiswa,
    required this.id,
    required this.imageURL,
  });

  Map<String, dynamic> toJson() => {
        'nama_mahasiswa': namaMahasiswa,
        'nim_mahasiswa': nimMahasiswa,
        'id': id,
        'image_url': imageURL,
      };

  static Mahasiswa fromJson(Map<String, dynamic> json) => Mahasiswa(
        namaMahasiswa: json['nama_mahasiswa'],
        nimMahasiswa: json['nim_mahasiswa'],
        id: json['id'],
        imageURL: json['image_url'],
      );
}
