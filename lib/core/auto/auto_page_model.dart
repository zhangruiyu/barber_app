
import 'package:scoped_model/scoped_model.dart';

class AutoPageShowModel extends Model {
  String currentPageName = "LoginPage";
  String loginTel = "15201231801";

  setCurrentPage(String pageName) {
    currentPageName = pageName;
    notifyListeners();
  }
}
