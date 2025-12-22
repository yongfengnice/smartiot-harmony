@Component
export struct CreateAddDialog {
  @Prop titleList: string[]
  itemClick?: (title: string, index: number) => void

  build() {

    Column() {
      ForEach(this.titleList, (title: string, index) => {
        Text(title)
          .font({
            size: 14,
            weight: 400,
            family: 'PingFang SC'
          })
          .padding({
            top: 10,
            bottom: 10
          })
          .width(90)
          .fontColor(Color.Black)
          .lineHeight(20)
          .border({
            style: BorderStyle.Solid,
            width: { bottom: this.titleList.length == index + 1 ? 0 : 1 },
            color: '#f5f5f5'
          })
          .onClick(() => {
            this.itemClick?.(title, index)
          })
      })
    }
    .padding({
      left: 10,
      right: 10
    }).alignItems(HorizontalAlign.Start)

  }
}