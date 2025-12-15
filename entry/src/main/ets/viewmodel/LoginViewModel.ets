import { BaseState, BaseVM } from 'common';

export class LoginViewModel extends BaseVM<BaseState> {
  constructor() {
    super(new BaseState())
  }

  //
  isNameOrPwdEmpty(username: string, password: string): boolean {
    return username.length <= 0 || password.length <= 0
  }
}