import 'package:application/screen/TakePhoto.dart';
import 'package:application/screen/ProductDetail.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  final Map<String, dynamic> ProductDetail;

  VerifyScreen({required this.ProductDetail});

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        'รายการสินค้า',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(ProductDetail: ProductDetail);
              },
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TakePhotoScreen();
                },
              ),
            );
          },
          iconSize: 30,
        ),
      ],
    );
  }

  Widget listviewHeading() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'รายการ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ),
          Text(
            'ชั้นวาง',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(left: 9),
            child: Text(
              'จำนวน',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 9),
            child: Text(
              'ตรวจสอบ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            listviewHeading(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: 380,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                productList[index]['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 0),
                            Text(
                              productList[index]['shelf'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(width: 45),
                            Text(
                              productList[index]['quantity'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(width: 45),
                            GestureDetector(
                              onTap: () {
                                productList[index]['checked'] =
                                    !productList[index]['checked'];
                              },
                              child: productList[index]['checked']
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> productList = [
  {
    "name": "1.ปูไทย รสปลาหมึก",
    "shelf": "P6",
    "quantity": 2,
    "checked": true,
  },
  {
    "name": "2.ดินสอ",
    "shelf": "C2",
    "quantity": 1,
    "checked": true,
  },
  {
    "name": "3.น้ำปลาทิพรส",
    "shelf": "W3",
    "quantity": 2,
    "checked": true,
  },
  {
    "name": "4.น้ำมันถั่วเหลือง",
    "shelf": "W1",
    "quantity": 3,
    "checked": true,
  },
  {
    "name": "5.ปลากระป๋องโรซ่า",
    "shelf": "F7",
    "quantity": 3,
    "checked": true,
  },
  {
    "name": "6.นมถั่วเหลือง",
    "shelf": "M10",
    "quantity": 1,
    "checked": false,
  },
  {
    "name": "7.มาม่าคัพ รสต้มยำกุ้ง",
    "shelf": "M15",
    "quantity": 2,
    "checked": true,
  },
  {
    "name": "8.เนสกาแฟเรดคัพ",
    "shelf": "C7",
    "quantity": 1,
    "checked": true,
  },
  {
    "name": "9.น้ำตาลทรายขาว",
    "shelf": "S8",
    "quantity": 3,
    "checked": true,
  },
  {
    "name": "10.เลย์ รสโนริสาหร่าย",
    "shelf": "L2",
    "quantity": 2,
    "checked": true,
  },
];
