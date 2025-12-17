import { CategoryPage } from 'category';
import { CommonConstants, UserInfo } from 'common';
import { FrequencyPage } from 'frequency';
import { MinePage } from 'mine';
import { SmartPage } from 'smart';
import { CustomTabBar } from '../component/CustomTabBar';
import { MainViewModel } from '../viewmodel/MainViewModel';

@Entry
@Component
struct MainPage {
  @StorageLink(CommonConstants.KEY_USER_INFO) userInfo: UserInfo = new UserInfo();
  @State currentIndex: number = 0;
  private viewModel = new MainViewModel();

  build() {
    Navigation(this.viewModel.pageContext.navPathStack) {
      NavDestination() {
        Column() {
          this.TabContent()
          CustomTabBar({
            currentIndex: this.currentIndex, tabBarChange: (index: number) => {
              this.changeTabStatus(index);
            }
          })
        }

        // Stack({ alignContent: Alignment.BottomStart }) {
        //   this.TabContent()
        //   CustomTabBar({
        //     currentIndex: this.currentIndex, tabBarChange: (index: number) => {
        //       this.changeTabStatus(index);
        //     }
        //   })
        // }
      }.onShown(() => {
        this.viewModel.updateBlueRenderGroup(false)
      })
      .onHidden(() => {
        this.viewModel.updateBlueRenderGroup(true)
      })
      .hideTitleBar(true)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .height('100%')
    .width('100%')
  }

  @Builder
  TabContent() {
    //tabs内容列表，系统会根据index自动显示对应的tab内容
    Tabs({ controller: this.viewModel.tabController, index: this.currentIndex }) {
      TabContent() {
        FrequencyPage()
      }

      TabContent() {
        SmartPage()
      }

      TabContent() {
        CategoryPage()
      }

      TabContent() {
        MinePage()
      }
    }
    .onAttach(() => {
      this.viewModel.preloadItems([0, 1])
    })
    .onAnimationStart((index: number, targetIndex: number) => {
      this.changeTabStatus(targetIndex);
    })
    .animationMode(AnimationMode.CONTENT_FIRST_WITH_JUMP)
    .barWidth(0)
    .barHeight(0)
    .scrollable(true) //指定可以左右滑动，如果要禁止左右滑动写false即可
    .backgroundColor($r('sys.color.background_secondary'))
    .layoutWeight(1)
  }

  changeTabStatus(index: number) {
    // AppStorage.setOrCreate(StorageKey.Main_CURRENT_TAB, currentIndex);
    this.currentIndex = index;
  }

  onBackPress(): boolean | void {
    return this.viewModel.backPress(this.getUIContext())
  }
}