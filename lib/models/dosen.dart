class Dosen {
  final String namaDosen;
  final String nipDosen;
  final String id;
  final String imageURL;

  Dosen({
    required this.namaDosen,
    required this.nipDosen,
    required this.id,
    required this.imageURL,
  });

  Map<String, dynamic> toJson() => {
        'nama_dosen': namaDosen,
        'nip_dosen': nipDosen,
        'id': id,
        'image_url': imageURL,
      };

  static Dosen fromJson(Map<String, dynamic> json) => Dosen(
        namaDosen: json['nama_dosen'],
        nipDosen: json['nip_dosen'],
        id: json['id'],
        imageURL: json['image_url'],
      );
}
