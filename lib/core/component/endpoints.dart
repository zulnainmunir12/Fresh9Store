//const String baseUrl = "https://quiznoscrv2.smipos.com/index.php";
//const String baseUrl = "https://quiznos.ideliveryapp.com/index.php";
const String baseUrl = "http://40.121.147.31:10000/";
const categoryUrl = baseUrl+"category/";
const subCategoryUrl = baseUrl+"category/subCategory";
const bannerUrl = baseUrl+"ads/";
const notificationUrl = "${baseUrl}notification";
const getRestaurantAPI1 = "$baseUrl?route=app/feed/getList";
const getRestaurantAPI2 = "$baseUrl?route=app/feed/getInfo";

const registerUrl = "$baseUrl?route=app/customer/registration";
const loginUrl = baseUrl+"users/login";
const userUrl = baseUrl+"users/";
const suggestionUrl = baseUrl+"suggestion/";
const signupUrl = baseUrl+"users/signup";
const numberLoginUrl = baseUrl+"users/numberLogin";
const customerUrl = "$baseUrl?route=app/customer/customer_info&customer_id=";

const forgotPasswordUrl = "$baseUrl?route=app/customer/forgot_password";
const changePasswordUrl = "$baseUrl?route=app/account/password";

const storeUrl = baseUrl+"store/";
const getAllOtherShops = baseUrl+"store/grocery";
const getAllRestuarants = baseUrl+"store/restuarant";
const getAllFresh9 = baseUrl+"store/fresh9";
const getAllServices = baseUrl+"service/location";
const addLocationUrl = baseUrl+"location";
const getOrders = baseUrl+"order/user/";
const orderUrl = baseUrl+"order/";

const orderList = "$baseUrl?route=app/account/order&language_id=1";
const orderDetail = "$baseUrl?route=app/account/order_info&order_id=";
const languageUrl = "&language_id=1";
const orderStatus = "$baseUrl?route=app/order/order_status&order_id=";
const review = "$baseUrl?route=app/review/add";

const couponCheck = "$baseUrl?route=app/coupon";
const couponAdd = "$baseUrl?route=app/cart/products";

const paymentToken =
    "https://phplaravel-458822-1436912.cloudwaysapps.com/user/login";
const paymentAuthorize =
    "https://phplaravel-458822-1436912.cloudwaysapps.com/transaction/authorize3ds";

const paymentStatus =
    "https://phplaravel-458822-1436912.cloudwaysapps.com/transaction/status";

const paymentCreate =
    "https://phplaravel-458822-1436912.cloudwaysapps.com/transaction/create";
