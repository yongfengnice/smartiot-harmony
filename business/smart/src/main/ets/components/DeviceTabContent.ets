import { ToastUtil } from 'base';
import { GridComponent } from 'common';

@Component
export struct DeviceTabContent {
  @State private sceneList: string[] = [];

  aboutToAppear(): void {
    for (let index = 0; index < 100; index++) {
      this.sceneList.push('自动化：' + index)
    }
  }

  build() {
    GridComponent({
      dataList: this.sceneList,
      itemClick: (item: string) => {
        ToastUtil.showToast('item:' + item)
      }
    })
  }
}