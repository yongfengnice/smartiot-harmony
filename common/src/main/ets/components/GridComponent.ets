import { BaseConstants, GlobalInfoModel, StorageKey } from 'base';
import { CommonConstants } from '../constant/CommonConstants';
import { GridDataSource } from '../data/GridDataSource';
import { GridItemComponent } from './GridItemComponent';

@Component
export struct GridComponent {
  @StorageProp(StorageKey.GLOBAL_INFO) globalInfoModel: GlobalInfoModel = AppStorage.get(StorageKey.GLOBAL_INFO)!;
  @Prop @Watch('dataListChange') dataList: string[]
  @State private sceneList: GridDataSource = new GridDataSource([]);
  @BuilderParam gridItemContent?: (title: string) => void;
  scroller: Scroller = new Scroller();
  itemClick?: ((title: string) => void);
  gridHeight: number = 0

  aboutToAppear(): void {
    this.sceneList = new GridDataSource(this.dataList)
    if (this.gridHeight == 0) {
      //手动计算出列表的高度，不然最后一行item被遮住显示不全，具体原因还不知道
      // 40是SegmentButton高度，56是搜索栏高度，10是SegmentButton和搜索栏的间距，10是搜索栏和列表的间距
      this.gridHeight = this.globalInfoModel.deviceHeight - this.globalInfoModel.statusBarHeight -
      this.globalInfoModel.naviIndicatorHeight
        - CommonConstants.TAB_BAR_HEIGHT - CommonConstants.SegmentButton_HEIGHT - 56 - 10 - 10;
    }
  }

  build() {
    Grid(this.scroller) {
      LazyForEach(this.sceneList, (scene: string) => {
        GridItem() {
          if (this.gridItemContent) {
            this.gridItemContent(scene)
          } else {
            GridItemComponent({
              title: scene,
              itemClick: this.itemClick
            })
          }
        }
      }, (item: string, index: number) => item + index) //要自定义key，不然数据变化了不会刷新页面
    }
    .rowsGap(10)
    .columnsGap(10)
    .enableScrollInteraction(true)
    .scrollBar(BarState.On)
    .scrollBarColor(Color.Grey)
    .scrollBarWidth(4)
    .columnsTemplate('1fr 1fr') //必须指定才能滑动
    .layoutDirection(GridDirection.Column)
    .padding({
      left: 10,
      right: 10,
      bottom: 10
    })
    .width(BaseConstants.MATCH_PARENT)
    .height(this.gridHeight)
  }

  dataListChange(changedPropertyName: string) {
    this.sceneList.notifyDatasetChanged(this.dataList)
  }
}