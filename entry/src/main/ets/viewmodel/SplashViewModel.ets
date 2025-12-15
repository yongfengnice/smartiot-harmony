import { PageContext } from 'base';
import { StorageKey } from 'base/src/main/ets/constant/BaseEnums';
import { BaseState, BaseVM, BaseVMEvent } from 'common';

export class SplashViewModel extends BaseVM<BaseState> {
  private homePageContext: PageContext = AppStorage.get(StorageKey.HOME_PAGE_CONTEXT) as PageContext;

  public constructor() {
    super(new BaseState());
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