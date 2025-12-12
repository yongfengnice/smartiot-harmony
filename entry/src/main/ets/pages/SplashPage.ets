import { CommonConstants, UserInfo } from 'common';
import { Logger, ToastUtil } from 'base';
import { SplashViewModel } from '../viewmodel/SplashViewModel';
import { PageConstant } from '../constants/PageConstant';

@Entry
@Component
struct SplashPage {
  private viewModel: SplashViewModel = new SplashViewModel();
  //StorageProp单向，相当于只读不可写，修改的结果不会同步到persistent
  @StorageProp(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();

  aboutToAppear(): void {
    setTimeout(() => {
      if (this.userInfo == undefined || this.userInfo.username.trim() == '') {
        ToastUtil.showToast('用户未登录')
        Logger.debug('SplashPage', '用户未登录')
        //使用router跳转的页面，需要resource/base/profile/main_pages.json里，并且页面需要标记为@Entry
        this.getUIContext().getRouter().replaceUrl({
          url: PageConstant.LoginPage
        }).catch(() => {
          Logger.debug('SplashPage', '打开登录页面失败')
        })
      } else {
        ToastUtil.showToast('用户已经登录')
        Logger.debug('SplashPage', '用户已经登录')
        this.getUIContext().getRouter().replaceUrl({
          url: PageConstant.MainPage
        }).catch(() => {
          Logger.debug('SplashPage', '打开登录页面失败')
        })
      }
    }, 3000)

  }

  build() {
    Stack() {
      Image($r('app.media.startIcon'))
        .width('200')
        .height('200')
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height('100%')
  }
}