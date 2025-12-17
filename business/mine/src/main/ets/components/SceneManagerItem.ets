@Component
export struct SceneManagerItem {
  @Require icon: Resource
  @Require title: string

  build() {

    Row() {
      Image(this.icon)
        .width(40)
        .height(40)
        .margin({
          left: 12,
          right: 12
        })
      Text(this.title)
        .fontColor(Color.Black)
        .fontSize(14)
    }
    .backgroundColor($r('app.color.color_grey'))
    .height(60)
    .width('100%')
    .border({
      radius: 12
    })
  }
}