import { BasicDataSource } from './BasicDataSource';

// GridDataSource.ets
export class GridDataSource extends BasicDataSource {
  private dataArray: string[] = [];

  constructor(dataList: string[]) {
    super();
    this.dataArray = dataList;
  }

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): string {
    return this.dataArray[index];
  }

  public pushData(data: string): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }


  //test
  operateData(): void {
    const totalCount = this.dataArray.length;
    const batch = 5;
    for (let i = totalCount; i < totalCount + batch; i++) {
      this.dataArray.push(`Hello ${i}`);
    }
    // 替换 notifyDataReload
    this.notifyDatasetChange([{ type: DataOperationType.ADD, index: totalCount - 1, count: batch }]);
  }

  notifyDatasetChanged(newDataList: string[]): void {
    this.dataArray = newDataList;
    this.notifyDatasetChange([{ type: DataOperationType.CHANGE, index: 0 }])
  }
}