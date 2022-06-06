class Tourplace {
  final int id;
  final String nama_tempat;
  final int kategori;
  final String tipe;
  final String deskripsi;
  final int stoktiket;
  final int harga;
  final String jambuka;
  final String alamat;
  final String img_tempat;

  const Tourplace({
    required this.id,
    required this.nama_tempat,
    required this.kategori,
    required this.tipe,
    required this.deskripsi,
    required this.stoktiket,
    required this.harga,
    required this.jambuka,
    required this.alamat,
    required this.img_tempat,
  });

  factory Tourplace.fromJson(Map<String, dynamic> json) {
    return Tourplace(
      id: json['id'] as int,
      nama_tempat: json['nama_tempat'] as String,
      kategori: json['kategori'] as int,
      tipe: json['tipe'] as String,
      deskripsi: json['deskripsi'] as String,
      stoktiket: json['stok_tiket'] as int,
      harga: json['harga'] as int,
      jambuka: json['jam_buka'] as String,
      alamat: json['alamat'] as String,
      img_tempat: json['img_tempat'] as String,
    );
  }
}
