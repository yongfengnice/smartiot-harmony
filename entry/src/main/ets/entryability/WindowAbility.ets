import window from '@ohos.window';
import { PageContext, WindowUtil } from 'base';
import { StorageKey } from 'base/src/main/ets/constant/BaseEnums';
import { CommonConstants, UserInfo } from 'common';

export class WindowAbility {
  private static instance: WindowAbility = new WindowAbility()

  static getInstance(): WindowAbility {
    return WindowAbility.instance;
  }

  onWindowCreate(windowStage: window.WindowStage) {
    AppStorage.setOrCreate(StorageKey.HOME_PAGE_CONTEXT, new PageContext());
  }

  onContentLoad(windowStage: window.WindowStage) {
    WindowUtil.initialize(windowStage)
    PersistentStorage.persistProp<UserInfo>(CommonConstants.KEY_USER_INFO, new UserInfo())
  }
}