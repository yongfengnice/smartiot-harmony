import { HomeViewModel } from 'common';

export class LogoutViewModel extends HomeViewModel {

  jumpToSearchPage() {
    this.pageContext.openPage({
      routerName: 'SearchPage',
    })
  }

  //返回
  jumpBack() {
    this.pageContext.popPage()
  }
}