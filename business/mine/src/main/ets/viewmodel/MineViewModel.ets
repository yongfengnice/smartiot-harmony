import { HomeViewModel } from "common";

export class MineViewModel extends HomeViewModel{
  scroller: Scroller = new Scroller();

  jumpToLogoutPage() {
    this.pageContext.openPage({
      routerName: 'LogoutPage',
    })
  }
}