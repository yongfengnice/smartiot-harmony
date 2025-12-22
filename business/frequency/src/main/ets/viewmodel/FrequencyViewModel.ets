import { HomeViewModel } from 'common';

export class FrequencyViewModel extends HomeViewModel {
  scrollerForScroll: Scroller = new Scroller();
  scrollerForList: Scroller = new Scroller();
  listArr: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'];
  maxScrollY: number = 180
  scrollY: number = 0
  titleHeight: number = 52

  jumpToSearchPage() {
    this.pageContext.openPage({
      routerName: 'SearchPage',
    })
  }
}