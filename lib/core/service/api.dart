import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/model/service_model.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:fresh9_rider/core/component/endpoints.dart';
import 'package:fresh9_rider/ui/shared/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final client = http.Client();
  final Duration timeOutDuration = Duration(seconds: 30);

  int attempt = 1;
  int totalAttempt = 3;

  onException(dynamic error) {
    print(error);
    if (error is SocketException) {
      return UIHelper.noConnection;
    }

    if (error is TimeoutException) {
      return UIHelper.timeOut;
    } else {
      if (attempt > totalAttempt) {
        attempt = 1;
      }
      attempt++;
      if (attempt <= totalAttempt) {
        print("Attempt $attempt");
        return false;
      } else {
        return UIHelper.sthWentWrong;
      }
    }
  }

  Future<BaseModel> sendNotification(token, userId) async {
    String url = notificationUrl +"/store/"+ userId;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Orders: ${response.body}');
      return BaseModel(body: response.body);
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
    }
  }

  Future<LoginModel> login(Map body) async {
    print(body);
    String url = numberLoginUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Accept': '*/*',
            },
            body: body,
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      sharedPreference.setString(SharedPreference.user, response.body);
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      var data = onException(e);
      return LoginModel.withError(data);
    }
  }

  Future<LoginModel> updateProfile(Map body, String id, token) async {
    print(body);
    String url = userUrl + id;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .put(
            Uri.parse(url),
            headers: {
              'Accept': '*/*',
              'Content-Type': 'application/json',
              "Authorization": token
            },
            body: jsonEncode(body),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      Map responseData = jsonDecode(response.body);
      responseData['user'] = responseData['message'];
      return LoginModel.fromJson(responseData);
    } catch (e) {
      var data = onException(e);
      return LoginModel.withError(data);
    }
  }

  Future<LoginModel> submitSuggestion(Map body, token) async {
    print(body);
    String url = suggestionUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Accept': '*/*',
              'Content-Type': 'application/json',
              "Authorization": token
            },
            body: jsonEncode(body),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Suggestion: ${response.body}');
      Map responseData = jsonDecode(response.body);
      responseData['user'] = responseData['message'];
      return LoginModel.fromJson(responseData);
    } catch (e) {
      var data = onException(e);
      return LoginModel.withError(data);
    }
  }

  Future<LoginModel> getProfile(String id, token) async {
    String url = userUrl + id;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
          "Authorization": token
        },
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      Map responseData = jsonDecode(response.body);
      responseData['user'] = responseData['message'];
      return LoginModel.fromJson(responseData);
    } catch (e) {
      var data = onException(e);
      return LoginModel.withError(data);
    }
  }

  Future<LoginModel> signup(Map body) async {
    print(body);
    String url = signupUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      var data = onException(e);
      return LoginModel.withError(data);
    }
  }

  Future<BaseModel> otherStores(token, data) async {
    String url = getAllOtherShops;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      return BaseModel(
          body: List<StoreModel>.from(jsonDecode(response.body).map(
        (x) => StoreModel.fromJson(x),
      )));
    } catch (e) {
      var errorData = onException(e);
//      return [];
      return errorData is bool
          ? BaseModel.withError(UIHelper.noConnection)
          : BaseModel.withError(errorData);
    }
  }

  Future<BaseModel> checkout(token) async {
    String url = getAllOtherShops;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      return BaseModel(
          body: List<StoreModel>.from(jsonDecode(response.body).map(
        (x) => StoreModel.fromJson(x),
      )));
    } catch (e) {
      var errorData = onException(e);
      return BaseModel.withError(errorData);
    }
  }

  Future<BaseModel> getRestuarants(token, Map data) async {
    String url = getAllRestuarants;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      return BaseModel(
          body: List<StoreModel>.from(jsonDecode(response.body).map(
        (x) => StoreModel.fromJson(x),
      )));
    } catch (e) {
      var errorData = onException(e);
      return errorData is bool
          ? BaseModel.withError(UIHelper.noConnection)
          : BaseModel.withError(errorData);
    }
  }

  Future<BaseModel> getFresh9(token, Map data) async {
    String url = getAllFresh9;
    print("url : $url");
    print(data['lat'] is double);
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Accept': '*/*',
          "Authorization": token,
          'Content-Type': 'application/json'
        },
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from get Fresh 9: ${response.body}');
      return BaseModel(
          body: List<StoreModel>.from(jsonDecode(response.body).map(
        (x) => StoreModel.fromJson(x),
      )));
    } catch (e) {
      var serverError = onException(e);
//      print(e);
      return serverError is bool
          ? BaseModel.withError(UIHelper.noConnection)
          : BaseModel.withError(serverError);
    }
  }

  Future<void> addLocation(data) async {
    print("making call to add location");
    String url = addLocationUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from add location: ${response.body}');

      return true;
    } catch (e) {
      var errorData = onException(e);
      return false;
    }
  }

  Future<BaseModel> getServices(token, Map data) async {
    String url = getAllServices;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Accept': '*/*',
          "Authorization": token,
          'Content-Type': 'application/json'
        },
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from services: ${response.body}');

      return BaseModel(
          body: List<Service>.from(jsonDecode(response.body).map(
        (x) => Service.fromJson(x),
      )));
    } catch (e) {
      var serverError = onException(e);
      return serverError is bool
          ? BaseModel.withError(UIHelper.noConnection)
          : BaseModel.withError(serverError);
    }
  }

  Future<BaseModel> getMyOrders(token, userId) async {
    String url = getOrders + userId;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Orders: ${response.body}');
      return BaseModel(body: response.body);
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
    }
  }

  Future cancelOrder(token, orderId) async {
    String url = orderUrl + orderId;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.put(Uri.parse(url),
          headers: {'Accept': '*/*', "Authorization": token},
          body: {"orderStatus": "canceled"}).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Order cancelled: ${response.body}');
      return BaseModel(body: response.body);
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
    }
  }

  Future<StoreModel> getSingleStore(String token, String storeId) async {
    String url = storeUrl + storeId;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');
      return StoreModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      var errorData = onException(e);
      return StoreModel.withError(errorData);
//      return null;
    }
  }

  Future<BaseModel> allProducts(token, String storeId) async {
    String url = storeUrl + storeId + '/products';
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from products: ${response.body}');
      return BaseModel(
          body: List<Product>.from(jsonDecode(response.body).map(
        (x) => Product.fromJson(x),
      )));
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
//      return data is bool ? await login(body) : LoginModel.withError(data);
    }
  }

  Future<BaseModel> searchItems(String text, double lat, double lng) async {
    String url = storeUrl +
        "search/" +
        text +
        "/" +
        lat.toString() +
        "/" +
        lng.toString();
    print("Search url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': '*/*',
        },
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from products: ${response.body}');
      return BaseModel(body: jsonDecode(response.body));
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
//      return data is bool ? await login(body) : LoginModel.withError(data);
    }
  }

  Future<BaseModel> getBanners(token, type, lat, lng) async {
    String url = bannerUrl + "location";
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Accept': '*/*',
              'Content-Type': 'application/json',
              "Authorization": token
            },
            body: jsonEncode({"lat": lat, "lng": lng, "businessType": type}),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Location: ${response.body}');
      return BaseModel(body: jsonDecode(response.body));
    } catch (e) {
      var serverError = onException(e);
      print(serverError);
      return BaseModel.withError(serverError.toString());
//      return data is bool ? await login(body) : LoginModel.withError(data);
    }
  }

  Future<BaseModel> getCategories(token) async {
    String url = categoryUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');

      return BaseModel(
          body: List<Category>.from(jsonDecode(response.body).map(
        (x) => Category.fromJson(x),
      )));
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
//      return data is bool ? await login(body) : LoginModel.withError(data);
    }
  }

  Future<BaseModel> getSubCategories(token) async {
    String url = subCategoryUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': '*/*', "Authorization": token},
      ).timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Login: ${response.body}');

      return BaseModel(
          body: List<Category>.from(jsonDecode(response.body).map(
        (x) => Category.fromJson(x),
      )));
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
//      return data is bool ? await login(body) : LoginModel.withError(data);
    }
  }

//
//  Future<UserModel> getCustomerInfo(String token) async {
//    String url = customerUrl + token;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .get(
//            url,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from Customer User: ${response.body}');
//      return UserModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getCustomerInfo(token)
//          : UserModel.withError(data);
//    }
//  }
//
//  Future<RestaurantAPI1Model> getRestaurant(
//      String latitude, String longitude) async {
//    String url = "$getRestaurantAPI1&latitude=$latitude&longitude=$longitude";
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .get(
//            url,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from Restaurant API 1: ${response.body}');
//      return RestaurantAPI1Model.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getRestaurant(latitude, longitude)
//          : RestaurantAPI1Model.withError(data);
//    }
//  }
//
//  Future<RestaurantAPI2Model> getRestaurantByRestaurantId(
//      String latitude, String longitude, String restaurantId) async {
//    String url =
//        "$getRestaurantAPI2&restaurant_id=$restaurantId&latitude=$latitude&longitude=$longitude";
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .get(
//            url,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from Restaurant API 2: ${response.body}');
//      return RestaurantAPI2Model.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getRestaurantByRestaurantId(latitude, longitude, restaurantId)
//          : RestaurantAPI2Model.withError(data);
//    }
//  }
//
//  Future<AllRestaurantModel> allRestaurantFetch() async {
//    String url = getAllRestaurant;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .get(
//            url,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from All Restaurant Fetch: ${response.body}');
//      return AllRestaurantModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await allRestaurantFetch()
//          : AllRestaurantModel.withError(data);
//    }
//  }
//
//  Future<PasswordModel> forgotPassword(String email) async {
//    String url = forgotPasswordUrl;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http.post(
//        url,
//        headers: {
//          'Accept': 'multipart/form-data',
//        },
//        body: {
//          "email": email,
//          "language_id": "1",
//        },
//      ).timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from Forgot Password: ${response.body}');
//      return PasswordModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await forgotPassword(email)
//          : PasswordModel.withError(data);
//    }
//  }
//
//  Future<PasswordModel> changePassword(
//      String oldPassword, String password, String confirm, String key) async {
//    String url = changePasswordUrl;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http.post(
//        url,
//        headers: {
//          'Accept': 'multipart/form-data',
//          'Customer-Authorization': key,
//        },
//        body: {
//          "old_password": oldPassword,
//          "password": password,
//          "confirm": confirm,
//          "language_id": "1",
//        },
//      ).timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from ChangePassword: ${response.body}');
//      return PasswordModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await changePassword(oldPassword, password, confirm, key)
//          : PasswordModel.withError(data);
//    }
//  }
//
//  Future<CouponCheckModel> requestCoupon(String token, Map body) async {
//    String url = couponCheck;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              "Customer-Authorization": token,
//              "Accept": "application/json"
//            },
//            body: body,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from requestCoupon: ${response.body}');
//      return CouponCheckModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await requestCoupon(token, body)
//          : CouponCheckModel.withError(data);
//    }
//  }
//
//  Future<CouponAddModel> addCoupon(String token, Map body) async {
//    String url = couponAdd;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              "Customer-Authorization": token,
//              "Accept": "application/json"
//            },
//            body: jsonEncode(body),
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from add Coupon: ${response.body}');
//      return CouponAddModel.fromJson(jsonDecode(jsonEncode(b)));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await addCoupon(token, body)
//          : CouponAddModel.withError(data);
//    }
//  }
//
//  Map b = {
//    "coupon": {
//      "coupon_code": "RSB",
//      "coupon_name": "Coupon RSB",
//      "coupon_discount_amount": "400"
//    },
//    "success": {"status": "200", "message": "Success"}
//  };
//
  Future<BaseModel> order(Map body, String key) async {
    String url = orderUrl;
    print("url : $url");
    final stopwatch = new Stopwatch()..start();
    try {
      var response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': '*/*',
              'Authorization': key,
            },
            body: jsonEncode(body),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from Order: ${response.body}');
      return BaseModel(body: jsonDecode(response.body));
    } catch (e) {
      var serverError = onException(e);
      return BaseModel.withError(serverError);
//      return data is bool ? await order(body, key) : OrderModel.withError(data);
    }
  }
//
//  Future<OrderListModel> getOrderList(String token) async {
//    String url = orderList;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http.get(
//        url,
//        headers: {"Customer-Authorization": token},
//      ).timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from orderStatus: ${response.body}');
//      return OrderListModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getOrderList(token)
//          : OrderListModel.withError(data);
//    }
//  }
//
//  Future<OrderDetailModel> getOrderDetails(String token, String orderId) async {
//    String url = orderDetail + orderId + languageUrl;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http.get(
//        url,
//        headers: {
//          "Customer-Authorization": token,
//        },
//      ).timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from order Details: ${response.body}');
//      return OrderDetailModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getOrderDetails(token, orderId)
//          : OrderDetailModel.withError(data);
//    }
//  }
//
//  Future<OrderStatus> getOrderStatus(String orderId) async {
//    String url = orderStatus + orderId;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .get(
//            url,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from orderStatus: ${response.body}');
//      return OrderStatus.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getOrderStatus(orderId)
//          : OrderStatus.withError(data);
//    }
//  }
//
//  Future<ReviewModel> giveReview(String token, Map body) async {
//    String url = review;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              "Customer-Authorization": token,
//              "Accept": "application/json"
//            },
//            body: body,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from give review: ${response.body}');
//      return ReviewModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await giveReview(token, body)
//          : ReviewModel.withError(data);
//    }
//  }
//
//  Future<PaymentTokenModel> getPaymentToken(Map body) async {
//    String url = paymentToken;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              'Accept': 'application/json',
//            },
//            body: body,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from payment token: ${response.body}');
//      return PaymentTokenModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getPaymentToken(body)
//          : PaymentTokenModel.withError(data);
//    }
//  }
//
//  Future<PaymentAuthorizationModel> authorizePayment(
//      String token, Map body) async {
//    String url = paymentAuthorize;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              'Accept': 'application/json',
//              'Authorization': 'Bearer $token'
//            },
//            body: body,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from authorize payment: ${response.body}');
//      return PaymentAuthorizationModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await authorizePayment(token, body)
//          : PaymentAuthorizationModel.withError(data);
//    }
//  }
//
//  Future<PaymentStatusModel> getPaymentStatus(
//      String token, String email, String orderId) async {
//    String url = "$paymentStatus?tx_email=$email&tx_order=$orderId";
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http.get(
//        url,
//        headers: {
//          'Accept': 'application/json',
//          'Authorization': 'Bearer $token'
//        },
//      ).timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from get payment status: ${response.body}');
//      return PaymentStatusModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await getPaymentStatus(token, email, orderId)
//          : PaymentStatusModel.withError(data);
//    }
//  }
//
//  Future<PaymentCreationModel> createPayment(String token, Map body) async {
//    String url = paymentCreate;
//    print("url : $url");
//    final stopwatch = new Stopwatch()..start();
//    try {
//      var response = await http
//          .post(
//            url,
//            headers: {
//              'Accept': 'application/json',
//              'Authorization': 'Bearer $token'
//            },
//            body: body,
//          )
//          .timeout(timeOutDuration);
//      print('Time Taken - ${stopwatch.elapsed}');
//      print('The response from create payment: ${response.body}');
//      return PaymentCreationModel.fromJson(jsonDecode(response.body));
//    } catch (e) {
//      var data = onException(e);
//      return data is bool
//          ? await createPayment(token, body)
//          : PaymentCreationModel.withError(data);
//    }
//  }
}
