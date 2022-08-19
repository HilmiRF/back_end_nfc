class Dosen {
  final String namaDosen;
  final String nipDosen;
  final String id;
  final String imageURL;
  final String emailDosen;

  Dosen({
    required this.namaDosen,
    required this.nipDosen,
    required this.id,
    required this.imageURL,
    required this.emailDosen,
  });

  Map<String, dynamic> toJson() => {
        'nama_dosen': namaDosen,
        'nip_dosen': nipDosen,
        'id': id,
        'image_url': imageURL,
        'email_dosen': emailDosen,
      };

  static Dosen fromJson(Map<String, dynamic> json) => Dosen(
        namaDosen: json['nama_dosen'],
        nipDosen: json['nip_dosen'],
        id: json['id'],
        imageURL: json['image_url'],
        emailDosen: json['email_dosen'],
      );
}
