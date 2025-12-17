import { HomeViewModel } from "common"

export class FrequencyViewModel extends HomeViewModel {

  jumpToSearchPage() {
    this.pageContext.openPage({
      routerName: 'SearchPage',
    })
  }

}