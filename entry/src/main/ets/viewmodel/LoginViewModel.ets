import { Logger } from 'base';
import { HomeViewModel, PageConstants } from 'common';

export class LoginViewModel extends HomeViewModel {
  //跳到主页
  jumpToMainPage(context: UIContext) {
    context.getRouter().replaceUrl({
      url: PageConstants.MainPage
    }).catch(() => {
      Logger.error('LoginPage', '登录完成之后跳转到主页失败')
    })
  }

  //
  isNameOrPwdEmpty(username: string, password: string): boolean {
    return username.length <= 0 || password.length <= 0
  }
}