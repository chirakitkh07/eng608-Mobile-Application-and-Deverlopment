# จิรกิตติ์ คำป่าตัน 67543210014-6
## Lab 3
### โจทย์ "ระบบจัดการสินค้า (Product Management System)" ให้ฝึกทำครับ โดยโจทย์ให้:
#### 1.สร้าง Class สินค้า
#### 2.ซ่อนข้อมูลด้วย Private (_)
#### 3.ใช้ Getter/Setter
#### 4.ใช้ Inheritance (เช่น สินค้าทั่วไป, สินค้าลดราคา)

## ผลลัพธ์
![alt text](images/image.png)

อธิบายการทำงาน
1.Encapsulation (การห่อหุ้ม):

ใช้ _id และ _price เป็นตัวแปร Private (มี _ นำหน้า)

ใช้ Getter get id เพื่อให้ภายนอกอ่านค่า _id ได้ แต่แก้ไขไม่ได้

ใช้ Setter set price เพื่อดักจับว่าค่าที่ส่งมาต้องมากกว่า 0 เท่านั้น ถ้าส่งค่าลบมา ระบบจะแจ้งเตือนและไม่บันทึกค่า

2.Inheritance (การสืบทอด):

DigitalProduct และ FoodProduct ใช้คำสั่ง extends Product ทำให้ได้คุณสมบัติ id, name, price, stock มาโดยอัตโนมัติ

Constructor ของลูกส่งค่าไปให้แม่ผ่าน super(...)

3.Polymorphism & Overriding:

ในคลาสลูก เราใช้ @override บนฟังก์ชัน showInfo() เพื่อเปลี่ยนวิธีการแสดงผลให้เหมาะสมกับสินค้านั้นๆ (เช่น โชว์ขนาดไฟล์ หรือ วันหมดอายุ)

ใน main() เมื่อเราวนลูป List<Product> ตัวแปร item แม้จะเป็น Type Product แต่เมื่อเรียกคำสั่ง .showInfo() มันจะไปเรียกฟังก์ชันของลูกจริงๆ (Runtime Polymorphism)

4.Null Safety:

int? stock ยอมรับค่า null ได้

stock ?? 0 แปลว่า ถ้า stock เป็น null ให้ใช้ค่า 0 แทน