import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/bookFromLibraryModel.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/categoryModel.dart';
import 'package:kaalan/models/newsModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/localdbservices.dart';

const endpoint = "https://kaalan-api.onrender.com";
const token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTcwMjA1MDIzOSwiZXhwIjoxNzMzNTg2MjM5fQ.vlAMLEwlVnkDYZRt5pz9QqaJtWoenAbf76gvrcNBSHk";

Future<dynamic> axios(String url, bool withoutHeader,
    {String methode = 'GET', Map<String, dynamic>? donnees}) async {
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };

  http.Response response;

  try {
    switch (methode) {
      case 'GET':
        !withoutHeader
            ? response = await http.get(Uri.parse(url), headers: headers)
            : response = await http.get(Uri.parse(url));
        break;
      case 'POST':
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(donnees));
        break;
      case 'PUT':
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(donnees));
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse(url), headers: headers);
        break;
      default:
        throw Exception("Méthode HTTP non supportée");
    }

    return json.decode(response.body);
  } catch (e) {
    print(e);
    return {"message": "$e"};
  }
}

Future<List<CategoryModel>> fetchCategories() async {
  final response =
      await axios('$endpoint/api/categories', false, methode: 'GET');

  try {
    if (response["message"] ==
        "La liste complètes des categories a bien été reccupérée.") {
      List<dynamic> categoriesData = response["data"];
      return categoriesData
          .map((category) => CategoryModel.fromMap(category))
          .toList();
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<BookModel>> fetchAllBooks() async {
  final response = await axios('$endpoint/api/books', false, methode: 'GET');

  try {
    if (response["message"] ==
        "La liste complète des livres a bien été reccupérée.") {
      List<dynamic> booksData = response["data"];

      return booksData.map((book) => BookModel.fromMap(book)).toList();
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<bool> sendSuggestion(int userId, String suggestion) async {
  final response = await axios('$endpoint/api/suggestions', false,
      methode: 'POST', donnees: {'idOfuser': userId, 'suggestion': suggestion});
  print(response);
  try {
    print(response["message"]);
    if (response["message"] == "La suggestion a bien été ajoutée.") {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> addToLibrary(int userId, int bookId, int page) async {
  final response = await axios('$endpoint/api/users/${userId}', false,
      methode: 'PUT',
      donnees: {
        'libraryBooks': '${bookId}',
      });
  try {
    if (response["message"] == "Livre ajouté à votre bibliothèque.") {
      DatabaseManager.instance.addBookProgress(BookFromLibraryModel(
          bookId: bookId, progress: page, isFinish: false));
      return "Livre ajouté à votre bibliothèque.";
    } else {
      return response["message"];
    }
  } catch (e) {
    return '${e}';
  }
}

Future<String> removeToLibrary(int userId, int bookId) async {
  final response = await axios(
      '$endpoint/api/users/${userId}?action=delete', false,
      methode: 'PUT',
      donnees: {
        'libraryBooks': '${bookId}',
      });
  try {
    if (response["message"] == "Livre retiré de votre bibliothèque.") {
      DatabaseManager.instance.deleteBookProgress(bookId);
      return "Livre retiré de votre bibliothèque.";
    } else {
      return response["message"];
    }
  } catch (e) {
    return '${e}';
  }
}

Future<List<BookModel>> fetchLibraryBooks(int userId) async {
  final response = await axios('$endpoint/api/books?library=${userId}', false,
      methode: 'GET');
  print(response["message"]);
  try {
    if (response["message"] ==
        "La librairie complète de l'utilisateur a bien été récupérée.") {
      List<dynamic> booksData = response["data"];
      List<BookModel> books =
          booksData.map((book) => BookModel.fromMap(book)).toList();

      return books;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<BookModel>> fetchBooksByCategories(String category) async {
  final response = await axios('$endpoint/api/books?category=$category', false,
      methode: 'GET');

  try {
    List<dynamic> booksData = response["data"];

    return booksData.map((book) => BookModel.fromMap(book)).toList();
  } catch (e) {
    return [];
  }
}

Future<List<BookModel>> fetchTopBooksSearched(int limit) async {
  final response =
      await axios('$endpoint/api/books?limit=$limit', false, methode: 'GET');

  try {
    List<dynamic> booksData = response["data"];

    return booksData.map((book) => BookModel.fromMap(book)).toList();
  } catch (e) {
    return [];
  }
}

Future<List<AuthorWithBookModel>> fetchTopAuthorsSearched(int limit) async {
  final response = await axios('$endpoint/api/authors', false, methode: 'GET');

  try {
    List<dynamic> authorsData = response["data"];

    return authorsData.map((authorData) {
      AuthorModel author = AuthorModel.fromMap(authorData['author']);

      List<dynamic> booksData = authorData['books'];
      List<BookModel> books =
          booksData.map((book) => BookModel.fromMap(book)).toList();

      return AuthorWithBookModel(author: author, books: books);
    }).toList();
  } catch (e) {
    print(e);
    return [];
  }
}

Future<ApiResponseModel> loginAPI(String email, String password) async {
  String? tokenfetched = await FirebaseMessaging.instance.getToken();

  final response = await axios('$endpoint/api/loginToApi', false,
      methode: 'POST',
      donnees: {
        'emailAddress': email,
        'password': password,
        'fcmToken': tokenfetched
      });

  try {
    if (response["message"] == "L'utilisateur s'est connecté avec succès.") {
      await DatabaseManager.instance.addUser(UserModel(
        id: response["data"]['id'],
        emailAddress: response["data"]['emailAddress'],
        phone: response["data"]['phone'],
        username: response["data"]['username'],
        role: response["data"]['role'],
        password: password,
        firstname: response["data"]['firstname'],
        lastname: response["data"]['lastname'],
      ));
    }
    print(response["message"]);
    return ApiResponseModel(
        message: response["message"], data: response["data"]);
  } catch (e) {
    print(e);
    return ApiResponseModel(message: "$e");
  }
}

Future<ApiResponseModel> registerToAPI(
  String email,
  String password,
  String? firstname,
  String lastname,
) async {
  final response = await axios('$endpoint/api/signupToApi', false,
      methode: 'POST',
      donnees: {
        'emailAddress': email,
        'password': password,
        'role': "USER",
        'firstname': firstname,
        'lastname': lastname,
      });
  try {
    if (response["message"] == "Compte crée avec succès!") {
      await DatabaseManager.instance.addUser(UserModel(
        id: response["data"]['id'],
        emailAddress: response["data"]['emailAddress'],
        phone: response["data"]['phone'],
        username: response["data"]['username'],
        role: response["data"]['role'],
        password: password,
        firstname: response["data"]['firstname'],
        lastname: response["data"]['lastname'],
      ));
    }
    print(response["data"]);
    return ApiResponseModel(
        message: response["message"], data: response["data"]);
  } catch (e) {
    return ApiResponseModel(message: "$e");
  }
}

Future<ApiResponseModel> resetPassword(
  String email,
) async {
  final response = await axios('$endpoint/api/reset-password', false,
      methode: 'POST',
      donnees: {
        'emailAddress': email,
      });
  try {
    print(response["message"]);
    return ApiResponseModel(
        message: response["message"],
        data: {'verificationCode': response['verificationCode']});
  } catch (e) {
    print(e);
    return ApiResponseModel(message: "$e");
  }
}

Future<ApiResponseModel> checkCodeForResetPassword(
    String email, String verificationCode, String newPassword) async {
  final response = await axios('$endpoint/api/reset-password-verify', false,
      methode: 'POST',
      donnees: {
        'emailAddress': email,
        'verificationCode': verificationCode,
        'newPassword': newPassword
      });
  try {
    print(response["message"]);
    return ApiResponseModel(message: response["message"]);
  } catch (e) {
    print(e);
    return ApiResponseModel(message: "$e");
  }
}

Future<List<NewsModel>> fetchNews() async {
  final response = await axios(
      'https://newsapi.org/v2/everything?language=fr&q=afrique&pageSize=20&apiKey=7f6117f2e6bb4b92a3eed97ec504a276',
      true,
      methode: 'GET');

  try {
    if (response["status"] == "ok") {
      List<dynamic> newsData = response["articles"];

      return newsData.map((news) => NewsModel.fromMap(news)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
