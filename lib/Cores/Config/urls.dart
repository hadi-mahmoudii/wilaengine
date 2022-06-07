class Urls {
  static const baseUrl = 'https://www.wilaart.com/api/v1';
  // // static const domain = 'https://Willaarts.com';
  // static const domain = 'https://www.willaengine.ir';
  // // static const domain = 'https://www.kamancable.ir';

  static const login = '$baseUrl/login';

  static const signUp = '$baseUrl/register';

  static const verifyForgetPassNumber = '$baseUrl/verify-forgot-password';
  static const sendRePass = '$baseUrl/reset-password';
  static const getForgetPassNumber = '$baseUrl/forgot-password';
  static const verifyRegisterNumber = '$baseUrl/verify-register';

  static const getMyOrderForms = '$baseUrl/order-photos';
  static const addMyOrderForms = '$baseUrl/order-photos-client';
  static String updateMyOrderForms(String id) {
    return '$baseUrl/order-photos-client/$id';
  }

  static String deleteMyOrderForms(String id) {
    return '$baseUrl/order-photos/$id';
  }

  static const addImage = '$baseUrl/file';
  static String removeImage(String id) {
    return '$baseUrl/file/$id';
  }

  static const getBlogItems = '$baseUrl/get-articles?per_page=10';
  static const sendComment = '$baseUrl/comments';
  static String getComments(String id, String type, String page) {
    return '$baseUrl/comments?per_page=10&rel_id=$id&rel_type=$type&page=$page';
  }

  static const clients = '$baseUrl/clients';
  static String getSingleClient(String id) {
    return '$baseUrl/clients/$id';
  }

  static String getClients(String page, {String name = '', String phone = ''}) {
    String base = '$clients';
    // if (name != '') base += '&filters[name]=%$name%';
    // if (phone != '') base += '&filters[phone]=%$phone%';
    // print(base);
    return base;
  }

  static String updateClient(String id) {
    return '$clients/$id';
  }

  static String deleteClient(String id) {
    return '$clients/$id';
  }

  static const tasks = '$baseUrl/tasks';
  static String singleTask(String id) {
    return '$baseUrl/tasks/$id';
  }

  static const getCategories = '$baseUrl/client-categories';
  static const getTitles = '$baseUrl/client-titles';
  static const getTaskCategories = '$baseUrl/task-categories';
  static const getRecieverUsers = '$baseUrl/recieve-task-users';

  static const getMessageTemplates = '$baseUrl/message-templates';
  static const sendMessage = '$baseUrl/send-sms-client';

  static String deleteTask(String id) {
    return '$tasks/$id';
  }

  static const getArticles = '$baseUrl/article-categories';
  static String getUserTasks(String id, String type, String page) {
    return '$baseUrl/tasks?per_page=10&rel_id=$id&rel_type=$type&page=$page';
  }

  static const addFile = '$baseUrl/file';

  static String getUserTransactions(String id, String page) {
    return '$baseUrl/transactions?per_page=10&client_id=$id&page=$page';
  }

  static String getTransactionDetails(String id) {
    return '$baseUrl/transactions/$id';
  }

  static String deleteTransaction(String id) {
    return '$baseUrl/transactions/$id';
  }

  static const taskStatuses = '$baseUrl/task-statuses';
}
