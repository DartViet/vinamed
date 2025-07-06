import 'package:database_models/models/variables/varibles.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/controllers/codes_data_controllers/dhs_controller.dart';
import 'package:webserver/goodies/api_extension.dart';

class DhsView {
  Router router;

  DhsView(this.router) {
    router.post('/api/${NetWorkConfig.instance.apiVersion}/${Variables.instance.dhs}/search', DhsController.instance.searchItem);
    router.get('/api/${NetWorkConfig.instance.apiVersion}/${Variables.instance.dhs}/<code>', (DhsController.instance.getDhsItem));
  }
}
