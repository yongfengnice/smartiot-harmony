import { HomeViewModel } from 'common';

export class CategoryViewModel extends HomeViewModel {
  dialogCreateAddList: string[] = ['添加设备', '扫一扫', '创建群组', '创建手动情景', '创建自动情景', '添加场所']
  tabsController = new TabsController()

  jumpToSearchPage() {
    this.pageContext.openPage({
      routerName: 'SearchPage',
    })
  }
}