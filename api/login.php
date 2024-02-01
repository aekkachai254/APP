<?php
$database_hostname = 'localhost';
$database_username = 'team'; 
$database_password = 'Te@m1234!';
$database_databasename = 'management';
$connect_management = new mysqli($database_hostname, $database_username, $database_password, $database_databasename);
date_default_timezone_set('Asia/Bangkok');
//putenv('TZ=Asia/Bangkok');
if(!$connect_management)
{
    //die("Database Connect Failed :".mysqli_connect_error());
}
else
{
    //echo "Database Connected";
}

$username = @$_REQUEST['username'];
$password = @$_REQUEST['password'];
// การ hash รหัสผ่าน
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

if (empty($username) || empty($password)) {
  echo json_encode(['error' => 'กรุณากรอกชื่อผู้ใช้และรหัสผ่าน'], JSON_UNESCAPED_UNICODE);
} else {
    //$sql = "SELECT * FROM ms_personal WHERE telephone = '".$username."'";
    //$query = $connect_management->query($sql);
    //$row = $query->fetch_array();
    //$query->close();
    $sql = "SELECT * FROM ms_personal WHERE telephone = ?";
    $stmt = $connect_management->prepare($sql);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_array();
    $stmt->close();
    
    if (empty($row['telephone'])) {
      echo json_encode(['error' => 'ไม่พบบัญชีผู้ใช้นี้'], JSON_UNESCAPED_UNICODE);
  } elseif ($row['status_account'] == '0') {
      echo json_encode(['error' => 'บัญชีผู้ใช้นี้ถูกปิด โปรดติดต่อผู้ดูแลระบบ'], JSON_UNESCAPED_UNICODE);
  } elseif ($row['status_account'] == '1') {
      echo json_encode(['error' => 'บัญชีนี้ถูกล็อค โปรดติดต่อผู้ดูแลระบบ'], JSON_UNESCAPED_UNICODE);
  } else {
      // ตรวจสอบรหัสผ่าน
      if (password_verify($password, $row['password'])) {
        $timestamp = time();
        $time = date('Y-m-d H:i:s');
        session_start();
        $_SESSION['username'] = $row['telephone'];
        $_SESSION['password'] = $row['password'];
        $sql_lastlogin = "UPDATE ms_personal SET 
        `status_use` = '1',
        `status_lastlogin` = '".$time."' 
        WHERE (`username` = '".$row['username']."')";
        $query_lastlogin = $connect_management->query($sql_lastlogin);
        echo json_encode(['message' => 'เข้าสู่ระบบสำเร็จ โปรดรอสักครู่ ...'], JSON_UNESCAPED_UNICODE);
        } else {
            echo json_encode(['error' => 'รหัสผ่านไม่ถูกต้อง'], JSON_UNESCAPED_UNICODE);
        }
    }
}
$connect_management->close();
?>