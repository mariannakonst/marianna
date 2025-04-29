<?php
session_start();

// Εμφάνιση μηνυμάτων λάθους ή επιτυχίας
$error_message = $_SESSION['error_message'] ?? '';
$success_message = $_SESSION['success_message'] ?? '';
unset($_SESSION['error_message'], $_SESSION['success_message']);
?>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Creation Form</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
   




</head>

<body>
    <div class="container">
        <?php if ($success_message): ?>
            <div class="success"><?= htmlspecialchars($success_message) ?></div>
        <?php else: ?>
            <h1>Create an Account</h1>
            <?php if ($error_message): ?>
                <div class="error"><?= htmlspecialchars($error_message) ?></div>
            <?php endif; ?>
            <form method="POST" action="controller.php">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>

                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" required>

                <label for="dob">Date of Birth:</label>
                <input type="text" id="dob" name="dob" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit">Create Account</button>
            </form>
        <?php endif; ?>
    </div>

    <script>
        // Ενεργοποίηση ημερολογίου
        document.addEventListener('DOMContentLoaded', function () {
         flatpickr("#dob", {
           dateFormat: "Y-m-d", // Ορισμός μορφής ημερομηνίας
           maxDate: "today"  // Περιορίζει την ημερομηνία στο σήμερα
    });
});

    </script>
</body>
</html>
