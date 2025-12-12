import { BaseConstants, Logger, ProcessUtil, ToastUtil } from 'base';
import { common } from '@kit.AbilityKit';
import { CommonConstants, UserInfo } from 'common';
import { PageConstant } from '../constants/PageConstant';

@Builder
export function LoginPageBuilder() {
  LoginPage()
}


@Entry
@Component
struct LoginPage {
  private backPressTime: number = 0;
  //StorageLink双向驱动，修改了数据会自动同步到persistent
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();

  build() {

    Column() {
      Row() {
        Text(
          '这是登录页面'
        )
      }

      Text("模拟登录")
        .onClick(() => {
          //修改对象的字段，也会自动同步到persistent
          this.userInfo.username = 'zh'
          this.userInfo.password = '123'
          //下面的写法修改对象的引起，也会可以也同样会自动同步到persistent
          // this.userInfo = {
          //   username: 'zh',
          //   password: '123'
          // }
          this.getUIContext().getRouter().replaceUrl({
            url: PageConstant.MainPage
          }).catch(() => {
            Logger.error('LoginPage', '登录完成之后跳转到主页失败')
          })
        })
        .width(BaseConstants.MATCH_PARENT)
        .height(BaseConstants.MATCH_PARENT)
    }.background(0xff0000)
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
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