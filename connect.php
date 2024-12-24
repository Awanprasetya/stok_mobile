<?php
$host = 'localhost';
$user = 'root';
$password = 'kur@keissoft';
$database = 'stock_management';

try {
    // Menggunakan mysqli dengan exception
    $conn = new mysqli($host, $user, $password, $database);

    // Set error mode menjadi exception
    $conn->set_charset("utf8");  // Menetapkan charset agar mendukung karakter khusus

    if ($conn->connect_error) {
        throw new Exception("Connection failed: " . $conn->connect_error);
    }

    echo "Connection successful!";
} catch (Exception $e) {
    // Menangkap exception dan menampilkan pesan kesalahan
    die("Error: " . $e->getMessage());
}
?>
