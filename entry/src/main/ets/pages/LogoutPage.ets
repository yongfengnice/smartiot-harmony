import { BaseConstants, GlobalInfoModel, Logger, StorageKey, ToastUtil } from 'base';
import { CommonConstants, PageConstants, UserInfo } from 'common';
import { LogoutViewModel } from '../viewmodel/LogoutViewModel';

@Builder
export function LogoutPageBuilder() {
  NavDestination() {
    LogoutPage()
  }.hideTitleBar(true)
}

@Component
struct LogoutPage {
  //StorageLink双向驱动，修改了数据会自动同步到persistent
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  private logoutViewModel = new LogoutViewModel()

  build() {

    Column() {
      Blank()
        .height(this.globalInfoModel.statusBarHeight)
        .color(Color.White)
      this.buildSearchTitle()
      Text('退出登录')
        .padding(10)
        .margin({ top: 100 })
        .backgroundColor(Color.Orange)
        .onClick(() => {
          this.userInfo.username = ''
          this.userInfo.password = ''
          ToastUtil.showToast('退出登录')
          this.logoutViewModel.pageContext.popPage()
          this.getUIContext().getRouter().replaceUrl({
            url: PageConstants.LoginPage
          }).catch(() => {
            Logger.debug('LogoutPage', '打开登录页面失败')
          })
        })

    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
  }

  @Builder
  buildSearchTitle() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(20)
        .height(20)
        .onClick(() => {
          this.logoutViewModel.jumpBack()
        })
      Blank().layoutWeight(1)
      Text('退出登录页面')
      Blank().layoutWeight(1)
      Blank().width(20)
    }.justifyContent(FlexAlign.Start)
    .backgroundColor(Color.White)
    .padding(12)
  }
}