import { GlobalInfoModel, StorageKey, ToastUtil } from 'base';
import { CommonConstants, GridComponent } from 'common';
import { GridItemComponent } from './GridItemComponent';

@Component
export struct SceneSubTabContent {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @Prop title: string
  @State private sceneList: string[] = [];

  aboutToAppear(): void {
    for (let index = 0; index < 100; index++) {
      this.sceneList.push(this.title + ':' + index)
    }
  }

  build() {
    GridComponent({
      dataList: this.sceneList,
      gridItemContent: (scene) => {
        this.buildGridItem(scene)
      },
      gridHeight: this.globalInfoModel.deviceHeight - this.globalInfoModel.statusBarHeight -
      this.globalInfoModel.naviIndicatorHeight
        - CommonConstants.TAB_BAR_HEIGHT - CommonConstants.SegmentButton_HEIGHT - CommonConstants.SearchButton_HEIGHT -
      CommonConstants.SegmentButton_Margin + 2
    })
  }

  @Builder
  buildGridItem(scene: string) {
    GridItemComponent({
      title: scene,
      itemClick: (item: string) => {
        ToastUtil.showToast('item:' + item)
      },
    })
  }
}