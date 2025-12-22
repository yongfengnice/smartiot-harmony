import { GlobalInfoModel, StorageKey, ToastUtil } from 'base';
import { CommonConstants, GridComponent } from 'common';
import { GridItemComponent } from './GridItemComponent';

@Component
export struct DeviceSubTabContent {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @Prop title: string
  @State private deviceList: string[] = [];

  aboutToAppear(): void {
    for (let index = 0; index < 100; index++) {
      this.deviceList.push(this.title + ':' + index)
    }
  }

  build() {
    GridComponent({
      dataList: this.deviceList,
      gridItemContent: (device) => {
        this.buildGridItem(device)
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
      }
    })
  }
}