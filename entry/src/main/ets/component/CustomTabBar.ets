/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { StorageKey } from 'base/src/main/ets/constant/BaseEnums';
import { GlobalInfoModel } from 'base/src/main/ets/model/GlobalInfoModel';
import { CommonConstants } from 'common';
import { TabBarData, TABS_LIST } from '../model/TabBarModel';

@Component
export struct CustomTabBar {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @StorageProp(StorageKey.BLUE_RENDER_GROUP) blurRenderGroup: boolean = false;
  @Prop @Require currentIndex: number;
  tabBarChange: (index: number) => void = (index: number) => {
  };

  @Builder
  TabItemBuilder(tabBar: TabBarData) {
    Column() {
      Image(tabBar.id === this.currentIndex ? tabBar.selectedIcon : tabBar.normalIcon)
        .width(24)
        .height(24)
      Text(tabBar.title)
        .fontSize($r('sys.float.Caption_M'))
        .margin({ top: $r('sys.float.padding_level1') })
        .fontWeight(FontWeight.Medium)
        .fontColor(tabBar.id === this.currentIndex ? $r('sys.color.interactive_active') : $r('sys.color.font_tertiary'))
    }
    .width('100%')
    .height('100%')
    .onClick(() => {
      if (this.currentIndex !== tabBar.id) {
        this.tabBarChange(tabBar.id);
      }
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Flex({
      direction: FlexDirection.ColumnReverse,
      alignItems: ItemAlign.Center,
    }) {
      Flex({
        direction: FlexDirection.Row,
        alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.SpaceAround,
      }) {
        ForEach(TABS_LIST, (item: TabBarData) => {
          this.TabItemBuilder(item)
        }, (item: TabBarData) => JSON.stringify(item) + this.currentIndex)
      }
      .size({ width: '100%', height: CommonConstants.TAB_BAR_HEIGHT })
      .margin({
        bottom: this.globalInfoModel.naviIndicatorHeight,
      })

      //bottom tab的分割线
      Divider()
        .vertical(false)
        .color($r('sys.color.comp_divider'))
    }
    .size({ width: '100%', height: CommonConstants.TAB_BAR_HEIGHT + this.globalInfoModel.naviIndicatorHeight })
    .backgroundBlurStyle(BlurStyle.COMPONENT_THICK)
    .renderGroup(this.blurRenderGroup)
  }
}