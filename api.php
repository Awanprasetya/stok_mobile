<?php
include 'connect.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');

$action = $_GET['action'] ?? '';

if ($action == 'get_items') {
    // Mengambil data items
    $result = $conn->query("SELECT * FROM items");

    // Cek apakah query berhasil
    if ($result) {
        $items = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(['status' => 'success', 'data' => $items]);
    } else {
        // Jika query gagal
        echo json_encode(['status' => 'error', 'message' => 'Failed to fetch items']);
    }
} elseif ($action == 'add_item') {
    // Menambahkan item baru
    $name = $_POST['name'] ?? '';
    $quantity = $_POST['quantity'] ?? 0;
    $price = $_POST['price'] ?? 0.0;

    // Validasi input
    if (empty($name) || !is_numeric($quantity) || $quantity <= 0 || !is_numeric($price) || $price <= 0) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
        exit;
    }

    // Menggunakan prepared statements untuk menghindari SQL Injection
    $stmt = $conn->prepare("INSERT INTO items (name, quantity, price) VALUES (?, ?, ?)");
    $stmt->bind_param("sid", $name, $quantity, $price);  // s = string, i = integer, d = double

    // Eksekusi query
    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Item added successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to add item']);
    }
} elseif ($action == 'delete_item') {
    // Menghapus item berdasarkan id
    $id = $_POST['id'] ?? 0;

    // Validasi id
    if (!is_numeric($id) || $id <= 0) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid ID']);
        exit;
    }

    // Menggunakan prepared statements untuk menghindari SQL Injection
    $stmt = $conn->prepare("DELETE FROM items WHERE id = ?");
    $stmt->bind_param("i", $id);  // i = integer

    // Eksekusi query
    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Item deleted successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to delete item']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid action']);
}
?>
