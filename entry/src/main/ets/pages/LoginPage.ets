import { BaseConstants, ProcessUtil, ToastUtil } from 'base';
import { common } from '@kit.AbilityKit';
import { CommonConstants, UserInfo } from 'common';
import { LoginViewModel } from '../viewmodel/LoginViewModel';

@Entry
@Component
struct LoginPage {
  private backPressTime: number = 0;
  //StorageLink双向驱动，修改了数据会自动同步到persistent
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();
  @State username: string = ''
  @State password: string = ''
  @State isAgree: boolean = false;
  private viewModel = new LoginViewModel()

  build() {
    Column() {
      Text(
        '账号密码登录'
      )
        .fontWeight(FontWeight.Bold)
        .width(BaseConstants.MATCH_PARENT)
        .margin({ top: 160, bottom: 60 })
        .fontSize(26)
        .fontColor(0x000000)
      this.buildTextInput('请输入手机号', false, (value: string) => {
        this.username = value
      })
      this.buildTextLine()
      this.buildTextInput('请输入密码', true, (value: string) => {
        this.password = value
      })
      this.buildTextLine()

      Row() {
        Checkbox(
        ).select(this.isAgree)
          .onChange((value) => {
            this.isAgree = value
          })
        Text() {
          Span('我已阅读并同意')
          Span('《软件许可及服务协议》')
            .fontColor('#007AFF').decoration({ type: TextDecorationType.Underline })
            .onClick(() => {
              ToastUtil.showToast('《软件许可及服务协议》')
            })
          Span('和')
          Span('《隐私政策》')
            .fontColor('#007AFF').decoration({ type: TextDecorationType.Underline }).onClick(() => {
            ToastUtil.showToast('《隐私政策》')
          })
        }
        .fontSize(12)
        .margin({ left: 6 })
        .fontSize(12)
      }.width(BaseConstants.MATCH_PARENT)

      Button('模拟登录')
        .onClick(() => {
          if (this.viewModel.isNameOrPwdEmpty(this.username, this.password)) {
            ToastUtil.showToast('请输入用户名或者密码')
            return
          }
          if (!this.isAgree) {
            ToastUtil.showToast('请先阅读并同意隐私协议')
            return
          }
          //修改对象的字段，也会自动同步到persistent
          this.userInfo.username = this.username
          this.userInfo.password = this.password
          //下面的写法修改对象的引起，也会可以也同样会自动同步到persistent
          // this.userInfo = {
          //   username: 'zh',
          //   password: '123'
          // }
          this.viewModel.jumpToMainPage(this.getUIContext())
        })
        .backgroundColor(this.viewModel.isNameOrPwdEmpty(this.username, this.password) ? Color.Grey : Color.Blue)
        .width(BaseConstants.MATCH_PARENT)
        .margin({ top: 20 })
        .height(50)
    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
    .padding({ left: 12, right: 12 })
  }

  @Builder
  buildTextLine() {
    Divider()
      .strokeWidth(1)
      .width(BaseConstants.MATCH_PARENT)
      .color(Color.Gray)
      .margin({ bottom: 20 })
  }

  @Builder
  buildTextInput(placeholder: string, isPwd: boolean, callback: EditableTextOnChangeCallback) {
    TextInput({ placeholder: placeholder })
      .type(isPwd ? InputType.Password : InputType.PhoneNumber)
      .padding({ left: 0, right: 0 })
      .width(BaseConstants.MATCH_PARENT)
      .margin({ top: 20 })
      .height(50)
      .fontSize(16)
      .backgroundColor(Color.Transparent)
      .onChange(callback)
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

