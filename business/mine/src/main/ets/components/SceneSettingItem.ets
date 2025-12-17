@Component
export struct SceneSettingItem {
  @Require icon: Resource
  @Require title: string
  subTitle: string = ''
  isUnread: boolean = false

  build() {
    Column() {
      Row() {
        Image(this.icon)
          .width(24)
          .height(24)
          .margin({
            left: 16,
            right: 12
          })
        Text(this.title)
          .layoutWeight(1)
          .fontColor(Color.Black)
          .fontSize(14)
        if (this.isUnread) {
          Text(this.subTitle)
            .width(20)
            .height(20)
            .borderRadius(10)
            .backgroundColor(Color.Red)
            .fontSize(10)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
        } else {
          Text(this.subTitle)
        }
        Image($r('app.media.ic_arrow'))
          .width(12)
          .height(12)
          .margin({
            left: 2,
            right: 16
          })
      }.height(56)
    }
  }
}