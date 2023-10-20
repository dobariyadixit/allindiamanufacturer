
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  final  _LoggedIn = "_LoggedIn";
  final  _UserName = "_UserName";
  final  _UserId = "_UserId";
  final  _Qc_Local_Id = "_Qc_Local_Id";
  final  _Qc_Id = "_Qc_Id";
  final  _Apichack = "_LoggedIn";
  static const  _token = "_token";
  static const  _Latitude ="_Latitude";
  static const  _Longitude = "_Longitude";
  static const _loginid = "_loginId";
  static const _loginname = "_loginname";
  static const _lastname = "_lastname";
  static const _displayname = "_displayname";
  static const _mobile = "_mobile";
  static const _birthDate = "_birthDate";
  static const _birthTime = "_birthTime";
  static const _birthPlace = "_birthPlace";
  static const _sign = "_sign";
  static const _deletedAt = "_deletedAt";
  static const _createdAt = "_createdAt";
  static const _updatedAt = "_updatedAt";
  static const _chackQcid = "_chackQcid";
  static const _chackQcList = "_chackQcList";


  getAllPrefsClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("_LoggedIn");
    prefs.remove("_UserName");
    prefs.remove("_UserId");
    prefs.remove("_Qc_Local_Id");
    prefs.remove("_Qc_Id");
    prefs.remove("_Apichack");
    prefs.remove("_token");
    prefs.remove("_Latitude");
    prefs.remove("_Longitude");
    prefs.remove("_loginid");
    prefs.remove("_loginname");
    prefs.remove("_displayname");
    prefs.remove("_mobile");
    prefs.remove("_birthDate");
    prefs.remove("_birthTime");
    prefs.remove("_birthPlace");
    prefs.remove("_sign");
    prefs.remove("_deletedAt");
    prefs.remove("_createdAt");
    prefs.remove("_updatedAt");
    prefs.remove("_chackQcid");
    prefs.remove("_chackQcList");
    prefs.clear();
  }

  Future<bool> ischackQcList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chackQcList) ?? false;
  }

  Future<bool> setchackQcList(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_chackQcList, value);
  }

  Future<bool> isChackqcid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chackQcid) ?? false;
  }
  Future<bool> setChackqcid(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_chackQcid, value);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_LoggedIn) ?? false;
  }
  Future<bool> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_LoggedIn, value);
  }

  Future<int> isQc_LocalId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_Qc_Local_Id) ?? 0;
  }
  Future<bool> setQc_LocalId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_Qc_Local_Id, value);
  }
  Future<int> isQc_Id() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_Qc_Id) ?? 0;
  }
  Future<bool> setQc_Id(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_Qc_Id, value);
  }


  Future<bool> isApichack() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_Apichack) ?? false;
  }
  Future<bool> setApichack(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_Apichack, value);
  }

  Future<String> istoken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token) ?? '0';
  }
  Future<bool> settoken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_token, value);
  }

  Future<String> isLatitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_Latitude) ?? '0';
  }
  Future<bool> setLatitude(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_Latitude, value);
  }

  Future<String> isLongitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_Longitude) ?? '0';
  }
  Future<bool> setLongitude(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_Longitude, value);
  }

  Future<String> isloginid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loginid) ?? '0';
  }
  Future<bool> setloginid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_loginid, value);
  }

  Future<String> isuserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UserName) ?? '0';
  }
  Future<bool> setuserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UserName, value);
  }

  Future<String> islastname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastname) ?? '0';
  }
  Future<bool> setlastname(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_lastname, value);
  }

  Future<String> ismobileNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_mobile) ?? '0';
  }
  Future<bool> setmobileNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_mobile, value);
  }

  Future<String> isuserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_UserId) ?? '0';
  }
  Future<bool> setuserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_UserId, value);
  }

  Future<String> isbirthTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_birthTime) ?? '0';
  }
  Future<bool> setbirthTime(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_birthTime, value);
  }

  Future<String> isbirthPlace() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_birthPlace) ?? '0';
  }
  Future<bool> setbirthPlace(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_birthPlace, value);
  }

  Future<String> issign() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sign) ?? '0';
  }
  Future<bool> setsign(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_sign, value);
  }

  Future<String> isdeletedAt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deletedAt) ?? '0';
  }
  Future<bool> setdeletedAt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_deletedAt, value);
  }

  Future<String> iscreatedAt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_createdAt) ?? '0';
  }
  Future<bool> setcreatedAt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_createdAt, value);
  }

  Future<String> isupdatedAt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_updatedAt) ?? '0';
  }
  Future<bool> setupdatedAt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_updatedAt, value);
  }



}
