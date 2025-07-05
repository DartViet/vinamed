import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/controllers/codes_data_controllers/icd10cm_controller.dart';
import 'package:webserver/goodies/api_extension.dart';

class Icd10CmView {
  Router router;

  Icd10CmView(this.router) {
    router.post('/api/${NetWorkConfig.instance.apiVersion}/icd10cm/search', Icd10cmController.instance.searchItem);
    router.get('/api/${NetWorkConfig.instance.apiVersion}/icd10cm/<code>', (Icd10cmController.instance.getIcd10CmItem));
  }
}
