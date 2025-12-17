import { Logger, ProcessUtil, StorageKey, ToastUtil } from 'base';
import { CommonConstants, HomeViewModel } from 'common';
import { common } from '@kit.AbilityKit';

export class MainViewModel extends HomeViewModel {
  private backPressTime: number = 0;
  tabController: TabsController = new TabsController();
  private tag: string = 'MainPage'

  updateBlueRenderGroup(arg0: boolean) {
    AppStorage.setOrCreate(StorageKey.BLUE_RENDER_GROUP, arg0)
    Logger.debug(this.tag, 'MainPage Nav show arg0' + arg0)
  }

  //预加载
  preloadItems(arg0: number[]) {
    this.tabController.preloadItems(arg0).catch(() => {
      Logger.error(this.tag, '预加载tab0 tab1失败')
    })
  }

  backPress(context: UIContext): boolean | void {
    const newTime = new Date().getTime();
    if (this.backPressTime && newTime - this.backPressTime < CommonConstants.PRESS_TIME) {
      ProcessUtil.terminateAbility(context.getHostContext() as common.UIAbilityContext);
      return true;
    }
    this.backPressTime = newTime;
    ToastUtil.showToast($r('app.string.back_toast'));
    return true;
  }
}