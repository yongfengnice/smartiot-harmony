import { BaseConstants } from 'base'

@Component
export struct MineThirdPartyContent {
  private thirdPartyList: ThirdPartyModel[] = [
    {
      icon: $r('app.media.ic_btn_scene_control'),
      title: '情景管理'
    },
    {
      icon: $r('app.media.ic_btn_scene_control'),
      title: '情景管理器'
    },
    {
      icon: $r('app.media.ic_btn_scene_control'),
      title: '桌面'
    },
    {
      icon: $r('app.media.ic_btn_voice_baidu_control'),
      title: '小度家居版'
    },
    {
      icon: $r('app.media.ic_btn_voice_baidu_control'),
      title: '小度酒店版'
    },
  ]

  build() {
    Column() {
      this.buildTitle()
      this.buildBody()
    }
    .backgroundColor(Color.White)
    .margin(12)
    .border({
      radius: 12
    })
  }

  @Builder
  buildTitle() {

    Column() {
      Row() {
        Image($r('app.media.ic_mine_scenario'))
          .width(24)
          .height(24)
          .margin({
            left: 16,
            right: 12
          })

        Text('语音等第三方服务')
          .fontColor(Color.Black)
          .fontSize(16)
          .layoutWeight(1)
      }
      .margin({
        top: 12
      })
    }
  }

  @Builder
  buildBody() {
    List() {
      ForEach(this.thirdPartyList, (item: ThirdPartyModel, index) => {
        ListItem() {
          Column() {
            Image(item.icon)
              .width(60)
              .height(60)
              .margin({
                left: 20,
                top: 10,
                right: 20,
                bottom: 12
              })
            Text(item.title)
              .fontColor(Color.Black)
              .fontSize(14)
          }
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .width(BaseConstants.MATCH_PARENT)
    .height(100)
    .margin(12)
  }
}

interface ThirdPartyModel {
  icon: Resource | undefined;
  title: ResourceStr
}