import 'dart:async';
import 'package:barber_app/core/auto/entitys/register_entity.dart';
import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_app/core/main/home/entitys/home_entity.dart';
import 'package:barber_app/core/passwordmanager/entitys/password_manager_entity.dart';
import 'package:barber_app/core/pay/store_project.dart';
import 'package:barber_app/core/paylist/entitys/pay_list_entity.dart';
import 'package:barber_app/core/paysuccess/entitys/pay_success_entity.dart';
import 'package:barber_app/core/search/search_entity.dart';
import 'package:barber_app/core/store/cardbag/entitys/pay_card_bag_success_entity.dart';
import 'package:barber_app/core/store/detail/entitys/pay_bag_preview_entity.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/core/store/queue/entitys/add_store_queue_entity.dart';
import 'package:barber_app/core/store/subjects/entitys/affirm_dialog_show_entity.dart';
import 'package:barber_app/core/wallet/entitys/wallet_entity.dart';
import 'package:barber_common/helpers/net_work.dart';

class RequestHelper {


  static Future<RegisterEntity> sendRestPasswordCode(String tel) {
    return RequestClient.request<RegisterEntity>(
        (json) => RegisterEntity.fromJson(json),
        '/auth/forgetPassword',
        {'tel': tel});
  }

  static Future<Object> restPassword(
      String tel, String code, String newPassword) {
    return RequestClient.request<Object>(
        (json) => Object(),
        '/auth/restPassword',
        {'tel': tel, 'code': code, 'newPassword': newPassword});
  }



  static Future<StoreProject> getStoreAllProject(int id) {
    return RequestClient.request<StoreProject>(
        (json) => StoreProject.fromJson(json),
        '/store/common/getStoreAllProject',
        {'store_id': id});
  }

  static Future<AffirmDialogShowEntity> generateIndent(
      String selectResult, String store_id) {
    return RequestClient.request<AffirmDialogShowEntity>(
        (json) => AffirmDialogShowEntity.fromJson(json),
        '/store/common/generateIndent',
        {'select_result': selectResult, 'store_id': store_id});
  }

  static Future<PaySuccessEntity> payByIndent(
      String selectResult, String store_id, String paypassword) {
    return RequestClient.request<PaySuccessEntity>(
        (json) => PaySuccessEntity.fromJson(json),
        '/store/common/payByIndent', {
      'select_result': selectResult,
      'store_id': store_id,
      'paypassword': paypassword
    });
  }

  static Future<List<PayListEntity>> expenseCalendar(int index) {
    return RequestClient.request<List<PayListEntity>>(
        (json) => (json as List).map((f) {
              return PayListEntity.fromJson(f);
            }).toList(),
        '/money/common/expenseCalendar',
        {
          'index': index,
          'pageSize': 10,
        });
  }

  static Future<List<WalletEntity>> walletList() {
    return RequestClient.request<List<WalletEntity>>(
      (json) => (json as List).map((f) {
            return WalletEntity.fromJson(f);
          }).toList(),
      '/money/common/cardBagList',
    );
  }

  static Future<AddStoreQueueEntity> addStoreQueue(
      int storeId, String serverName) {
    return RequestClient.request<AddStoreQueueEntity>(
        (json) => AddStoreQueueEntity.fromJson(json),
        '/store/common/addStoreQueue',
        {'store_id': storeId, "serverName": serverName});
  }

  static Future<StoreDetailEntity> storeDetail(int storeId) {
    return RequestClient.request<StoreDetailEntity>(
        (json) => StoreDetailEntity.fromJson(json),
        '/store/common/storeDetail',
        {'store_id': storeId});
  }

  static Future<List<SearchEntity>> searchStoreByName(String query) {
    return RequestClient.request<List<SearchEntity>>(
        (json) => (json as List).map((f) {
              return SearchEntity.fromJson(f);
            }).toList(),
        '/store/searchStoreByName',
        {'store_name': query});
  }

  static Future<AccountEntity> refreshAccount() {
    return RequestClient.request<AccountEntity>(
        (json) => AccountEntity.fromJson(json), '/account/common/refresh');
  }

  static Future<HomeEntity> refreshHome() {
    return RequestClient.request<HomeEntity>(
        (json) => HomeEntity.fromJson(json), '/home/canLogin/refresh');
  }

  static Future<Object> reviseProfile(
      int gender, String nickname, String signature, String avatar) {
    return RequestClient.request<Object>(
        (json) => Object(), '/auth/common/updateUserInfo', {
      "avatar": avatar,
      "gender": gender,
      "nickname": nickname,
      "signature": signature,
    });
  }

  static Future<PayBagPreviewEntity> payStoreCardBag(int id) {
    return RequestClient.request<PayBagPreviewEntity>(
        (json) => PayBagPreviewEntity.fromJson(json),
        '/store/common/payStoreCardBagPreview', {
      "card_id": id,
    });
  }

  static Future<Object> setPayPassword(String paypassword) {
    return RequestClient.request<Object>(
        (json) => Object(), '/auth/common/setPayPassword', {
      "paypassword": paypassword,
    });
  }

  static Future<Object> resetPayPassword(String paypassword, String authCode) {
    return RequestClient.request<Object>(
        (json) => Object(), '/auth/common/resetPayPassword', {
      "paypassword": paypassword,
      "authCode": authCode,
    });
  }

  static Future<PasswordManagerEntity> requestPasswordManager() {
    return RequestClient.request<PasswordManagerEntity>(
        (json) => PasswordManagerEntity.fromJson(json),
        '/auth/common/passwordManagerList', {});
  }

  static Future<RegisterEntity> sendResetPayPasswordCode() {
    return RequestClient.request<RegisterEntity>(
        (json) => RegisterEntity.fromJson(json),
        '/auth/common/sendResetPayPasswordCode', {});
  }

  static Future<PayCardBagSuccessEntity> payCardBag(
      int cardBagId, String paypassword) {
    return RequestClient.request<PayCardBagSuccessEntity>(
        (json) => PayCardBagSuccessEntity.fromJson(json),
        '/store/common/payStoreCardBag',
        {'card_id': cardBagId, 'paypassword': paypassword});
  }


}
