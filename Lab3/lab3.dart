// ---------------------------------------------------------
// 1. สร้าง Class แม่ Product
// ---------------------------------------------------------
class Product {
  // 2. ซ่อนข้อมูลด้วย Private (_)
  String _id;           // private variable
  String name;          // public variable
  double _price;        // ใช้ _price เป็น backing field เพื่อทำ Setter Validation
  int? stock;           // nullable (อาจไม่ระบุสต็อก)

  // Constructor แบบ Named Parameters และ Required
  Product({
    required String id,
    required this.name,
    required double price,
    this.stock, // stock เป็น optional (nullable)
  })  : _id = id,
        _price = price;

  // 3. Getter/Setter
  // Getter สำหรับ _id
  String get id => _id;

  // Getter สำหรับ price
  double get price => _price;

  // Setter สำหรับ price (พร้อม Validation)
  set price(double newPrice) {
    if (newPrice > 0) {
      _price = newPrice;
      print(" แก้ไขราคาสำเร็จเป็น: $_price บาท");
    } else {
      print(" [Error] ราคาต้องมากกว่า 0 เท่านั้น! (ค่าเดิม: $_price)");
    }
  }

  // Method: ลดราคา
  void applyDiscount(double percent) {
    if (percent >= 0 && percent <= 100) {
      double discountAmount = _price * (percent / 100);
      _price -= discountAmount;
      print(" ลดราคา $percent% เหลือ: $_price บาท");
    } else {
      print(" [Error] เปอร์เซ็นต์ส่วนลดต้องอยู่ระหว่าง 0-100");
    }
  }

  // Method: เพิ่มสต็อก
  void restock(int amount) {
    // ถ้า stock เป็น null ให้ถือว่าเริ่มจาก 0 แล้วบวกเพิ่ม
    stock = (stock ?? 0) + amount;
    print(" เพิ่มสต็อกจำนวน $amount ชิ้น (คงเหลือปัจจุบัน: $stock)");
  }

  // Method: แสดงข้อมูลสินค้า
  void showInfo() {
    print("--------------------------------");
    print("[สินค้าทั่วไป]");
    print("ID: $_id");
    print("ชื่อ: $name");
    print("ราคา: $_price บาท");
    // ตรวจสอบ null ของ stock
    print("สต็อก: ${stock == null ? 'ยังไม่ระบุสต็อก' : stock.toString()}");
  }
}

// ---------------------------------------------------------
// 4. สร้าง Class ลูก (Inheritance) - DigitalProduct
// ---------------------------------------------------------
class DigitalProduct extends Product {
  double fileSizeMB; // เพิ่ม property เฉพาะ

  DigitalProduct({
    required String id,
    required String name,
    required double price,
    int? stock,
    required this.fileSizeMB,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    print("--------------------------------");
    print("[สินค้าแบบดิจิทัล]"); // แสดงเพิ่มว่าเป็นสินค้าดิจิทัล
    print("ID: $id"); // เรียกผ่าน getter
    print("ชื่อ: $name");
    print("ราคา: $price บาท");
    print("ขนาดไฟล์: $fileSizeMB MB"); // แสดง fileSizeMB
    print("สต็อก: ${stock == null ? 'ไม่จำกัด (Download)' : stock.toString()}");
  }
}

// ---------------------------------------------------------
// 4. สร้าง Class ลูก (Inheritance) - FoodProduct
// ---------------------------------------------------------
class FoodProduct extends Product {
  String expireDate; // เพิ่ม property เฉพาะ

  FoodProduct({
    required String id,
    required String name,
    required double price,
    int? stock,
    required this.expireDate,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    print("--------------------------------");
    print("[สินค้าอาหาร]"); // แสดงเพิ่มว่าเป็นสินค้าอาหาร
    print("ID: $id");
    print("ชื่อ: $name");
    print("ราคา: $price บาท");
    print("วันหมดอายุ: $expireDate"); // แสดงวันหมดอายุ
    print("สต็อก: ${stock == null ? 'ยังไม่ระบุสต็อก' : stock.toString()}");
  }
}

// ---------------------------------------------------------
// Main Function (ทดสอบการทำงาน)
// ---------------------------------------------------------
void main() {
  print("1. สร้างสินค้า 3 ชิ้น");
  // 1. สินค้าทั่วไป (Product) - ลองไม่ใส่ stock เพื่อทดสอบ null
  Product p1 = Product(id: "P001", name: "ปากกา", price: 20.0);

  // 2. สินค้าดิจิทัล (DigitalProduct)
  DigitalProduct p2 = DigitalProduct(
      id: "D001", name: "E-Book Dart OOP", price: 500.0, stock: 100, fileSizeMB: 15.5);

  // 3. สินค้าอาหาร (FoodProduct)
  FoodProduct p3 = FoodProduct(
      id: "F001", name: "ขนมปังโฮลวีต", price: 45.0, stock: 20, expireDate: "2026-01-10");

  // ทดสอบเพิ่มสต็อก (กรณี stock เป็น null ในตอนแรก)
  print(" P1 (ปากกา):");
  p1.restock(50); // จาก null -> 50

  // ทดสอบลดราคา
  print("\n P2 (E-Book):");
  p2.applyDiscount(10); // ลด 10%

  // ทดสอบ Setter Validation (ตั้งราคาติดลบ)
  print("\n P3 (ขนมปัง):");
  p3.price = -100.0; // ต้องขึ้น Error และค่าไม่เปลี่ยน
  p3.price = 55.0;   // ค่าต้องเปลี่ยน

  // เก็บลง List<Product>
  List<Product> productList = [p1, p2, p3];

  // วนลูปเรียก showInfo() ซึ่งจะทำงานตาม Class จริงของ Object นั้นๆ
  for (var item in productList) {
    item.showInfo();
  }
}