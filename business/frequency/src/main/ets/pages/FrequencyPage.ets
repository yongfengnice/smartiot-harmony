import { FrequencyViewModel } from "../viewmodel/FrequencyViewModel";

@Component
export struct FrequencyPage {
  @State message: string = 'FrequencyPage';

  private frequencyViewModel = new FrequencyViewModel()

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Welcome';
          })
        Text('点击进去搜索页面')
          .fontSize(16)
          .onClick(() => {
            this.frequencyViewModel.jumpToSearchPage()
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
