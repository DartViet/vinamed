import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/controllers/codes_data_controllers/fda_drug_controller.dart';
import 'package:webserver/goodies/api_extension.dart';

class FdaDrugView {
  Router router;

  FdaDrugView(this.router) {
    router.post('/api/${NetWorkConfig.instance.apiVersion}/fdadrug/search', FdaDrugController.instance.searchItem);
    router.get('/api/${NetWorkConfig.instance.apiVersion}/fdadrug/<applNo>', (FdaDrugController.instance.getFdaDrugItems));
  }
}
