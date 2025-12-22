import { BaseConstants } from 'base'
import { SceneSubTabContent } from './SceneSubTabContent'

@Component
export struct SceneTabContent {
  @State private sceneList: string[] = ['场所1', '一个有设备的场所', '场所2', '办公室A区', '场所3', '会客场所',
    '场所4', '未分配', '场所6', '会所中心', '场所8', '场所9', '场所12', '场所13']

  build() {
    Column() {

      Tabs() {
        ForEach(this.sceneList, (item: string, index: number) => {
          TabContent() {
            Column() {
              Blank().height(1)
              SceneSubTabContent({ title: item })
              Blank().layoutWeight(1)
            }
            .height('100%')
            .backgroundColor($r('app.color.color_grey'))
          }.tabBar(SubTabBarStyle.of(item)
            .selectedMode(SelectedMode.INDICATOR)
            //.board({ borderRadius: 20 }) SelectedMode.BOARD时才生效，设置圆角
          )
        })
      }
      .height('100%')
      .backgroundColor(Color.White)
      .barMode(this.sceneList.length > 5 ? BarMode.Scrollable : BarMode.Fixed)

    }.width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
  }
}