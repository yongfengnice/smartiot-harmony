import { BaseConstants, GlobalInfoModel, StorageKey, ToastUtil } from 'base';
import { SceneTabContent } from '../components/SceneTabContent';
import { LengthMetrics, SegmentButton, SegmentButtonItemTuple, SegmentButtonOptions } from '@kit.ArkUI';
import { CategoryViewModel } from '../viewmodel/CategoryViewModel';
import { CommonConstants, CreateAddDialog } from 'common';
import { DeviceTabContent } from '../components/DeviceTabContent';

@Component
export struct CategoryPage {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @State @Watch('tabSelectedChange') tabSelectedIndexes: number[] = [0];
  private categoryViewModel = new CategoryViewModel()
  @State singleSelectCapsuleOptions: SegmentButtonOptions = SegmentButtonOptions.capsule({
    buttons: [{ text: '场所123' }, { text: '设备456' }] as SegmentButtonItemTuple,
    multiply: false,
    fontColor: Color.Grey,
    selectedFontColor: Color.White,
    backgroundColor: $r('app.color.color_grey'),
    selectedBackgroundColor: $r('app.color.color_main'),
    backgroundBlurStyle: BlurStyle.BACKGROUND_THICK,
    //不生效？？ start-- borderRadiusMode: BorderRadiusMode.CUSTOM, api20以后才支持
    backgroundBorderRadius: LengthMetrics.vp(8),
    itemBorderRadius: LengthMetrics.vp(6), //不生效 --end
    fontSize: 14,
    selectedFontSize: 14,
    textPadding: {
      top: 6,
      bottom: 6,
    }
  });

  build() {
    Column() {
      Blank()
        .height(this.globalInfoModel.statusBarHeight)
        .color(Color.White)
      Row() {
        Blank().layoutWeight(1)

        SegmentButton({
          options: this.singleSelectCapsuleOptions,
          selectedIndexes: this.tabSelectedIndexes
        }).width(168)
          .height(CommonConstants.SegmentButton_HEIGHT)

        Row() {
          Image($r('app.media.search'))
            .width(20)
            .height(20)
            .onClick(() => {
              this.categoryViewModel.jumpToSearchPage()
            })
          Blank().width(12)
          Image($r('app.media.create_add'))
            .width(20)
            .height(20)
            .bindMenu(this.dialogRightFuction())

        }.layoutWeight(1)
        .justifyContent(FlexAlign.End)

      }
      .width(BaseConstants.MATCH_PARENT)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)
      .padding({
        left: 12,
        right: 12,
        top: 10
      })

      Tabs({ controller: this.categoryViewModel.tabsController }) {
        TabContent() {
          SceneTabContent()
        }
        .height(BaseConstants.MATCH_PARENT)

        TabContent() {
          DeviceTabContent()
        }.backgroundColor(Color.Orange)
        .height(BaseConstants.MATCH_PARENT)
      }
      .height(BaseConstants.MATCH_PARENT)
      // .onChange((index) => {
      //   this.tabSelectedIndexes[0] = index;
      // })
      .onAnimationStart((index: number, targetIndex: number) => {
        this.tabSelectedIndexes[0] = targetIndex;
      })
      .barWidth(0)
      .barHeight(0)
      .animationMode(AnimationMode.NO_ANIMATION)
      .scrollable(false) //禁用左右滑动
    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
    .backgroundColor(Color.White)
  }

  tabSelectedChange(name: string) {
    ToastUtil.showToast(this.tabSelectedIndexes[0].toString());
    this.categoryViewModel.tabsController.changeIndex(this.tabSelectedIndexes[0])
  }

  @Builder
  dialogRightFuction() {
    CreateAddDialog({
      titleList: this.categoryViewModel.dialogCreateAddList,
      itemClick: (title, index) => {
        ToastUtil.showToast('item:' + title + ',index:' + index)
      }
    })
  }
}
