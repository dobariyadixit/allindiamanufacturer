class ApiUrl
{

  /// ---->> Base Url

  static String BaseUrl = "https://marketing.parivartanacademy.org.in/api/";

  /// ---->> Api

  // Login Url
  static String loginApi = BaseUrl+"login";

  // Otp Url
  static String OtpApi = BaseUrl+"check_otp";

  // Get Post

  static String GetPost = BaseUrl+"get_post";

  //-->> Pagination Get Post Home Screen

  /// -- >>> Before Call Api Insert Page Number
  static String all_post = BaseUrl+"all_post?perpage=15&page=";


  // Add Post

  static String AddPost = BaseUrl+"add_post";

  // Get Favrite Post

  //static String GetFavoritePost = BaseUrl+"get_favorite_post";
  static String GetFavoritePost = BaseUrl+"get_favorite_post?perpage=30&page=";

  // Add Favorite Post

 static String AddFavoritePost = BaseUrl+"add_favorite_post";

  // Delete Post

  static String DeletePost = BaseUrl+"delete_post";

  // Edit Post

  static String EditPodt = BaseUrl+"edit_post";

  // Get User Upload Post

  static String GetUserUploadPost = BaseUrl+"get_my_post?perpage=30&page=";

  // Upload Firebase Token

  static String UploadFireBaseToken = BaseUrl+"add_device_token";

  // All User Api

 static String AllUserApi = BaseUrl+"get_users?perpage=50&page=";

 // User Profile Api

  static String UserProfileLogo = BaseUrl+"find-profile";

  // Update Profile

 static String UpdateProfile = BaseUrl+"update-profile";



}
