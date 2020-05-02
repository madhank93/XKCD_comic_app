import 'package:fluttermvpillustrativeapp/data/dependency_injection.dart';
import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';

abstract class XKCDViewContract {
  void onLoadComplete(List<XKCD> items);
  void onLoadError();
}

class XKCDPresenter {
  XKCDViewContract _view;
  XKCDRepo _repository;

  XKCDPresenter(this._view) {
    _repository = Injector().xkcdRepository;
  }

  void loadComicPost() {
    _repository
        .fetchComicPost()
        .then((value) => _view.onLoadComplete(value))
        .catchError((onError) => _view.onLoadError());
  }
}
