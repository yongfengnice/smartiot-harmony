import { PageContext, StorageKey } from 'base';
import { BaseState } from './BaseState';
import { BaseVM } from './BaseVM';

export class HomeViewModel extends BaseVM<BaseState> {
  pageContext: PageContext = AppStorage.get(StorageKey.HOME_PAGE_CONTEXT) as PageContext;

  constructor() {
    super(new BaseState())
  }
}