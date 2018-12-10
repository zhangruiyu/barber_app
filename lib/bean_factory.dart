import 'package:barber_app/core/passwordmanager/entitys/password_manager_entity.dart';
import 'package:barber_app/core/auto/entitys/register_entity.dart';
import 'package:barber_app/core/auto/entitys/login_entity.dart';
import 'package:barber_app/core/paylist/entitys/pay_list_entity.dart';
import 'package:barber_app/core/paysuccess/entitys/pay_success_entity.dart';
import 'package:barber_app/core/search/search_entity.dart';
import 'package:barber_app/core/wallet/entitys/wallet_entity.dart';
import 'package:barber_app/core/main/home/entitys/home_entity.dart';
import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_app/core/store/cardbag/entitys/pay_card_bag_success_entity.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/core/store/detail/entitys/pay_bag_preview_entity.dart';
import 'package:barber_app/core/store/subjects/entitys/affirm_dialog_show_entity.dart';
import 'package:barber_app/core/store/queue/entitys/add_store_queue_entity.dart';

class BeanFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "PasswordManagerEntity") {
      return PasswordManagerEntity.fromJson(json) as T;
    } else if (T.toString() == "RegisterEntity") {
      return RegisterEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "PayListEntity") {
      return PayListEntity.fromJson(json) as T;
    } else if (T.toString() == "PaySuccessEntity") {
      return PaySuccessEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchEntity") {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == "WalletEntity") {
      return WalletEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeEntity") {
      return HomeEntity.fromJson(json) as T;
    } else if (T.toString() == "AccountEntity") {
      return AccountEntity.fromJson(json) as T;
    } else if (T.toString() == "PayCardBagSuccessEntity") {
      return PayCardBagSuccessEntity.fromJson(json) as T;
    } else if (T.toString() == "StoreDetailEntity") {
      return StoreDetailEntity.fromJson(json) as T;
    } else if (T.toString() == "PayBagPreviewEntity") {
      return PayBagPreviewEntity.fromJson(json) as T;
    } else if (T.toString() == "AffirmDialogShowEntity") {
      return AffirmDialogShowEntity.fromJson(json) as T;
    } else if (T.toString() == "AddStoreQueueEntity") {
      return AddStoreQueueEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}