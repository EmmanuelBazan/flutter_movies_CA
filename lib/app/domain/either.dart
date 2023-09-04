class Either<Left, Right> {
  final Left? _left;
  final Right? _right;
  final bool isLeft;

  Either._(this._left, this._right, this.isLeft);

  factory Either.left(Left failure) {
    return Either._(failure, null, true);
  }

  factory Either.right(Right value) {
    return Either._(null, value, false);
  }

  T when<T>(
    Function left,
    Function right,
  ) {
    if (isLeft) {
      return left(_left!);
    } else {
      return right(_right!);
    }
  }
}
