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

export interface TabBarData {
  id: number;
  title: ResourceStr;
  normalIcon: Resource;
  selectedIcon: Resource;
}

export const TABS_LIST: TabBarData[] = [
  {
    id: 0,
    normalIcon: $r('app.media.ic_btn_main_tab_frequent'),
    selectedIcon: $r('app.media.ic_btn_main_tab_frequent_selected'),
    title: $r('app.string.tab_home'),
  },
  {
    id: 1,
    normalIcon: $r('app.media.ic_btn_main_tab_smart'),
    selectedIcon: $r('app.media.ic_btn_main_tab_smart_selected'),
    title: $r('app.string.tab_smart'),
  },
  {
    id: 2,
    normalIcon: $r('app.media.ic_btn_main_tab_category'),
    selectedIcon: $r('app.media.ic_btn_main_tab_category_selected'),
    title: $r('app.string.tab_category'),
  },
  {
    id: 3,
    normalIcon: $r('app.media.ic_btn_main_tab_mine'),
    selectedIcon: $r('app.media.ic_btn_main_tab_mine_selected'),
    title: $r('app.string.tab_mine'),
  },
]