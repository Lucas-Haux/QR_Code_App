import 'dart:io';

String handleError(dynamic error) {
  if (error is FormatException) {
    return 'Invalid QR code format. Please check your input.';
  } else if (error is SocketException) {
    return 'Network error. Please check your internet connection.';
  } else {
    return 'An unexpected error occurred: $error';
  }
}
