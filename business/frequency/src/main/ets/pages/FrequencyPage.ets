import { BaseConstants, GlobalInfoModel, Logger, StorageKey } from 'base';
import { FrequencyViewModel } from '../viewmodel/FrequencyViewModel';

@Component
export struct FrequencyPage {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  private frequencyViewModel = new FrequencyViewModel()
  @State currentIndex: number = 0;
  @State titleOpacity: number = 1

  build() {
    Column() {
      Blank()
        .height(this.globalInfoModel.statusBarHeight)
        .color(Color.White)
      // this.buildTitle()
      this.buildBody()
    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
    .backgroundColor($r('app.color.color_grey'))
  }

  @Builder
  buildBody() {

    Stack({ alignContent: Alignment.Top }) {
      Scroll(this.frequencyViewModel.scrollerForScroll) {
        Column() {
          Image($r("app.media.banner"))
            .width(BaseConstants.MATCH_PARENT)
            .height(this.frequencyViewModel.maxScrollY)
            .borderRadius(20)
            .padding({
              left: 12,
              right: 12
            })
            .margin({
              top: this.frequencyViewModel.titleHeight + 8
            })
          Tabs() {
            this.listBuilder('促销活动', 0)
            this.listBuilder('行程服务', 1)
          }
          .barMode(BarMode.Scrollable)
          .onAnimationStart((_index: number, targetIndex: number, _event: TabsAnimationEvent) => {
            this.currentIndex = targetIndex;
          })
          .onGestureSwipe((index, extraInfo) => {
            Logger.debug('onGestureSwipe',
              "currentOffset:" + extraInfo.currentOffset + ",targetOffset:" + extraInfo.targetOffset)
          })
        }
      }
      .scrollBar(BarState.Off)
      .width(BaseConstants.MATCH_PARENT)
      .height(BaseConstants.MATCH_PARENT)
      .onDidScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
        this.frequencyViewModel.scrollY += yOffset;
        if (this.frequencyViewModel.scrollY >= this.frequencyViewModel.maxScrollY) {
          this.frequencyViewModel.scrollY = this.frequencyViewModel.maxScrollY
        } else if (this.frequencyViewModel.scrollY < 1) {
          this.frequencyViewModel.scrollY = 0
        }
        let opacity = 1 - this.frequencyViewModel.scrollY / this.frequencyViewModel.maxScrollY
        if (this.titleOpacity != opacity) {
          this.titleOpacity = opacity
        }
        Logger.debug('onDidScroll', 'scrollY:' + this.frequencyViewModel.scrollY)
      })

      this.buildTitle()
    }
    .width(BaseConstants.MATCH_PARENT)
    .height("calc(100% - 40vp)") //"calc(100% - 60vp)"
  }

  @Builder
  listBuilder(tabName: ResourceStr, index: number) {
    TabContent() {
      List({ space: 12, scroller: this.frequencyViewModel.scrollerForList }) {
        ForEach(this.frequencyViewModel.listArr, (item: string) => {
          ListItem() {
            Row() {
              Text(tabName)
                .fontSize(16)
                .fontWeight(500)
              Text(item)
                .fontSize(16)
                .fontWeight(500)
            }
            .padding({ left: 12 })
            .backgroundColor(Color.White)
            .width(BaseConstants.MATCH_PARENT)
            .height(BaseConstants.MATCH_PARENT)
            .borderRadius(12)

          }
          .width(BaseConstants.MATCH_PARENT)
          .height(56)
        }, (item: string) => JSON.stringify(item))
      }
      .padding({
        left: 12,
        right: 12,
        bottom: 12
      })
      .width(BaseConstants.MATCH_PARENT)
      .height(BaseConstants.MATCH_PARENT)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
    }.tabBar(SubTabBarStyle.of(tabName)
      .selectedMode(SelectedMode.INDICATOR)
      .padding({ left: 20, right: 20 })
    )

    // .tabBar(this.tabBuilder(index, tabName))
  }

  @Builder
  tabBuilder(index: number, name: ResourceStr) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#182431')
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .margin({
          top: 6,
          bottom: 6
        })
    }.backgroundColor(Color.Transparent)
  }

  @Builder
  buildTitle() {
    Row() {
      Text('单元测试场所')
      Blank().layoutWeight(1)
      Image($r('app.media.search'))
        .width(20)
        .height(20)
        .onClick(() => {
          this.frequencyViewModel.jumpToSearchPage()
        })
      Blank().width(12)
      Image($r('app.media.create_add'))
        .width(20)
        .height(20)
    }
    .padding({
      left: 12,
      right: 12
    })
    .height(this.frequencyViewModel.titleHeight)
    .backgroundColor(Color.White)
    .opacity(this.titleOpacity)
    .visibility(this.titleOpacity > 0.12 ? Visibility.Visible : Visibility.None)
  }
}
