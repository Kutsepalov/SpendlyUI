class SpendlyResponse<T> {
  T? data;

  bool hasError = false;
  String? error;

  SpendlyResponse(this.data);

  SpendlyResponse.error(this.error) {
    hasError = true;
  }
}
