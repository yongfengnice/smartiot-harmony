import { BaseConstants, ToastUtil } from 'base';

@Component
export struct GridItemComponent {
  title: string = ''
  itemClick?: ((title: string) => void);

  build() {
    Column() {
      Image($r('app.media.create_add'))
        .width(30)
        .height(30)
      Blank().height(10)
      Text(this.title)
    }
    .height(100)
    .width(BaseConstants.MATCH_PARENT)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      ToastUtil.showToast('click:' + this.title)
      this.itemClick?.(this.title)
    })
    .borderRadius(10)
  }
}