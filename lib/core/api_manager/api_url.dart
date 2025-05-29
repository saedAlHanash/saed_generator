class GetUrl {
  static const plan = 'Plan/Get';
  //
}

class PostUrl {
  static const plans = 'Plan/GetAll';
  static const createPlan = 'Plan/Add';
  //
}

class PutUrl {
  static const updatePlan = 'Plan/Update';
  //
}

class DeleteUrl {
  static const deletePlan = 'Plan/Delete';
  //
}

class PatchUrl {
  //
}

const additionalConst = '/api/v1/';
const localUrl = '192.168.1.107:5001';
const liveUrl = 'qbank-be.coretech-mena.com';

String get baseUrl {
  // return localUrl;
  return liveUrl;
}

String imagePath = 'http://$baseUrl/documents/';