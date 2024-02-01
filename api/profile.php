<?php
// ตรวจสอบว่า request เป็นแบบ OPTIONS หรือไม่ (สำหรับการทำ CORS preflight)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // ตั้งค่า header สำหรับการทำ CORS preflight
    header('Access-Control-Allow-Origin: *'); // หรือตั้งค่าเป็น domain ที่อนุญาต
    header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type');
    header('Access-Control-Allow-Headers: Content-Type, Authorization'); // เพิ่ม Authorization ที่นี่
}

// ตั้งค่า header สำหรับการทำ CORS ใน response
header('Access-Control-Allow-Origin: *'); // หรือตั้งค่าเป็น domain ที่อนุญาต
header('Content-Type: application/json; charset=utf-8');

$database_hostname = 'localhost';
$database_username = 'team'; 
$database_password = 'Te@m1234!';
$database_databasename = 'management';
$connect_management = new mysqli($database_hostname, $database_username, $database_password, $database_databasename);
date_default_timezone_set('Asia/Bangkok');

$response = [];

if(!$connect_management) {
    $response['error'] = 'Database Connect Failed: ' . mysqli_connect_error();
} else {
    $response['message'] = 'Database Connected!';
    $username = isset($_REQUEST['username']) ? $_REQUEST['username'] : '';
    // สร้าง SQL query เพื่อดึงข้อมูลผู้ใช้
    $sql = "SELECT * FROM ms_personal WHERE telephone = ?";
    $stmt = $connect_management->prepare($sql);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_array();
    $stmt->close();

    // ตรวจสอบว่ามีข้อมูลหรือไม่
    if ($result->num_rows > 0) {
        // แปลงข้อมูลในรูปแบบของ Array
        $row = $result->fetch_array();

        // สร้าง Array สำหรับเก็บข้อมูลผู้ใช้
        $userProfile = array(
            'name' => $row['name'],
            'id' => $row['id'],
            'department' => $row['department'],
            'birthday' => $row['birthday'],
            'email' => $row['email'],
            'telephone' => $row['telephone']
        );

        // ส่งค่าในรูปแบบ JSON กลับไปยัง Dart application
        echo json_encode($userProfile);
    } else {
        // ถ้าไม่มีข้อมูล
        echo "No user found";
    }
}
// ปิดการเชื่อมต่อกับ MySQL
$connect_management->close();
?>