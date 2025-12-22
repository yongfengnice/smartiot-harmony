import { BaseConstants, Logger, ProcessUtil, ToastUtil } from 'base';
import { common } from '@kit.AbilityKit';
import { ApiService, CommonConstants, UserInfo } from 'common';
import { LoginViewModel } from '../viewmodel/LoginViewModel';
import { LoginRequest } from 'common/src/main/ets/bean/Login';

@Entry
@Component
struct LoginPage {
  private backPressTime: number = 0;
  //StorageLink双向驱动，修改了数据会自动同步到persistent
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();
  @State username: string = ''
  @State password: string = ''
  @State isAgree: boolean = false;
  @State isMock: boolean = false;
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


      Row() {
        Checkbox(
        ).select(this.isMock)
          .onChange((value) => {
            this.isMock = value
          })
        Text() {
          Span('是否模拟登录，如果是就直接进来，不请求接口')
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
          if (this.isMock) {
            ToastUtil.showToast('登录成功')
            this.userInfo.username = this.username
            this.userInfo.phone = this.username
            this.userInfo.password = this.password
            this.viewModel.jumpToMainPage(this.getUIContext())
            return
          }

          let loginRequest = {
            imei: '1104a897939811e0089',
            push_device_token: '1104a897939811e0089',
            package_id: 'com.jinpeng.smart.iot.development',
            app_phonenumber: '17724254272',
            app_login_pass: 'defe12aad396f90e6b179c239de260d4' //123456ab的md5值
          } as LoginRequest
          ApiService.userLogin(loginRequest).then((value) => {
            Logger.debug('userLogin', 'userLogin:' + value)
            if (value.resultCode == 0 && value.response_obj != null && value.response_obj != undefined) {
              ToastUtil.showToast('登录成功')
              this.userInfo.username = value.response_obj.app_nickname
              this.userInfo.phone = value.response_obj.app_phonenumber
              this.userInfo.password = value.response_obj.password
              this.viewModel.jumpToMainPage(this.getUIContext())
            } else {
              if (value != null && value != undefined && value.description != null && value.description != undefined) {
                ToastUtil.showToast(value.description)
              } else {
                ToastUtil.showToast('登录失败1')
              }
            }
          }).catch(() => {
            ToastUtil.showToast('登录失败2')
          })

          // //修改对象的字段，也会自动同步到persistent
          // this.userInfo.username = this.username
          // this.userInfo.password = this.password
          // //下面的写法修改对象的引起，也会可以也同样会自动同步到persistent
          // // this.userInfo = {
          // //   username: 'zh',
          // //   password: '123'
          // // }
          // this.viewModel.jumpToMainPage(this.getUIContext())
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

