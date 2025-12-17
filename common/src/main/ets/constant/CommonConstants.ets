export class CommonConstants {
  static KEY_USER_INFO: string = 'key_user_info';
  static PRESS_TIME = 1500;
  static TAB_BAR_HEIGHT: number = 48;

  public static readonly PROMISE_WAIT = (delay: number) => new Promise<void>((resolve) => setTimeout(resolve, delay));
}