class Event {
  final int id;
  final String nama_event;
  final int kategori;
  final String tipe;
  final String regulasi;
  final int stok;
  final int harga;
  final String jammulai;
  final String alamat;
  final String img_tempat;

  const Event({
    required this.id,
    required this.nama_event,
    required this.kategori,
    required this.tipe,
    required this.regulasi,
    required this.stok,
    required this.harga,
    required this.jammulai,
    required this.alamat,
    required this.img_tempat,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      nama_event: json['nama_event'] as String,
      kategori: json['kategori'] as int,
      tipe: json['tipe'] as String,
      regulasi: json['regulasi'] as String,
      stok: json['stok'] as int,
      harga: json['harga'] as int,
      jammulai: json['jam_mulai'] as String,
      alamat: json['alamat'] as String,
      img_tempat: json['img_tempat'] as String,
    );
  }
}
