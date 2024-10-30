import 'package:hive/hive.dart';

@HiveType(typeId: 0) // Unique identifier for your adapter
class CartItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0;

  @override
  CartItem read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final price = reader.readDouble();
    final quantity = reader.readInt32();
    return CartItem(
      id: id,
      title: title,
      price: price,
      quantity: quantity,
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.price);
    writer.writeInt32(obj.quantity);
  }
}
