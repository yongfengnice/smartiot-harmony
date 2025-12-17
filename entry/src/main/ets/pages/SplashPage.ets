import { CommonConstants, UserInfo } from 'common';
import { SplashViewModel } from '../viewmodel/SplashViewModel';

@Entry
@Component
struct SplashPage {
  private viewModel: SplashViewModel = new SplashViewModel();
  //StorageProp单向，相当于只读不可写，修改的结果不会同步到persistent
  @StorageProp(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();

  aboutToAppear(): void {
    setTimeout(() => {
      this.viewModel.checkLoginState(this.getUIContext(), this.userInfo)
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