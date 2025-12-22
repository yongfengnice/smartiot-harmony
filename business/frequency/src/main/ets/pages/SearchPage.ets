import { BaseConstants, GlobalInfoModel, StorageKey, ToastUtil } from 'base';
import { GridComponent } from 'common';
import { SearchViewModel } from '../viewmodel/SearchViewModel';

@Builder
export function SearchPageBuilder() {
  NavDestination() {
    SearchPage()
  }.hideTitleBar(true)
}

@Component
export struct SearchPage {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @State message: string = 'SearchPage';
  @State inputText: string = '123';
  @State searchList: string[] = ['123', '456'];
  controller: TextInputController = new TextInputController();
  private searchViewModel = new SearchViewModel();

  build() {
    Column() {
      Blank()
        .height(this.globalInfoModel.statusBarHeight)
        .color(Color.White)
      this.buildSearchTitle()
      this.buildSearchClear()
      this.buildSearchList()
    }
    .width(BaseConstants.MATCH_PARENT)
    .height(BaseConstants.MATCH_PARENT)
  }

  @Builder
  buildSearchClear() {
    Row() {
      Text('历史记录')
        .layoutWeight(1)
      Text('清空')
        .onClick(() => {
          this.searchList = []
        })
    }.padding({
      left: 12,
      right: 12
    })
  }

  @Builder
  buildSearchList() {
    GridComponent({
      dataList: this.searchList
    })
  }

  @Builder
  buildSearchTitle() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(20)
        .height(20)
        .onClick(() => {
          this.searchViewModel.jumpBack()
        })

      Row() {
        Image($r('app.media.search'))
          .width(16)
          .height(16)
          .margin(6)
        //this.inputText这样写获取不到文本，this.inputText!!多两个!这样写才能获取，什么垃圾玩意？？
        TextInput({ text: this.inputText!!, placeholder: '搜索', controller: this.controller })
          .fontSize(14)
          .height(32)
          .layoutWeight(1)
          .padding(0)
          .backgroundColor(Color.Transparent)
          .enterKeyType(EnterKeyType.Search)
          .onSubmit(() => {
            ToastUtil.showToast('搜索：' + this.inputText)
            this.searchList.push(this.inputText)
            this.inputText = ''
          })

      }
      .margin(6)
      .width(BaseConstants.MATCH_PARENT)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({
        color: Color.Grey,
        width: 1,
        radius: 6
      })
      .layoutWeight(1)

      Image($r('app.media.ic_edit_fliter'))
        .width(24)
        .height(24)
        .margin({
          left: 6,
        })
    }.justifyContent(FlexAlign.Start)
    .backgroundColor(Color.White)
    .padding(12)
  }
}