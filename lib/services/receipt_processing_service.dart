import 'dart:io';
import 'dart:math';
import '../models/receipt.dart';

/// Service for processing receipt images.
/// Currently returns mock data. Replace with real n8n + Google Document AI endpoint later.
/// 
/// Real implementation should POST to: https://<your-n8n-domain>/webhook/fishle-process-receipt
/// Send the image as multipart/form-data or base64.
/// Receive JSON that maps to ParsedReceipt model.
class ReceiptProcessingService {
  static final ReceiptProcessingService _instance = ReceiptProcessingService._internal();
  factory ReceiptProcessingService() => _instance;
  ReceiptProcessingService._internal();

  /// Process receipt image and extract structured data.
  /// This is a MOCK implementation. Replace with real n8n + Google Document AI endpoint later.
  Future<ParsedReceipt> processReceiptImage(File imageFile) async {
    // Simulate network delay (1-2 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    // TODO: Replace with real API call
    // final request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse('https://<n8n-endpoint>/webhook/fishle-process-receipt'),
    // );
    // request.files.add(await http.MultipartFile.fromPath('receipt', imageFile.path));
    // final response = await request.send();
    // final responseBody = await response.stream.bytesToString();
    // final jsonData = json.decode(responseBody);
    // return ParsedReceipt.fromJson(jsonData);

    // MOCK DATA - returns example parsed receipt
    return _getMockParsedReceipt();
  }

  ParsedReceipt _getMockParsedReceipt() {
    final mockReceipts = [
      ParsedReceipt(
        merchantName: 'Migros',
        date: DateTime.now(),
        subtotal: 120.50,
        vatAmount: 10.50,
        totalAmount: 131.00,
        items: [
          ParsedReceiptItem(
            name: 'Süt',
            quantity: 1,
            unitPrice: 20.0,
            lineTotal: 20.0,
          ),
          ParsedReceiptItem(
            name: 'Ekmek',
            quantity: 2,
            unitPrice: 5.0,
            lineTotal: 10.0,
          ),
          ParsedReceiptItem(
            name: 'Peynir',
            quantity: 1,
            unitPrice: 45.50,
            lineTotal: 45.50,
          ),
          ParsedReceiptItem(
            name: 'Domates',
            quantity: 3,
            unitPrice: 15.0,
            lineTotal: 45.0,
          ),
        ],
      ),
      ParsedReceipt(
        merchantName: 'A101',
        date: DateTime.now(),
        subtotal: 85.40,
        vatAmount: 7.60,
        totalAmount: 93.00,
        items: [
          ParsedReceiptItem(
            name: 'Çay',
            quantity: 1,
            unitPrice: 25.0,
            lineTotal: 25.0,
          ),
          ParsedReceiptItem(
            name: 'Şeker',
            quantity: 2,
            unitPrice: 18.0,
            lineTotal: 36.0,
          ),
          ParsedReceiptItem(
            name: 'Yumurta',
            quantity: 1,
            unitPrice: 24.40,
            lineTotal: 24.40,
          ),
        ],
      ),
      ParsedReceipt(
        merchantName: 'Şok Market',
        date: DateTime.now(),
        subtotal: 156.30,
        vatAmount: 14.70,
        totalAmount: 171.00,
        items: [
          ParsedReceiptItem(
            name: 'Makarna',
            quantity: 3,
            unitPrice: 8.50,
            lineTotal: 25.50,
          ),
          ParsedReceiptItem(
            name: 'Salça',
            quantity: 2,
            unitPrice: 15.0,
            lineTotal: 30.0,
          ),
          ParsedReceiptItem(
            name: 'Pirinç',
            quantity: 1,
            unitPrice: 42.80,
            lineTotal: 42.80,
          ),
          ParsedReceiptItem(
            name: 'Zeytinyağı',
            quantity: 1,
            unitPrice: 58.0,
            lineTotal: 58.0,
          ),
        ],
      ),
    ];

    // Return random mock receipt
    final random = Random();
    return mockReceipts[random.nextInt(mockReceipts.length)];
  }
}

