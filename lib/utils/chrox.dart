typedef Middleware = Future Function(Context ctx, Function() next);

class Context<T, K> {
  final T request;
  final K response;

  Context({this.request, this.response});
}

class Chrox<T extends Context> {
  final List<Middleware> _middlewares = [];

  Chrox use(Middleware middleware) {
    _middlewares.add(middleware);
    return this;
  }

  Chrox useBatch(List<Middleware> middlewares) {
    middlewares.forEach(use);
    return this;
  }

  Future<T> fire(T ctx) async {
    final fn = compose(_middlewares);
    try {
      await fn(ctx);
    } catch (err) {
      print('Middleware function invoke error: $err');
    }
    return ctx;
  }
}

Function compose(List<Middleware> middlewares) {
  return (Context ctx) {
    int index = -1;

    Future<void> dispatch() async {
      index++;
      if (index < middlewares.length) {
        final middleware = middlewares[index];
        await middleware(ctx, dispatch);
      }
    }

    return dispatch();
  };
}
