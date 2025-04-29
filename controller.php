<?php
session_start();

// Συλλογή δεδομένων από τη φόρμα
$name = $_POST['name'] ?? '';
$gender = $_POST['gender'] ?? '';
$phone = $_POST['phone'] ?? '';
$dob = $_POST['dob'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

// Έλεγχος επικύρωσης
if (empty($name) || empty($gender) || empty($phone) || empty($dob) || empty($email) || empty($password)) {
    $_SESSION['error_message'] = "All fields are required!";
} elseif (!is_numeric($phone)) {
    $_SESSION['error_message'] = "Phone number must be numeric!";
} elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $_SESSION['error_message'] = "Invalid email format!";
} elseif (strlen($password) < 8) {
    $_SESSION['error_message'] = "Password must be at least 8 characters!";
} else {
    $_SESSION['success_message'] = "Thank you $name, for creating an account on our platform. You will receive more details at $email.";
}

// Ανακατεύθυνση πίσω στη φόρμα
header('Location: index.php');
exit();
