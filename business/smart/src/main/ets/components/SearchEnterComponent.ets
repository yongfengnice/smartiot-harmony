import { BaseConstants } from 'base'
import { CommonConstants } from 'common'

@Component
export struct SearchEnterComponent {
  event: (event: ClickEvent) => void = () => {
  }

  build() {
    Row() {
      Row() {
        Image($r('app.media.search'))
          .width(16)
          .height(16)
        Text('搜索')
          .fontSize(13)
          .fontColor(Color.Grey)
          .margin({
            left: 6
          })
      }
      .padding(6)
      .width(BaseConstants.MATCH_PARENT)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({
        color: Color.Grey,
        width: 1,
        radius: 6
      })
      .onClick(this.event)
    }
    .padding(10)
    .width(BaseConstants.MATCH_PARENT)
    .height(CommonConstants.SearchButton_HEIGHT)
    .borderRadius({
      bottomLeft: 20,
      bottomRight: 20
    })
    .margin({
      bottom: CommonConstants.SegmentButton_Margin
    })
    .backgroundColor(Color.White)
  }
}