import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/respon_pinjam.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController
    with StateMixin<List<DataPinjam>> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pinjamController = TextEditingController();
  final TextEditingController tglpinjamController = TextEditingController();
  final TextEditingController tglkembaliController = TextEditingController();
  final TextEditingController tahunpinjamController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.book);
      if (response.statusCode == 200) {
        final ResponPinjam responPinjam;
        responPinjam = ResponPinjam.fromJson(response.data);
        if (responPinjam.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responPinjam.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch (e) {
      change(null, status: RxStatus.error("Error ${e.message}"));
    } catch (e) {
      change(null, status: RxStatus.error("Error : $e"));
    }
  }
}
