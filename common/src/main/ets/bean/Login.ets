export interface LoginRequest {
  imei: string, //1104a897939811e0089
  push_device_token: string //1104a897939811e0089
  package_id: string //com.jinpeng.smart.iot.development
  app_phonenumber: string //17724254272
  app_login_pass: string //123456ab的md5值
}

export interface LoginResponse {
  current_house_id: number,
  app_user_id: number,
  app_phonenumber: string,
  app_nickname: string,
  access_token: string
  push_device_token: string,
  package_id: string,
  imei: string,
  username: string,
  password: string,
}