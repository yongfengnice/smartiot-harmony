@Builder
export function SearchPageBuilder() {
  NavDestination() {
    SearchPage()
  }
}

@Component
export struct SearchPage {
  @State message: string = 'SearchPage';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Welcome';
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}