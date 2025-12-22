import { BaseConstants } from 'base'
import { DeviceSubTabContent } from './DeviceSubTabContent'

@Component
export struct DeviceTabContent {
  @State private deviceList: string[] = ['全部', '网关主机', '交互面板', '能源插座', '安防传感', '灯具照明',
    '窗帘遮阳', '智能暖通', '家电控制', '影音娱乐', '能源计量', '智慧家电',]

  build() {
    Column() {

      Tabs() {
        ForEach(this.deviceList, (item: string, index: number) => {
          TabContent() {
            Column() {
              Blank().height(1)
              DeviceSubTabContent({ title: item })
              Blank().layoutWeight(1)
            }
            .height('100%')
            .backgroundColor($r('app.color.color_grey'))
          }.tabBar(SubTabBarStyle.of(item)
            .selectedMode(SelectedMode.INDICATOR)
            .board({ borderRadius: 20 })
          )
        })
      }
      .height('100%')
      .backgroundColor(Color.White)
      .barMode(this.deviceList.length > 5 ? BarMode.Scrollable : BarMode.Fixed)

    }.width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
  }
}