import { common } from '@kit.AbilityKit';
import { BaseConstants, Logger, ProcessUtil, ToastUtil } from 'base';
import { CommonConstants, UserInfo } from 'common';
import { PageConstant } from '../constants/PageConstant';

@Builder
export function MainPageBuilder() {
  MainPage()
}

@Entry
@Component
struct MainPage {
  private backPressTime: number = 0;
  @State message: string = 'Hello World';
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })

      Text("退出登录")
        .onClick(() => {
          this.userInfo = {
            username: '',
            password: ''
          }
          this.getUIContext().getRouter().replaceUrl({
            url: PageConstant.LoginPage
          }).catch(() => {
            Logger.error('LoginPage', '退出登录跳转到登录失败')
          })
        })
        .width(BaseConstants.MATCH_PARENT)
        .height(BaseConstants.MATCH_PARENT)
    }
    .height('100%')
    .width('100%')
  }

  onBackPress(): boolean | void {
    const newTime = new Date().getTime();
    if (this.backPressTime && newTime - this.backPressTime < CommonConstants.PRESS_TIME) {
      ProcessUtil.terminateAbility(this.getUIContext().getHostContext() as common.UIAbilityContext);
      return true;
    }
    this.backPressTime = newTime;
    ToastUtil.showToast($r('app.string.back_toast'));
    return true;
  }
}