import { BaseConstants, GlobalInfoModel, Logger, StorageKey } from 'base';
import { CommonConstants, PageConstants, UserInfo } from 'common';
import { MineThirdPartyContent } from '../components/MineThirdPartyContent';
import { SceneManagerItem } from '../components/SceneManagerItem';
import { SceneSettingItem } from '../components/SceneSettingItem';

@Component
export struct MinePage {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Blank()
        .height(this.globalInfoModel.statusBarHeight)
        .color(Color.White)
      Scroll(this.scroller) {
        Column() {
          this.buildMimeAvatar()
          this.buildSceneManager()
          this.buildSettingItems()
          MineThirdPartyContent()
          Blank().height(60)

          // Text("退出登录")
          //   .onClick(() => {
          //     this.userInfo = {
          //       username: '',
          //       password: ''
          //     }
          //     this.getUIContext().getRouter().replaceUrl({
          //       url: PageConstants.LoginPage
          //     }).catch(() => {
          //       Logger.error('LoginPage', '退出登录跳转到登录失败')
          //     })
          //   })
          //   .width(BaseConstants.MATCH_PARENT)
        }

        //.height(BaseConstants.MATCH_PARENT) 不能给Column设置高度，否则滚动不了，查了很久真是坑死人。。。
      }
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .scrollBar(BarState.Off)
      .height('100%')
      .width('100%')
      .backgroundColor($r('sys.color.background_secondary'))
    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
    .background(Color.Grey)
  }

  @Builder
  buildMimeAvatar() {
    Column() {

      Image($r('app.media.ic_manager_login'))
        .width(80)
        .height(80)
        .margin({
          top: 40,
          bottom: 10
        })

      Text('测试用户yy4272')
        .fontColor(Color.Black)
        .fontSize(20)

      Text('177****4272')
        .fontColor(Color.Grey)
        .fontSize(16)
        .margin({
          top: 6,
          bottom: 20
        })

    }
    .backgroundColor(Color.White)
    .width(BaseConstants.MATCH_PARENT)
    .border({
      radius: {
        bottomLeft: 20,
        bottomRight: 20,
      }
    })
  }

  @Builder
  buildSceneManager() {

    Column() {
      Row() {
        Image($r('app.media.ic_mine_scenario'))
          .width(24)
          .height(24)
          .margin({
            left: 16,
            right: 12
          })

        Text('单元测试场景')
          .fontColor(Color.Black)
          .fontSize(16)

        Image($r('app.media.ic_edit_expand'))
          .width(16)
          .height(16)
          .fillColor(Color.Black)
          .margin({
            left: 4
          })

        Blank()
          .layoutWeight(1)

        Text('管理器')
          .fontSize(12)
          .border({
            radius: 20,
            color: $r('app.color.color_main'),
            width: 1
          })
          .fontColor($r('app.color.color_main'))
          .padding({
            left: 10,
            top: 4,
            right: 10,
            bottom: 4
          })
          .margin({
            right: 16
          })
      }
      .margin({
        top: 12
      })

      Row() {
        SceneManagerItem({
          icon: $r('app.media.ic_mine_scenario_manager'),
          title: '场景管理'
        })
          .layoutWeight(1)
          .margin({
            left: 16,
            top: 12,
            right: 6,
            bottom: 12
          })

        SceneManagerItem({
          icon: $r('app.media.ic_mine_device_firms'),
          title: '固件升级'
        })
          .layoutWeight(1)
          .margin({
            left: 6,
            top: 12,
            right: 16,
            bottom: 12
          })

      }
    }
    .backgroundColor(Color.White)
    .margin(12)
    .border({
      radius: 12
    })
  }

  @Builder
  buildSettingItems() {

    Column() {
      SceneSettingItem({
        icon: $r('app.media.ic_mine_message'),
        title: '消息通知',
        subTitle: '99+',
        isUnread: true
      })
      Divider()
        .vertical(false)
        .color($r('app.color.color_grey'))
        .margin({
          left: 50,
          right: 16
        })

      SceneSettingItem({
        icon: $r('app.media.ic_mine_help'),
        title: '帮助&反馈'
      })

      Divider()
        .vertical(false)
        .color($r('app.color.color_grey'))
        .margin({
          left: 50,
          right: 16
        })
      SceneSettingItem({
        icon: $r('app.media.ic_mine_about_us'),
        title: '关于我们',
        subTitle: '1.0.7+8'
      })

      Divider()
        .vertical(false)
        .color($r('app.color.color_grey'))
        .margin({
          left: 50,
          right: 16
        })
      SceneSettingItem({
        icon: $r('app.media.ic_mine_setting'),
        title: '系统设置',
        subTitle: '开发'
      })

    }
    .backgroundColor(Color.White)
    .margin({
      left: 12,
      right: 12
    })
    .border({
      radius: 12
    })
  }
}


