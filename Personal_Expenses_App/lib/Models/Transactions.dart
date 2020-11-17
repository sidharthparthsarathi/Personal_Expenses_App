import 'dart:convert';
class Transaction
{
  String id;
  String title;
  double amount;
  DateTime date;
  Transaction({this.id,this.title,this.amount,this.date});
 factory Transaction.fromJson(Map<String, dynamic> jsonData) {
    return Transaction(
      id: jsonData['id'],
      title: jsonData['title'],
      amount: double.parse(jsonData['amount']),
      date: DateTime.parse(jsonData['date']),
    );
  }
  static Map<String, dynamic> toMap(Transaction transaction) => {
        'id': transaction.id,
        'title': transaction.title,
        'amount': transaction.amount.toString(),//Converted This To String
        'date': transaction.date.toString(),//Converted This To String
      };
  static String encodeTransactions(List<Transaction> transactions){
    return json.encode(
        transactions
            .map<Map<String, dynamic>>((transaction) => Transaction.toMap(transaction))
            .toList(),
      );
  }
  static List<Transaction> decodeTransactions(String transactions){
      return (json.decode(transactions) as List<dynamic>)
          .map<Transaction>((item) => Transaction.fromJson(item))
          .toList();
  }
}