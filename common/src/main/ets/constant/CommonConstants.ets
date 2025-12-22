export class CommonConstants {
  static KEY_USER_INFO: string = 'key_user_info';
  static PRESS_TIME = 1500;
  static TAB_BAR_HEIGHT: number = 48;
  static SegmentButton_Margin: number = 10;
  static SegmentButton_HEIGHT: number = 40;
  static SearchButton_HEIGHT: number = 56;
  public static readonly PROMISE_WAIT = (delay: number) => new Promise<void>((resolve) => setTimeout(resolve, delay));
}