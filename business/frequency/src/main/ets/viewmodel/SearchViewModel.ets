import { HomeViewModel } from 'common'

export class SearchViewModel extends HomeViewModel {
  //返回
  jumpBack() {
    this.pageContext.popPage()
  }
}