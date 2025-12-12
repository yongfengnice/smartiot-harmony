import { PageContext } from 'base';
import { StorageKey } from 'base/src/main/ets/constant/BaseEnums';
import { BaseState, BaseVM, BaseVMEvent } from 'common';

export class SplashViewModel extends BaseVM<BaseState> {
  private homePageContext: PageContext = AppStorage.get(StorageKey.HOME_PAGE_CONTEXT) as PageContext;

  public constructor() {
    super(new BaseState());
  }

  public sendEvent(eventType: BaseVMEvent): void {
    if (eventType === SplashEventTypeEnum.JUMP_TO_MAIN) {
      this.jumpToMainPage();
    } else if (eventType === SplashEventTypeEnum.JUMP_TO_LOGIN) {
      this.jumpToLoginPage();
    }
  }

  jumpToLoginPage() {
    this.homePageContext.replacePage({
      routerName: 'LoginPage'
    })
  }

  jumpToMainPage() {
    this.homePageContext.replacePage({
      routerName: 'MainPage'
    })
  }
}

export enum SplashEventTypeEnum {
  JUMP_TO_MAIN = 'jumpToMainPage',
  JUMP_TO_LOGIN = 'jumpToLoginPage',
}