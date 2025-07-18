/// Simple Result type for handling success and failure cases
sealed class Result<T> {
  const Result();
}

/// Success case containing the result data
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Failure case containing the error
class Failed<T> extends Result<T> {
  final String message;
  final Exception? exception;
  
  const Failed(this.message, [this.exception]);
}
