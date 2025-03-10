import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/widgets/error_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';

///
///
///
class SilentFutureBuilder<T> extends SafeFutureBuilder<T> {
  ///
  ///
  ///
  SilentFutureBuilder({
    required Widget Function(BuildContext context, T data) builder,
    Future<T>? future,
    T? initialData,
    Key? key,
  }) : super(
          builder: builder,
          future: future,
          initialData: initialData,
          onWait: (_, __) => FollyUtils.nothing,
          onError: (Object? error, StackTrace? stackTrace, _) {
            if (kDebugMode) {
              print(error);
              print(stackTrace);
            }
            return FollyUtils.nothing;
          },
          key: key,
        );
}

///
///
///
class SafeFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final T? initialData;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(
    Object? error,
    StackTrace? stackTrace,
    Widget child,
  )? onError;
  final Widget Function(
    ConnectionState connectionState,
    Widget child,
  )? onWait;
  final String? waitingMessage;

  ///
  ///
  ///
  const SafeFutureBuilder({
    required this.builder,
    this.future,
    this.initialData,
    this.onError,
    this.onWait,
    this.waitingMessage,
    Key? key,
  })  : assert(onWait == null || waitingMessage == null,
            'onWait or waitingMessage must be null.'),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Widget child = ErrorMessage(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );

          if (onError != null) {
            return onError!(snapshot.error, snapshot.stackTrace, child);
          } else {
            return child;
          }
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data!);
        }

        Widget child = WaitingMessage(message: waitingMessage);

        if (onWait != null) {
          return onWait!(snapshot.connectionState, child);
        } else {
          return child;
        }
      },
    );
  }
}

///
///
///
class SilentStreamBuilder<T> extends SafeStreamBuilder<T> {
  ///
  ///
  ///
  SilentStreamBuilder({
    required Widget Function(BuildContext context, T data) builder,
    Stream<T>? stream,
    T? initialData,
    Key? key,
  }) : super(
          builder: builder,
          stream: stream,
          initialData: initialData,
          onWait: (_, __) => FollyUtils.nothing,
          onError: (Object? error, StackTrace? stackTrace, _) {
            if (kDebugMode) {
              print(error);
              print(stackTrace);
            }
            return FollyUtils.nothing;
          },
          key: key,
        );
}

///
///
///
class SafeStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final T? initialData;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(
    Object? error,
    StackTrace? stackTrace,
    Widget child,
  )? onError;
  final Widget Function(
    ConnectionState connectionState,
    Widget child,
  )? onWait;
  final String? waitingMessage;

  ///
  ///
  ///
  const SafeStreamBuilder({
    required this.builder,
    this.stream,
    this.initialData,
    this.onError,
    this.onWait,
    this.waitingMessage,
    Key? key,
  })  : assert(onWait == null || waitingMessage == null,
            'onWait or waitingMessage must be null.'),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Widget child = ErrorMessage(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );

          if (onError != null) {
            return onError!(snapshot.error, snapshot.stackTrace, child);
          } else {
            return child;
          }
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data!);
        }

        Widget child = WaitingMessage(message: waitingMessage);

        if (onWait != null) {
          return onWait!(snapshot.connectionState, child);
        } else {
          return child;
        }
      },
    );
  }
}
