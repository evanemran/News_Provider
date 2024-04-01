abstract class ResponseListener<T> {
  void onSuccess(T data, String message);
  void onError(String message);
}