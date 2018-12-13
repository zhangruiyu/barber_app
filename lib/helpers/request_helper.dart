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
import 'package:barber_app/helpers/net_work.dart';

class RequestHelper {
  static Future<RegisterEntity> sendRestPasswordCode(String tel) {
    return AppRequestClient.request<RegisterEntity>(
        '/auth/forgetPassword', {'tel': tel});
  }

  static Future<Object> restPassword(
      String tel, String code, String newPassword) {
    return AppRequestClient.request<Object>('/auth/restPassword',
        {'tel': tel, 'code': code, 'newPassword': newPassword});
  }

  static Future<StoreProject> getStoreAllProject(int id) {
    return AppRequestClient.request<StoreProject>(
        '/store/common/getStoreAllProject', {'store_id': id});
  }

  static Future<AffirmDialogShowEntity> generateIndent(
      String selectResult, String store_id) {
    return AppRequestClient.request<AffirmDialogShowEntity>(
        '/store/common/generateIndent',
        {'select_result': selectResult, 'store_id': store_id});
  }

  static Future<PaySuccessEntity> payByIndent(
      String selectResult, String store_id, String paypassword) {
    return AppRequestClient.request<PaySuccessEntity>(
        '/store/common/payByIndent', {
      'select_result': selectResult,
      'store_id': store_id,
      'paypassword': paypassword
    });
  }

  static Future<PayListEntity> expenseCalendar(int index) {
    return AppRequestClient.request<PayListEntity>(
        '/money/common/expenseCalendar', {
      'index': index,
      'pageSize': 10,
    });
  }

  static Future<WalletListEntity> walletList() {
    return AppRequestClient.request<WalletListEntity>(
      '/money/common/cardBagList',
    );
  }

  static Future<AddStoreQueueEntity> addStoreQueue(
      int storeId, String serverName) {
    return AppRequestClient.request<AddStoreQueueEntity>(
        '/store/common/addStoreQueue',
        {'store_id': storeId, "serverName": serverName});
  }

  static Future<StoreDetailEntity> storeDetail(int storeId) {
    return AppRequestClient.request<StoreDetailEntity>(
        '/store/common/storeDetail', {'store_id': storeId});
  }

  static Future<SearchEntity> searchStoreByName(String query) {
    return AppRequestClient.request<SearchEntity>(
        '/store/searchStoreByName', {'store_name': query});
  }

  static Future<AccountEntity> refreshAccount() {
    return AppRequestClient.request<AccountEntity>('/account/common/refresh');
  }

  static Future<HomeEntity> refreshHome() {
    return AppRequestClient.request<HomeEntity>('/home/canLogin/refresh');
  }

  static Future<Object> reviseProfile(
      int gender, String nickname, String signature, String avatar) {
    return AppRequestClient.request<Object>('/auth/common/updateUserInfo', {
      "avatar": avatar,
      "gender": gender,
      "nickname": nickname,
      "signature": signature,
    });
  }

  static Future<PayBagPreviewEntity> payStoreCardBag(int id) {
    return AppRequestClient.request<PayBagPreviewEntity>(
        '/store/common/payStoreCardBagPreview', {
      "card_id": id,
    });
  }

  static Future<Object> setPayPassword(String paypassword) {
    return AppRequestClient.request<Object>('/auth/common/setPayPassword', {
      "paypassword": paypassword,
    });
  }

  static Future<Object> resetPayPassword(String paypassword, String authCode) {
    return AppRequestClient.request<Object>('/auth/common/resetPayPassword', {
      "paypassword": paypassword,
      "authCode": authCode,
    });
  }

  static Future<PasswordManagerEntity> requestPasswordManager() {
    return AppRequestClient.request<PasswordManagerEntity>(
        '/auth/common/passwordManagerList', {});
  }

  static Future<RegisterEntity> sendResetPayPasswordCode() {
    return AppRequestClient.request<RegisterEntity>(
        '/auth/common/sendResetPayPasswordCode', {});
  }

  static Future<PayCardBagSuccessEntity> payCardBag(
      int cardBagId, String paypassword) {
    return AppRequestClient.request<PayCardBagSuccessEntity>(
        '/store/common/payStoreCardBag',
        {'card_id': cardBagId, 'paypassword': paypassword});
  }
}
