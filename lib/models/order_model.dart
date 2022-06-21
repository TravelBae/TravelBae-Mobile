class Order {
  final int id;
  final int id_customer;
  final int id_tempat;
  final int id_event;
  final String nama_customer;
  final String order_status;
  final String tanggal_beli;
  final int total_bayar;
  final int total_tiket;
  final String bank;

  const Order(
      {required this.id,
      required this.id_customer,
      required this.id_tempat,
      required this.id_event,
      required this.nama_customer,
      required this.order_status,
      required this.tanggal_beli,
      required this.total_bayar,
      required this.total_tiket,
      required this.bank});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      id_customer: json['id_customer'] as int,
      id_tempat: json['id_tempat'] as int,
      id_event: json['id_event'] as int,
      nama_customer: json['nama_customer'] as String,
      order_status: json['order_status'] as String,
      tanggal_beli: json['tanggal_beli'] as String,
      total_bayar: json['total_bayar'] as int,
      total_tiket: json['total_tiket'] as int,
      bank: json['bank'] as String,
    );
  }
}
