import { Logger, ToastUtil } from 'base';
import { HomeViewModel, PageConstants, UserInfo } from 'common';

export class SplashViewModel extends HomeViewModel {
  //检查登录状态
  checkLoginState(context: UIContext, userInfo: UserInfo) {
    if (userInfo == undefined || userInfo.username.trim() == '') {
      this.jumpToLoginPage(context)
    } else {
      this.jumpToMainPage(context)
    }
  }

  //跳到登录页面
  jumpToLoginPage(context: UIContext) {
    ToastUtil.showToast('用户未登录')
    Logger.debug('SplashPage', '用户未登录')
    //使用router跳转的页面，需要resource/base/profile/main_pages.json里，并且页面需要标记为@Entry
    context.getRouter().replaceUrl({
      url: PageConstants.LoginPage
    }).catch(() => {
      Logger.debug('SplashPage', '打开登录页面失败')
    })
  }

  //跳到主页面
  jumpToMainPage(context: UIContext) {
    ToastUtil.showToast('用户已经登录')
    Logger.debug('SplashPage', '用户已经登录')
    context.getRouter().replaceUrl({
      url: PageConstants.MainPage
    }).catch(() => {
      Logger.debug('SplashPage', '打开登录页面失败')
    })
  }
}
