import { BaseConstants, ToastUtil } from 'base';

@Component
export struct GridItemComponent {
  title: string = ''
  itemClick?: ((title: string) => void);

  build() {
    Column() {
      Image($r('app.media.search'))
        .width(30)
        .height(30)
      Blank().height(10)
      Text(this.title)
    }
    .height(160)
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