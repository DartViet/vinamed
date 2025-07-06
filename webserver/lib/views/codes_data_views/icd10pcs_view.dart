import 'package:database_models/models/variables/varibles.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/controllers/codes_data_controllers/icd10pcs_controller.dart';
import 'package:webserver/goodies/api_extension.dart';

class Icd10PcsView {
  Router router;

  Icd10PcsView(this.router) {
    router.post('/api/${NetWorkConfig.instance.apiVersion}/${Variables.instance.icd10pcs}/search', Icd10pcsController.instance.searchItem);
    router.get('/api/${NetWorkConfig.instance.apiVersion}/${Variables.instance.icd10pcs}/<code>', (Icd10pcsController.instance.getIcd10PcsItem));
  }
}
