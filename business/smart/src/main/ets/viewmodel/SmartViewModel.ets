import { HomeViewModel } from 'common';

export class SmartViewModel extends HomeViewModel {
  dialogCreateAddList: string[] = ['创建手动情景', '创建自动情景']
  tabsController = new TabsController()

  jumpToSearchPage() {
    this.pageContext.openPage({
      routerName: 'SearchPage',
    })
  }
}